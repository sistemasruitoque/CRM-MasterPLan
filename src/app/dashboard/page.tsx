"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import Link from "next/link"
import { supabase } from "@/lib/supabase"
import { formatCurrency, normalizePeriod, currentPeriod, distributePagos, fetchAllPlanesPago } from "@/lib/utils"
import { Users, DollarSign, CreditCard, AlertTriangle, ArrowUpRight, ArrowDownRight } from "lucide-react"
import type { Socio, PlanPago, Pago } from "@/types"
import pactadoPlanes from "@/../data/pago_pactado_planes.json"

const pactadoMap = new Map(pactadoPlanes.map(p => [p.certificado_no, p.schedules as unknown as Record<string, number>]))

export default function DashboardPage() {
  const router = useRouter()
  const [socios, setSocios] = useState<Socio[]>([])
  const [planes, setPlanes] = useState<PlanPago[]>([])
  const [pagos, setPagos] = useState<Pago[]>([])
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
        fetchAllPlanesPago(supabase),
        supabase.from("pagos").select("*"),
      ])
      if (sociosRes.data) setSocios(sociosRes.data)
      if (planesRes) setPlanes(planesRes)
      if (pagosRes.data) setPagos(pagosRes.data)
    } catch {
      // Supabase not configured yet — use demo data
    }
    setLoading(false)
  }

  const nowPeriod = currentPeriod()
  const grouped: Record<string, PlanPago[]> = {}
  for (const p of planes) {
    if (!grouped[p.socio_id]) grouped[p.socio_id] = []
    grouped[p.socio_id].push(p)
  }
  for (const socio of socios) {
    if (!grouped[socio.id] && pactadoMap.has(socio.certificado_no)) {
      const schedules = pactadoMap.get(socio.certificado_no)!
      let plan: PlanPago[] = Object.entries(schedules).map(([periodo, monto]) => ({
        id: `${socio.id}-${periodo}`,
        socio_id: socio.id,
        periodo,
        monto_proyectado: monto,
        monto_pagado: 0,
        saldo: 0,
        interes_mora: 0,
        interes_mora_fecha: null,
        estado: "pendiente",
        fecha_pago: null,
        created_at: "",
      }))
      plan = distributePagos(plan, pagos, socio.id)
      grouped[socio.id] = plan
    }
  }

  const totalSocios = socios.length || 119
  const totalAportes = socios.reduce((s, p) => s + p.valor_final, 0) || 15236524256
  const totalRecaudado = Object.values(grouped).flat().reduce((s, p) => s + p.monto_pagado, 0) || 6625240280
  const enMora = socios.filter(s => {
    const socioPlanes = grouped[s.id] || []
    if (socioPlanes.length === 0) return false
    const debe = socioPlanes
      .filter(p => normalizePeriod(p.periodo) <= nowPeriod)
      .reduce((sum, p) => sum + p.monto_proyectado, 0)
    const haPagado = socioPlanes
      .reduce((sum, p) => sum + p.monto_pagado, 0)
    return debe > haPagado
  }).length || 97

  const cards = [
    { label: "Total Socios", value: totalSocios.toString(), icon: Users, color: "bg-blue-500" },
    { label: "Total Aportes", value: formatCurrency(totalAportes), icon: DollarSign, color: "bg-emerald-500" },
    { label: "Recaudado", value: formatCurrency(totalRecaudado), icon: CreditCard, color: "bg-violet-500" },
    { label: "En Mora", value: enMora.toString(), icon: AlertTriangle, color: "bg-red-500", link: "/mora" },
  ]

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-emerald-600" />
      </div>
    )
  }

  return (
    <div className="p-6">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-zinc-900">Dashboard</h1>
        <p className="text-zinc-500 text-sm mt-1">Resumen general del club</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        {cards.map((card) => {
          const Icon = card.icon
          const content = (
            <div className="bg-white rounded-xl p-5 shadow-sm border border-zinc-200 transition-shadow hover:shadow-md">
              <div className="flex items-center justify-between mb-3">
                <div className={`${card.color} p-2 rounded-lg`}>
                  <Icon className="h-5 w-5 text-white" />
                </div>
              </div>
              <p className="text-2xl font-bold text-zinc-900">{card.value}</p>
              <p className="text-sm text-zinc-500 mt-1">{card.label}</p>
            </div>
          )
          return card.link ? (
            <Link key={card.label} href={card.link}>
              {content}
            </Link>
          ) : (
            <div key={card.label}>{content}</div>
          )
        })}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-xl p-5 shadow-sm border border-zinc-200">
          <h2 className="font-semibold text-zinc-900 mb-4">Distribución por Categoría</h2>
          <div className="space-y-3">
            {["Fundador", "Fase I", "Fase II"].map((cat) => {
              const count = socios.filter(s => s.categoria === cat).length || [77, 29, 13][["Fundador", "Fase I", "Fase II"].indexOf(cat)]
              const pct = Math.round((count / totalSocios) * 100)
              return (
                <div key={cat}>
                  <div className="flex justify-between text-sm mb-1">
                    <span className="text-zinc-700">{cat}</span>
                    <span className="font-medium text-zinc-900">{count} socios ({pct}%)</span>
                  </div>
                  <div className="w-full bg-zinc-100 rounded-full h-2">
                    <div
                      className="bg-emerald-500 h-2 rounded-full transition-all"
                      style={{ width: `${pct}%` }}
                    />
                  </div>
                </div>
              )
            })}
          </div>
        </div>

        <div className="bg-white rounded-xl p-5 shadow-sm border border-zinc-200">
          <h2 className="font-semibold text-zinc-900 mb-4">Resumen de Cartera</h2>
          <div className="space-y-4">
            <div className="flex justify-between items-center pb-3 border-b border-zinc-100">
              <span className="text-zinc-600">Porción Recaudada</span>
              <div className="flex items-center gap-1 text-emerald-600">
                <ArrowUpRight className="h-4 w-4" />
                <span className="font-semibold">{formatCurrency(totalRecaudado)}</span>
              </div>
            </div>
            <div className="flex justify-between items-center pb-3 border-b border-zinc-100">
              <span className="text-zinc-600">Saldo Pendiente</span>
              <div className="flex items-center gap-1 text-amber-600">
                <ArrowDownRight className="h-4 w-4" />
                <span className="font-semibold">{formatCurrency(totalAportes - totalRecaudado)}</span>
              </div>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-zinc-800 font-medium">Total Cartera</span>
              <span className="font-bold text-lg text-zinc-900">{formatCurrency(totalAportes)}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
