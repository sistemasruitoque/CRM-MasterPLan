"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import { supabase } from "@/lib/supabase"
import { formatCurrency, normalizePeriod, currentPeriod, distributePagos } from "@/lib/utils"
import { AlertTriangle, ArrowLeft, Clock, CheckCircle2 } from "lucide-react"
import Link from "next/link"
import type { Socio, PlanPago, Pago } from "@/types"
import pactadoPlanes from "@/../data/pago_pactado_planes.json"

interface SocioMora extends Socio {
  debeTenerPagado: number
  haPagado: number
  mora: number
}

const pactadoMap = new Map(pactadoPlanes.map(p => [p.certificado_no, p.schedules as unknown as Record<string, number>]))

export default function MoraPage() {
  const router = useRouter()
  const [sociosMora, setSociosMora] = useState<SocioMora[]>([])
  const [sociosAlDia, setSociosAlDia] = useState(0)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (typeof window !== "undefined" && !localStorage.getItem("club-auth")) {
      router.push("/login")
      return
    }
    loadData()
  }, [])

  async function loadData() {
    try {
      const [sociosRes, planesRes, pagosRes] = await Promise.all([
        supabase.from("socios").select("*"),
        supabase.from("planes_pago").select("*").range(0, 10000),
        supabase.from("pagos").select("*"),
      ])

      const sociosData: Socio[] = sociosRes.data || []
      const planesData: PlanPago[] = planesRes.data || []
      const pagosData: Pago[] = pagosRes.data || []

      const nowPeriod = currentPeriod()

      const grouped: Record<string, PlanPago[]> = {}
      for (const p of planesData) {
        if (!grouped[p.socio_id]) grouped[p.socio_id] = []
        grouped[p.socio_id].push(p)
      }
      for (const socio of sociosData) {
        if (!grouped[socio.id] && pactadoMap.has(socio.certificado_no)) {
          const schedules = pactadoMap.get(socio.certificado_no)!
          let plan: PlanPago[] = Object.entries(schedules).map(([periodo, monto]) => ({
            id: `${socio.id}-${periodo}`,
            socio_id: socio.id,
            periodo,
            monto_proyectado: monto,
            monto_pagado: 0,
            saldo: 0,
            estado: "pendiente",
            fecha_pago: null,
            created_at: "",
          }))
          plan = distributePagos(plan, pagosData, socio.id)
          grouped[socio.id] = plan
        }
      }

      const enMora: SocioMora[] = []
      let alDia = 0

      for (const socio of sociosData) {
        const socioPlanes = grouped[socio.id] || []
        if (socioPlanes.length === 0) continue

        const debeTenerPagado = socioPlanes
          .filter(p => normalizePeriod(p.periodo) <= nowPeriod)
          .reduce((s, p) => s + p.monto_proyectado, 0)
        const haPagado = socioPlanes
          .reduce((s, p) => s + p.monto_pagado, 0)
        const mora = Math.max(0, debeTenerPagado - haPagado)

        if (mora > 0) {
          enMora.push({ ...socio, debeTenerPagado, haPagado, mora } as SocioMora)
        } else {
          alDia++
        }
      }

      enMora.sort((a, b) => b.mora - a.mora)
      setSociosMora(enMora)
      setSociosAlDia(alDia)
    } catch {
      // fallback
    }
    setLoading(false)
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-emerald-600" />
      </div>
    )
  }

  const totalMora = sociosMora.reduce((s, p) => s + p.mora, 0)
  const totalDebe = sociosMora.reduce((s, p) => s + p.debeTenerPagado, 0)
  const totalPagado = sociosMora.reduce((s, p) => s + p.haPagado, 0)

  return (
    <div className="p-6">
      <div className="flex items-center gap-4 mb-6">
        <Link href="/dashboard" className="p-2 hover:bg-zinc-100 rounded-lg transition-colors">
          <ArrowLeft className="h-5 w-5 text-zinc-600" />
        </Link>
        <div>
          <h1 className="text-2xl font-bold text-zinc-900">Socios en Mora</h1>
          <p className="text-zinc-500 text-sm mt-1">
            {sociosMora.length} socios con mora &middot; {sociosAlDia} al d&iacute;a
          </p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
        <div className="bg-red-50 rounded-xl p-4 border border-red-200">
          <div className="flex items-center gap-2 mb-1">
            <AlertTriangle className="h-4 w-4 text-red-600" />
            <span className="text-sm font-medium text-red-700">En Mora</span>
          </div>
          <p className="text-2xl font-bold text-red-900">{sociosMora.length}</p>
        </div>
        <div className="bg-emerald-50 rounded-xl p-4 border border-emerald-200">
          <div className="flex items-center gap-2 mb-1">
            <CheckCircle2 className="h-4 w-4 text-emerald-600" />
            <span className="text-sm font-medium text-emerald-700">Al D&iacute;a</span>
          </div>
          <p className="text-2xl font-bold text-emerald-900">{sociosAlDia}</p>
        </div>
        <div className="bg-amber-50 rounded-xl p-4 border border-amber-200">
          <div className="flex items-center gap-2 mb-1">
            <Clock className="h-4 w-4 text-amber-600" />
            <span className="text-sm font-medium text-amber-700">Total en Mora</span>
          </div>
          <p className="text-2xl font-bold text-amber-900">{formatCurrency(totalMora)}</p>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm border border-zinc-200 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-zinc-50 text-zinc-600 text-left">
                <th className="px-4 py-3 font-medium">No.</th>
                <th className="px-4 py-3 font-medium">Nombre</th>
                <th className="px-4 py-3 font-medium">Categor&iacute;a</th>
                <th className="px-4 py-3 font-medium text-right">Debe Tener Pagado</th>
                <th className="px-4 py-3 font-medium text-right">Ha Pagado</th>
                <th className="px-4 py-3 font-medium text-right">Mora</th>
                <th className="px-4 py-3 font-medium">Estado</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-zinc-100">
              {sociosMora.map((socio) => (
                <tr key={socio.id} className="hover:bg-zinc-50 transition-colors">
                  <td className="px-4 py-3 font-medium text-zinc-900">{socio.certificado_no}</td>
                  <td className="px-4 py-3">
                    <span className="font-medium text-zinc-900">{socio.nombre}</span>
                  </td>
                  <td className="px-4 py-3">
                    <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${
                      socio.categoria === "Fundador" ? "bg-purple-100 text-purple-700" :
                      socio.categoria === "Fase I" ? "bg-blue-100 text-blue-700" :
                      "bg-amber-100 text-amber-700"
                    }`}>
                      {socio.categoria}
                    </span>
                  </td>
                  <td className="px-4 py-3 text-right font-medium text-zinc-900">
                    {formatCurrency(socio.debeTenerPagado)}
                  </td>
                  <td className="px-4 py-3 text-right font-medium text-emerald-600">
                    {formatCurrency(socio.haPagado)}
                  </td>
                  <td className="px-4 py-3 text-right font-bold text-red-600">
                    {formatCurrency(socio.mora)}
                  </td>
                  <td className="px-4 py-3">
                    <span className="inline-flex items-center gap-1 text-xs font-medium text-red-600">
                      <AlertTriangle className="h-3.5 w-3.5" />
                      En Mora
                    </span>
                  </td>
                </tr>
              ))}
              {sociosMora.length === 0 && (
                <tr>
                  <td colSpan={7} className="px-4 py-12 text-center text-zinc-400">
                    <CheckCircle2 className="h-8 w-8 mx-auto mb-2 text-emerald-400" />
                    <p className="font-medium">No hay socios en mora</p>
                    <p className="text-sm">Todos los socios est&aacute;n al d&iacute;a con sus pagos</p>
                  </td>
                </tr>
              )}
            </tbody>
            <tfoot>
              <tr className="bg-zinc-50 font-medium text-zinc-900">
                <td colSpan={3} className="px-4 py-3 text-right">Totales:</td>
                <td className="px-4 py-3 text-right">{formatCurrency(totalDebe)}</td>
                <td className="px-4 py-3 text-right text-emerald-600">{formatCurrency(totalPagado)}</td>
                <td className="px-4 py-3 text-right text-red-600">{formatCurrency(totalMora)}</td>
                <td />
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  )
}
