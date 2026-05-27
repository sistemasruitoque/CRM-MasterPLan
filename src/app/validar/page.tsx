"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import Link from "next/link"
import { supabase } from "@/lib/supabase"
import { formatCurrency } from "@/lib/utils"
import { ArrowLeft, CheckCircle2, XCircle, AlertTriangle } from "lucide-react"
import type { Socio, PlanPago, Pago } from "@/types"

interface Descuadre {
  certificado_no: number
  nombre: string
  valor_final: number
  monto_pagado_plan: number
  pagado_real_pagos: number
  diferencia: number
}

export default function ValidarPage() {
  const router = useRouter()
  const [descuadres, setDescuadres] = useState<Descuadre[]>([])
  const [totalSocios, setTotalSocios] = useState(0)
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
        supabase.from("planes_pago").select("*"),
        supabase.from("pagos").select("*"),
      ])

      const socios: Socio[] = sociosRes.data || []
      const planes: PlanPago[] = planesRes.data || []
      const pagos: Pago[] = pagosRes.data || []

      setTotalSocios(socios.length)

      const pagosPorSocio: Record<string, number> = {}
      for (const p of pagos) {
        pagosPorSocio[p.socio_id] = (pagosPorSocio[p.socio_id] || 0) + p.monto
      }

      const planPorSocio: Record<string, number> = {}
      for (const p of planes) {
        planPorSocio[p.socio_id] = (planPorSocio[p.socio_id] || 0) + p.monto_pagado
      }

      const result: Descuadre[] = []
      for (const s of socios) {
        const mp = planPorSocio[s.id] || 0
        const pr = pagosPorSocio[s.id] || 0
        if (mp !== pr) {
          result.push({
            certificado_no: s.certificado_no,
            nombre: s.nombre,
            valor_final: s.valor_final,
            monto_pagado_plan: mp,
            pagado_real_pagos: pr,
            diferencia: mp - pr,
          })
        }
      }

      result.sort((a, b) => Math.abs(b.diferencia) - Math.abs(a.diferencia))
      setDescuadres(result)
    } catch {
      // fallback
    }
    setLoading(false)
  }

  const totalOk = totalSocios - descuadres.length
  const totalDif = descuadres.reduce((s, p) => s + p.diferencia, 0)

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-emerald-600" />
      </div>
    )
  }

  return (
    <div className="p-6">
      <div className="flex items-center gap-4 mb-6">
        <Link href="/dashboard" className="p-2 hover:bg-zinc-100 rounded-lg transition-colors">
          <ArrowLeft className="h-5 w-5 text-zinc-600" />
        </Link>
        <div>
          <h1 className="text-2xl font-bold text-zinc-900">Validar Pagos</h1>
          <p className="text-zinc-500 text-sm mt-1">
            Compara monto_pagado (planes_pago) vs pagos reales (pagos)
          </p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
        <div className="bg-emerald-50 rounded-xl p-4 border border-emerald-200">
          <div className="flex items-center gap-2 mb-1">
            <CheckCircle2 className="h-4 w-4 text-emerald-600" />
            <span className="text-sm font-medium text-emerald-700">OK</span>
          </div>
          <p className="text-2xl font-bold text-emerald-900">{totalOk} socios</p>
        </div>
        <div className="bg-red-50 rounded-xl p-4 border border-red-200">
          <div className="flex items-center gap-2 mb-1">
            <XCircle className="h-4 w-4 text-red-600" />
            <span className="text-sm font-medium text-red-700">Descuadrados</span>
          </div>
          <p className="text-2xl font-bold text-red-900">{descuadres.length} socios</p>
        </div>
        <div className="bg-amber-50 rounded-xl p-4 border border-amber-200">
          <div className="flex items-center gap-2 mb-1">
            <AlertTriangle className="h-4 w-4 text-amber-600" />
            <span className="text-sm font-medium text-amber-700">Diferencia Total</span>
          </div>
          <p className="text-2xl font-bold text-amber-900">{formatCurrency(Math.abs(totalDif))}</p>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm border border-zinc-200 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-zinc-50 text-zinc-600 text-left">
                <th className="px-4 py-3 font-medium">No.</th>
                <th className="px-4 py-3 font-medium">Nombre</th>
                <th className="px-4 py-3 font-medium text-right">Valor Final</th>
                <th className="px-4 py-3 font-medium text-right">Pagado (Plan)</th>
                <th className="px-4 py-3 font-medium text-right">Pagado Real (Pagos)</th>
                <th className="px-4 py-3 font-medium text-right">Diferencia</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-zinc-100">
              {descuadres.map((d) => (
                <tr key={d.certificado_no} className="hover:bg-zinc-50 transition-colors">
                  <td className="px-4 py-3 font-medium text-zinc-900">{d.certificado_no}</td>
                  <td className="px-4 py-3 font-medium text-zinc-900">{d.nombre}</td>
                  <td className="px-4 py-3 text-right text-zinc-700">{formatCurrency(d.valor_final)}</td>
                  <td className="px-4 py-3 text-right text-zinc-700">{formatCurrency(d.monto_pagado_plan)}</td>
                  <td className="px-4 py-3 text-right text-zinc-700">{formatCurrency(d.pagado_real_pagos)}</td>
                  <td className={`px-4 py-3 text-right font-bold ${
                    d.diferencia > 0 ? "text-red-600" : "text-emerald-600"
                  }`}>
                    {formatCurrency(Math.abs(d.diferencia))}
                    <span className="text-xs ml-1">{d.diferencia > 0 ? "(plan > real)" : "(real > plan)"}</span>
                  </td>
                </tr>
              ))}
              {descuadres.length === 0 && (
                <tr>
                  <td colSpan={6} className="px-4 py-12 text-center text-zinc-400">
                    <CheckCircle2 className="h-8 w-8 mx-auto mb-2 text-emerald-400" />
                    <p className="font-medium">Todo ok</p>
                    <p className="text-sm">Todos los socios tienen sus pagos cuadrados</p>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}
