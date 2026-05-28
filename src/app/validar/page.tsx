"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import Link from "next/link"
import { supabase } from "@/lib/supabase"
import { formatCurrency, distributePagos } from "@/lib/utils"
import { ArrowLeft, CheckCircle2, XCircle, AlertTriangle, RefreshCw, Save } from "lucide-react"
import type { Socio, PlanPago, Pago } from "@/types"
import pactadoPlanes from "@/../data/pago_pactado_planes.json"

interface Descuadre {
  certificado_no: number
  nombre: string
  valor_final: number
  monto_pagado_db: number
  monto_pagado_esperado: number
  pagado_real_pagos: number
  diferencia_db: number
  diferencia_esperada: number
  usaPactado: boolean
  socio_id: string
}

const pactadoMap = new Map(pactadoPlanes.map(p => [p.certificado_no, p.schedules as unknown as Record<string, number>]))

export default function ValidarPage() {
  const router = useRouter()
  const [descuadres, setDescuadres] = useState<Descuadre[]>([])
  const [totalSocios, setTotalSocios] = useState(0)
  const [loading, setLoading] = useState(true)
  const [syncing, setSyncing] = useState(false)

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

      const socios: Socio[] = sociosRes.data || []
      const planes: PlanPago[] = planesRes.data || []
      const pagos: Pago[] = pagosRes.data || []

      setTotalSocios(socios.length)

      const pagosPorSocio: Record<string, number> = {}
      for (const p of pagos) {
        pagosPorSocio[p.socio_id] = (pagosPorSocio[p.socio_id] || 0) + p.monto
      }

      const dbPlanPorSocio: Record<string, number> = {}
      for (const p of planes) {
        dbPlanPorSocio[p.socio_id] = (dbPlanPorSocio[p.socio_id] || 0) + p.monto_pagado
      }

      const result: Descuadre[] = []
      for (const s of socios) {
        const pr = pagosPorSocio[s.id] || 0
        const mpDb = dbPlanPorSocio[s.id] || 0
        let mpEsperado = mpDb
        let usaPactado = false

        if (!dbPlanPorSocio[s.id] && pactadoMap.has(s.certificado_no)) {
          usaPactado = true
          const schedules = pactadoMap.get(s.certificado_no)!
          const plan = pactadoToPlan(s, schedules, pagos)
          mpEsperado = plan.reduce((sum, c) => sum + c.monto_pagado, 0)
        }

        const difDb = mpDb - pr
        const difEsp = mpEsperado - pr

        if (difDb !== 0 || difEsp !== 0) {
          result.push({
            certificado_no: s.certificado_no,
            nombre: s.nombre,
            valor_final: s.valor_final,
            monto_pagado_db: mpDb,
            monto_pagado_esperado: mpEsperado,
            pagado_real_pagos: pr,
            diferencia_db: difDb,
            diferencia_esperada: difEsp,
            usaPactado,
            socio_id: s.id,
          })
        }
      }

      result.sort((a, b) => Math.abs(b.diferencia_db) - Math.abs(a.diferencia_db))
      setDescuadres(result)
    } catch {
      // fallback
    }
    setLoading(false)
  }

  async function syncPactadoPlans() {
    setSyncing(true)
    try {
      const [sociosRes, planesRes, pagosRes] = await Promise.all([
        supabase.from("socios").select("*"),
        supabase.from("planes_pago").select("*").range(0, 10000),
        supabase.from("pagos").select("*"),
      ])
      const socios: Socio[] = sociosRes.data || []
      const planes: PlanPago[] = planesRes.data || []
      const pagos: Pago[] = pagosRes.data || []

      let count = 0

      for (const socio of socios) {
        if (!pactadoMap.has(socio.certificado_no)) continue
        const schedules = pactadoMap.get(socio.certificado_no)!
        const plan = pactadoToPlan(socio, schedules, pagos)
        const rows = plan.map(p => ({
          socio_id: p.socio_id,
          periodo: p.periodo,
          monto_proyectado: p.monto_proyectado,
          monto_pagado: p.monto_pagado,
          saldo: p.saldo,
          estado: p.estado,
        }))
        const { error: delErr } = await supabase.from("planes_pago").delete().eq("socio_id", socio.id)
        if (delErr) { console.error(`Error delete socio ${socio.certificado_no}:`, delErr.message); continue }
        const { error: insErr } = await supabase.from("planes_pago").insert(rows as any)
        if (insErr) { console.error(`Error insert socio ${socio.certificado_no}:`, insErr.message); continue }
        count++
      }
      alert(`Sincronizados ${count} planes pactado a la base de datos`)
      loadData()
    } catch {
      alert("Error al sincronizar")
    }
    setSyncing(false)
  }

  const totalOkDb = totalSocios - descuadres.filter(d => d.diferencia_db !== 0).length
  const totalOkEsp = totalSocios - descuadres.filter(d => d.diferencia_esperada !== 0).length
  const totalDifDb = descuadres.reduce((s, p) => s + p.diferencia_db, 0)
  const totalDifEsp = descuadres.reduce((s, p) => s + p.diferencia_esperada, 0)

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
        <div className="flex-1">
          <h1 className="text-2xl font-bold text-zinc-900">Validar Pagos</h1>
          <p className="text-zinc-500 text-sm mt-1">
            Compara monto_pagado (planes_pago DB) vs pagos reales (pagos)
          </p>
        </div>
        <button
          onClick={syncPactadoPlans}
          disabled={syncing}
          className="flex items-center gap-2 px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 disabled:opacity-50 transition-colors text-sm"
        >
          <Save className="h-4 w-4" />
          {syncing ? "Sincronizando..." : "Sincronizar planes pactado a DB"}
        </button>
        <button
          onClick={loadData}
          className="flex items-center gap-2 px-4 py-2 bg-zinc-100 text-zinc-700 rounded-lg hover:bg-zinc-200 transition-colors text-sm"
        >
          <RefreshCw className="h-4 w-4" />
          Recargar
        </button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
        <div className="bg-emerald-50 rounded-xl p-4 border border-emerald-200">
          <div className="flex items-center gap-2 mb-1">
            <CheckCircle2 className="h-4 w-4 text-emerald-600" />
            <span className="text-sm font-medium text-emerald-700">OK (DB actual)</span>
          </div>
          <p className="text-2xl font-bold text-emerald-900">{totalOkDb} socios</p>
        </div>
        <div className="bg-blue-50 rounded-xl p-4 border border-blue-200">
          <div className="flex items-center gap-2 mb-1">
            <CheckCircle2 className="h-4 w-4 text-blue-600" />
            <span className="text-sm font-medium text-blue-700">OK (esperado)</span>
          </div>
          <p className="text-2xl font-bold text-blue-900">{totalOkEsp} socios</p>
        </div>
        <div className="bg-red-50 rounded-xl p-4 border border-red-200">
          <div className="flex items-center gap-2 mb-1">
            <XCircle className="h-4 w-4 text-red-600" />
            <span className="text-sm font-medium text-red-700">Descuadrados (DB)</span>
          </div>
          <p className="text-2xl font-bold text-red-900">{descuadres.filter(d => d.diferencia_db !== 0).length} socios</p>
        </div>
        <div className="bg-amber-50 rounded-xl p-4 border border-amber-200">
          <div className="flex items-center gap-2 mb-1">
            <AlertTriangle className="h-4 w-4 text-amber-600" />
            <span className="text-sm font-medium text-amber-700">Diferencia esperada</span>
          </div>
          <p className="text-2xl font-bold text-amber-900">{formatCurrency(Math.abs(totalDifEsp))}</p>
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
                <th className="px-4 py-3 font-medium text-right">Pagado (DB)</th>
                <th className="px-4 py-3 font-medium text-right">Pagado (Esperado)</th>
                <th className="px-4 py-3 font-medium text-right">Real (Pagos)</th>
                <th className="px-4 py-3 font-medium text-right">Dif DB</th>
                <th className="px-4 py-3 font-medium text-right">Dif Esperada</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-zinc-100">
              {descuadres.map((d) => (
                <tr key={d.certificado_no} className={`hover:bg-zinc-50 transition-colors ${d.usaPactado ? "bg-blue-50/50" : ""}`}>
                  <td className="px-4 py-3 font-medium text-zinc-900">{d.certificado_no}</td>
                  <td className="px-4 py-3 font-medium text-zinc-900">
                    {d.nombre}
                    {d.usaPactado && <span className="ml-2 text-xs text-blue-500 font-normal">(pactado)</span>}
                  </td>
                  <td className="px-4 py-3 text-right text-zinc-700">{formatCurrency(d.valor_final)}</td>
                  <td className="px-4 py-3 text-right text-zinc-700">{formatCurrency(d.monto_pagado_db)}</td>
                  <td className="px-4 py-3 text-right text-zinc-700">{formatCurrency(d.monto_pagado_esperado)}</td>
                  <td className="px-4 py-3 text-right text-zinc-700">{formatCurrency(d.pagado_real_pagos)}</td>
                  <td className={`px-4 py-3 text-right font-bold ${
                    d.diferencia_db > 0 ? "text-red-600" : d.diferencia_db < 0 ? "text-emerald-600" : "text-zinc-400"
                  }`}>
                    {d.diferencia_db !== 0 ? formatCurrency(Math.abs(d.diferencia_db)) : "—"}
                  </td>
                  <td className={`px-4 py-3 text-right font-bold ${
                    d.diferencia_esperada > 0 ? "text-red-600" : d.diferencia_esperada < 0 ? "text-emerald-600" : "text-zinc-400"
                  }`}>
                    {d.diferencia_esperada !== 0 ? formatCurrency(Math.abs(d.diferencia_esperada)) : "—"}
                  </td>
                </tr>
              ))}
              {descuadres.length === 0 && (
                <tr>
                  <td colSpan={8} className="px-4 py-12 text-center text-zinc-400">
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

function pactadoToPlan(socio: Socio, schedules: Record<string, number>, pagos: Pago[]): PlanPago[] {
  let saldo = socio.valor_final
  const plan: PlanPago[] = Object.entries(schedules)
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([periodo, monto]) => {
      const entry: PlanPago = {
        id: `${socio.id}-${periodo}`,
        socio_id: socio.id,
        periodo,
        monto_proyectado: monto,
        monto_pagado: 0,
        saldo,
        estado: "pendiente",
        fecha_pago: null,
        created_at: "",
      }
      saldo -= monto
      return entry
    })
  return distributePagos(plan, pagos, socio.id)
}
