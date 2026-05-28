"use client"

import React, { useEffect, useRef, useState } from "react"
import { useRouter } from "next/navigation"
import { supabase } from "@/lib/supabase"
import { formatCurrency, distributePagos, fetchAllPlanesPago } from "@/lib/utils"
import { Search, ChevronDown, ChevronRight, Calculator, DollarSign, CheckCircle2, Clock, AlertCircle, Receipt, FileDown } from "lucide-react"
import type { Socio, PlanPago, Pago } from "@/types"
import pactadoPlanes from "@/../data/pago_pactado_planes.json"

function generarMeses(): string[] {
  const meses: string[] = []
  let year = 2025, month = 11
  const endYear = 2031, endMonth = 1
  while (year < endYear || (year === endYear && month <= endMonth)) {
    meses.push(`${year}-${String(month).padStart(2, "0")}`)
    month++
    if (month > 12) { month = 1; year++ }
  }
  return meses
}

const meses = generarMeses()

const nomMeses: Record<string, string> = {
  "01":"Ene","02":"Feb","03":"Mar","04":"Abr","05":"May","06":"Jun",
  "07":"Jul","08":"Ago","09":"Sep","10":"Oct","11":"Nov","12":"Dic",
}

function fmtPeriodo(p: string) {
  const [y, m] = p.split("-")
  return `${nomMeses[m] || m} ${y}`
}

function calcularPlanPagos(socio: Socio): PlanPago[] {
  const plan: PlanPago[] = []
  const total = socio.valor_final
  const cuotaBase = Math.round(total * 0.0363) // 3.63% mensual aprox
  let saldo = total

  for (const periodo of meses) {
    const interes = Math.round(saldo * 0.01) // 1% interés mensual
    const cuota = Math.min(cuotaBase + interes, saldo + interes)
    const montoProyectado = cuota

    plan.push({
      id: `${socio.id}-${periodo}`,
      socio_id: socio.id,
      periodo,
      monto_proyectado: montoProyectado,
      monto_pagado: 0,
      saldo: saldo,
      estado: "pendiente",
      fecha_pago: null,
      created_at: "",
    })
    saldo -= cuota
    if (saldo <= 0) break
  }
  return plan
}

function getStatusIcon(estado: string) {
  switch (estado) {
    case "pagado": return <CheckCircle2 className="h-4 w-4 text-emerald-500" />
    case "parcial": return <Clock className="h-4 w-4 text-amber-500" />
    case "exonerado": return <DollarSign className="h-4 w-4 text-blue-500" />
    default: return <AlertCircle className="h-4 w-4 text-zinc-300" />
  }
}

const pactadoMap = new Map(pactadoPlanes.map(p => [p.certificado_no, p.schedules as unknown as Record<string, number>]))

function pactadoToPlanPagos(socio: Socio, schedules: Record<string, number>, pagos: Pago[] = []): PlanPago[] {
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

export default function PagosPage() {
  const router = useRouter()
  const [socios, setSocios] = useState<Socio[]>([])
  const [planesPago, setPlanesPago] = useState<Record<string, PlanPago[]>>({})
  const [pagos, setPagos] = useState<Pago[]>([])
  const [view, setView] = useState<"plan" | "recibidos">("plan")
  const [search, setSearch] = useState("")
  const [expanded, setExpanded] = useState<Set<string>>(new Set())
  const [selectedSocio, setSelectedSocio] = useState<string | null>(null)
  const [tasaInteres, setTasaInteres] = useState(1)
  const [editingId, setEditingId] = useState<string | null>(null)
  const editingRef = useRef<HTMLInputElement | null>(null)
  const planesPagoRef = useRef(planesPago)
  planesPagoRef.current = planesPago

  useEffect(() => {
    if (typeof window !== "undefined" && !localStorage.getItem("club-auth")) {
      router.push("/login")
      return
    }
    loadData()
  }, [])

  async function loadData() {
    try {
      const [{ data: sociosData }, planesData, { data: pagosData }] = await Promise.all([
        supabase.from("socios").select("*").order("certificado_no"),
        fetchAllPlanesPago(supabase),
        supabase.from("pagos").select("*"),
      ])

      if (sociosData && sociosData.length > 0) {
        setSocios(sociosData as Socio[])
        const dbPlanBySocio: Record<string, PlanPago[]> = {}
        if (planesData) {
          for (const p of planesData as PlanPago[]) {
            if (!dbPlanBySocio[p.socio_id]) dbPlanBySocio[p.socio_id] = []
            dbPlanBySocio[p.socio_id].push(p)
          }
        }
        const grouped: Record<string, PlanPago[]> = {}
        for (const socio of sociosData as Socio[]) {
          if (dbPlanBySocio[socio.id]) {
            grouped[socio.id] = dbPlanBySocio[socio.id]
          } else if (pactadoMap.has(socio.certificado_no)) {
            const computed = pactadoToPlanPagos(socio, pactadoMap.get(socio.certificado_no)!, pagosData as Pago[])
            grouped[socio.id] = computed
            const rows = computed.map((p: PlanPago) => ({
              socio_id: p.socio_id,
              periodo: p.periodo,
              monto_proyectado: p.monto_proyectado,
              monto_pagado: p.monto_pagado,
              saldo: p.saldo,
              estado: p.estado,
            }))
            await supabase.from("planes_pago").upsert(rows as any, { onConflict: "socio_id,periodo" })
          }
        }
        setPlanesPago(grouped)
        planesPagoRef.current = grouped
      }
      if (pagosData && pagosData.length > 0) {
        setPagos(pagosData as Pago[])
      }
    } catch {
      // Supabase not configured — use empty state
    }
  }

  function toggleSocio(id: string) {
    setExpanded((prev) => {
      const next = new Set(prev)
      if (next.has(id)) next.delete(id)
      else next.add(id)
      return next
    })
    setSelectedSocio(id)
  }

  function calcularPlan(socio: Socio) {
    const plan = calcularPlanPagos(socio)
    setPlanesPago((prev) => {
      const next: Record<string, PlanPago[]> = { ...prev, [socio.id]: plan }
      planesPagoRef.current = next
      return next
    })
  }

  async function savePlan(socioId: string, silent = false) {
    try {
      const plan = planesPagoRef.current[socioId]
      if (!plan) return
      const rows = plan.map((p: PlanPago) => ({
        socio_id: p.socio_id,
        periodo: p.periodo,
        monto_proyectado: p.monto_proyectado,
        monto_pagado: p.monto_pagado,
        saldo: p.saldo,
        estado: p.estado,
      }))
      const { error: upsertErr } = await supabase.from("planes_pago").upsert(rows as any, { onConflict: "socio_id,periodo" })
      if (upsertErr) { if (!silent) alert("Error al guardar: " + upsertErr.message); return }
      const { data: freshPlanes } = await supabase.from("planes_pago").select("*").eq("socio_id", socioId)
      if (freshPlanes) {
        setPlanesPago((prev) => {
          const next = { ...prev, [socioId]: freshPlanes as PlanPago[] }
          planesPagoRef.current = next
          return next
        })
      }
      if (!silent) alert("Plan guardado exitosamente")
    } catch {
      if (!silent) alert("Conecta Supabase para guardar (funciona en demo)")
    }
  }

  function guardarPlan(socioId: string) { savePlan(socioId, false) }

  const filtered = socios.filter((s) => {
    if (!search) return true
    const q = search.toLowerCase()
    return s.nombre.toLowerCase().includes(q) || String(s.certificado_no).includes(q)
  })

  const totalProyectado = socios.reduce((s, socio) => s + socio.valor_final, 0)
  const totalPagado = Object.values(planesPago).flat().reduce((s, p) => s + p.monto_pagado, 0)

  function exportToExcel() {
    const bom = "\uFEFF"
    const sep = ";"
    const rows = [["No.", "Socio", "Categoría", "Valor Final", "Cuotas", "Proyectado", "Pagado", "Saldo"].join(sep)]
    for (const socio of filtered) {
      const plan = planesPago[socio.id] || []
      const totalCuotas = plan.length
      const pagado = plan.reduce((s, p) => s + p.monto_pagado, 0)
      const proyectado = plan.reduce((s, p) => s + p.monto_proyectado, 0)
      const saldo = proyectado - pagado
      rows.push([socio.certificado_no, `"${socio.nombre}"`, socio.categoria, socio.valor_final, totalCuotas, proyectado, pagado, saldo].join(sep))
    }
    const blob = new Blob([bom + rows.join("\n")], { type: "text/csv;charset=utf-8" })
    const url = URL.createObjectURL(blob)
    const a = document.createElement("a")
    a.href = url
    a.download = "plan_de_pagos.csv"
    a.click()
    URL.revokeObjectURL(url)
  }

  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-zinc-900">Plan de Pagos</h1>
          <p className="text-zinc-500 text-sm mt-1">
            {view === "plan"
              ? `Calendario de cuotas pactadas · ${Object.values(planesPago).flat().length} cuotas registradas`
              : `${pagos.length} pagos recibidos registrados`}
          </p>
        </div>
        <div className="flex items-center gap-3">
          <div className="flex bg-zinc-100 rounded-lg p-0.5">
            <button
              onClick={() => setView("plan")}
              className={`px-3 py-1.5 text-sm rounded-md transition-colors ${view === "plan" ? "bg-white shadow-sm text-zinc-900 font-medium" : "text-zinc-500 hover:text-zinc-700"}`}
            >
              <Calculator className="h-3.5 w-3.5 inline mr-1" />
              Plan
            </button>
            <button
              onClick={() => setView("recibidos")}
              className={`px-3 py-1.5 text-sm rounded-md transition-colors ${view === "recibidos" ? "bg-white shadow-sm text-zinc-900 font-medium" : "text-zinc-500 hover:text-zinc-700"}`}
            >
              <Receipt className="h-3.5 w-3.5 inline mr-1" />
              Recibidos
            </button>
          </div>
          {view === "plan" && (
            <div className="flex items-center gap-2 bg-white px-3 py-2 rounded-lg border border-zinc-200">
              <Calculator className="h-4 w-4 text-zinc-400" />
              <span className="text-sm text-zinc-600">Interés:</span>
              <input
                type="number"
                value={tasaInteres}
                onChange={(e) => setTasaInteres(Number(e.target.value))}
                className="w-16 px-2 py-0.5 border border-zinc-300 rounded text-sm text-center"
              />
              <span className="text-sm text-zinc-600">%</span>
            </div>
          )}
          {view === "plan" && (
            <button
              onClick={exportToExcel}
              className="flex items-center gap-2 px-3 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors text-sm"
            >
              <FileDown className="h-4 w-4" />
              Exportar Excel
            </button>
          )}
        </div>
      </div>

      {view === "plan" ? (
        <div className="bg-white rounded-xl shadow-sm border border-zinc-200 overflow-hidden mb-6">
          <div className="p-4 border-b border-zinc-200">
            <div className="relative max-w-md">
              <Search className="absolute left-3 top-2.5 h-4 w-4 text-zinc-400" />
              <input
                type="text"
                placeholder="Buscar socio..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className="w-full pl-10 pr-4 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none"
              />
            </div>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-zinc-50 text-zinc-600 text-left">
                  <th className="px-4 py-3 w-8" />
                  <th className="px-4 py-3 font-medium">No.</th>
                  <th className="px-4 py-3 font-medium">Socio</th>
                  <th className="px-4 py-3 font-medium">Categoría</th>
                  <th className="px-4 py-3 font-medium text-right">Valor Final</th>
                  <th className="px-4 py-3 font-medium text-right">Cuotas</th>
                  <th className="px-4 py-3 font-medium text-right">Proyectado</th>
                  <th className="px-4 py-3 font-medium text-right">Pagado</th>
                  <th className="px-4 py-3 font-medium text-right">Saldo</th>
                  <th className="px-4 py-3" />
                </tr>
              </thead>
              <tbody className="divide-y divide-zinc-100">
                {filtered.map((socio) => {
                  const plan = planesPago[socio.id] || []
                  const isExpanded = expanded.has(socio.id)
                  const totalCuotas = plan.length
                  const pagado = plan.reduce((s, p) => s + p.monto_pagado, 0)
                  const proyectado = plan.reduce((s, p) => s + p.monto_proyectado, 0)
                  const saldo = proyectado - pagado

                  return (
                    <React.Fragment key={socio.id}>
                      <tr
                        className="hover:bg-zinc-50 transition-colors cursor-pointer"
                        onClick={() => toggleSocio(socio.id)}
                      >
                        <td className="px-4 py-3">
                          {isExpanded ? <ChevronDown className="h-4 w-4 text-zinc-400" /> : <ChevronRight className="h-4 w-4 text-zinc-400" />}
                        </td>
                        <td className="px-4 py-3 text-zinc-900 font-medium">{socio.certificado_no}</td>
                        <td className="px-4 py-3">
                          <span className="font-medium text-zinc-900">{socio.nombre}</span>
                        </td>
                        <td className="px-4 py-3">
                          <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${
                            socio.categoria === "Fundador" ? "bg-purple-100 text-purple-700" :
                            socio.categoria === "Fase I" ? "bg-blue-100 text-blue-700" :
                            socio.categoria === "Fase II" ? "bg-amber-100 text-amber-700" :
                            "bg-emerald-100 text-emerald-700"
                          }`}>{socio.categoria}</span>
                        </td>
                        <td className="px-4 py-3 text-right font-medium text-zinc-900">{formatCurrency(socio.valor_final)}</td>
                        <td className="px-4 py-3 text-right text-zinc-600">{totalCuotas || "-"}</td>
                        <td className="px-4 py-3 text-right text-zinc-700">{proyectado ? formatCurrency(proyectado) : "-"}</td>
                        <td className="px-4 py-3 text-right text-emerald-600 font-medium">{pagado ? formatCurrency(pagado) : "-"}</td>
                        <td className="px-4 py-3 text-right font-bold text-zinc-900">{saldo ? formatCurrency(saldo) : formatCurrency(socio.valor_final)}</td>
                        <td className="px-4 py-3">
                          {!plan.length && (
                            <button
                              onClick={(e) => { e.stopPropagation(); calcularPlan(socio) }}
                              className="text-xs bg-emerald-100 text-emerald-700 px-2 py-1 rounded hover:bg-emerald-200"
                            >
                              Calcular Plan
                            </button>
                          )}
                        </td>
                      </tr>
                      {isExpanded && plan.length > 0 && (
                        <tr key={`${socio.id}-detail`}>
                          <td colSpan={10} className="px-4 py-0 bg-zinc-50">
                            <div className="py-3">
                              <div className="flex gap-2 mb-3">
                                <button
                                  onClick={() => guardarPlan(socio.id)}
                                  className="text-xs bg-emerald-600 text-white px-3 py-1.5 rounded hover:bg-emerald-700"
                                >
                                  Guardar Plan
                                </button>
                                <span className="text-xs text-zinc-500 self-center">
                                  {plan.length} cuotas proyectadas
                                </span>
                              </div>
                              <div className="overflow-x-auto">
                                <table className="w-full text-xs">
                                  <thead>
                                    <tr className="text-zinc-500 border-b border-zinc-200">
                                      <th className="px-2 py-1 text-left">Período</th>
                                      <th className="px-2 py-1 text-right">Proyectado</th>
                                      <th className="px-2 py-1 text-right">Pagado</th>
                                      <th className="px-2 py-1 text-right">Saldo</th>
                                      <th className="px-2 py-1 text-center">Estado</th>
                                      <th className="px-2 py-1" />
                                    </tr>
                                  </thead>
                                  <tbody>
                                    {plan.map((p) => (
                                      <tr key={p.id} className="hover:bg-white border-b border-zinc-100">
                                        <td className="px-2 py-1.5 text-zinc-700 font-medium">{fmtPeriodo(p.periodo)}</td>
                                        <td className="px-2 py-1.5 text-right text-zinc-700">{formatCurrency(p.monto_proyectado)}</td>
                                        <td className="px-2 py-1.5 text-right">
                                          {editingId === p.id ? (
                                            <input
                                              ref={(el) => { editingRef.current = el }}
                                              type="text"
                                              inputMode="numeric"
                                              value={p.monto_pagado}
                                              autoFocus
                                              onChange={(e) => {
                                                const raw = e.target.value.replace(/[^0-9]/g, "")
                                                const val = raw === "" ? 0 : Number(raw)
                                                setPlanesPago((prev) => {
                                                  const next: Record<string, PlanPago[]> = {
                                                    ...prev,
                                                    [socio.id]: (prev[socio.id] || []).map((pp) =>
                                                      pp.id === p.id
                                                        ? { ...pp, monto_pagado: val, estado: (val >= pp.monto_proyectado - val ? "pagado" : val > 0 ? "parcial" : "pendiente") as PlanPago["estado"] }
                                                        : pp
                                                    ),
                                                  }
                                                  planesPagoRef.current = next
                                                  return next
                                                })
                                              }}
                                              onBlur={() => {
                                                setEditingId(null)
                                                savePlan(socio.id, true)
                                              }}
                                              onKeyDown={(e) => {
                                                if (e.key === "Enter") (e.target as HTMLInputElement).blur()
                                                if (e.key === "Escape") { setEditingId(null) }
                                              }}
                                              className="w-28 px-2 py-0.5 border border-zinc-200 rounded text-right text-sm"
                                            />
                                          ) : (
                                            <span
                                              onClick={() => setEditingId(p.id)}
                                              className="cursor-pointer text-zinc-700 hover:bg-zinc-100 px-2 py-0.5 rounded block text-right text-sm"
                                            >
                                              {formatCurrency(p.monto_pagado)}
                                            </span>
                                          )}
                                        </td>
                                        <td className="px-2 py-1.5 text-right font-medium text-zinc-800">{formatCurrency(p.monto_proyectado - p.monto_pagado)}</td>
                                        <td className="px-2 py-1.5 text-center">
                                          <span className="inline-flex items-center gap-1">
                                            {getStatusIcon(p.estado)}
                                            <span className={
                                              p.estado === "pagado" ? "text-emerald-600" :
                                              p.estado === "parcial" ? "text-amber-600" :
                                              p.estado === "exonerado" ? "text-blue-600" : "text-zinc-400"
                                            }>{p.estado}</span>
                                          </span>
                                        </td>
                                        <td className="px-2 py-1.5">
                                          <button
                                            onClick={() => {
                                              setPlanesPago((prev) => {
                                                const next: Record<string, PlanPago[]> = {
                                                  ...prev,
                                                  [socio.id]: (prev[socio.id] || []).map((pp) =>
                                                    pp.id === p.id
                                                      ? { ...pp, estado: (pp.estado === "exonerado" ? "pendiente" : "exonerado") as PlanPago["estado"] }
                                                      : pp
                                                  ),
                                                }
                                                planesPagoRef.current = next
                                                return next
                                              })
                                            }}
                                            className="text-[10px] text-blue-600 hover:text-blue-800"
                                          >
                                            Exonerar
                                          </button>
                                        </td>
                                      </tr>
                                    ))}
                                  </tbody>
                                </table>
                              </div>
                            </div>
                          </td>
                        </tr>
                      )}
                    </React.Fragment>
                  )
                })}
              </tbody>
            </table>
          </div>
        </div>
      ) : (
        <div className="bg-white rounded-xl shadow-sm border border-zinc-200 overflow-hidden mb-6">
          <div className="p-4 border-b border-zinc-200">
            <div className="relative max-w-md">
              <Search className="absolute left-3 top-2.5 h-4 w-4 text-zinc-400" />
              <input
                type="text"
                placeholder="Buscar socio..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className="w-full pl-10 pr-4 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none"
              />
            </div>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-zinc-50 text-zinc-600 text-left">
                  <th className="px-4 py-3 font-medium">Socio</th>
                  <th className="px-4 py-3 font-medium">Cert.</th>
                  <th className="px-4 py-3 font-medium text-right">Monto</th>
                  <th className="px-4 py-3 font-medium text-right">Fecha</th>
                  <th className="px-4 py-3 font-medium">Tipo</th>
                  <th className="px-4 py-3 font-medium">Concepto</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-zinc-100">
                {pagos.filter(p => {
                  const socio = socios.find(s => s.id === p.socio_id)
                  if (!search) return true
                  const q = search.toLowerCase()
                  return socio?.nombre.toLowerCase().includes(q)
                }).map((pago) => {
                  const socio = socios.find(s => s.id === pago.socio_id)
                  return (
                    <tr key={pago.id} className="hover:bg-zinc-50 transition-colors">
                      <td className="px-4 py-3 font-medium text-zinc-900">{socio?.nombre || "—"}</td>
                      <td className="px-4 py-3 text-zinc-600">{socio?.certificado_no || "—"}</td>
                      <td className="px-4 py-3 text-right font-medium text-emerald-600">{formatCurrency(pago.monto)}</td>
                      <td className="px-4 py-3 text-right text-zinc-600">{pago.fecha_pago}</td>
                      <td className="px-4 py-3">
                        <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${
                          pago.tipo === "cuota" ? "bg-emerald-100 text-emerald-700" :
                          pago.tipo === "ajuste" ? "bg-blue-100 text-blue-700" :
                          "bg-zinc-100 text-zinc-600"
                        }`}>{pago.tipo}</span>
                      </td>
                      <td className="px-4 py-3 text-zinc-500 max-w-xs truncate">{pago.concepto}</td>
                    </tr>
                  )
                })}
                {pagos.length === 0 && (
                  <tr>
                    <td colSpan={6} className="px-4 py-8 text-center text-zinc-400">
                      No hay pagos recibidos registrados
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {view === "plan" && Object.keys(planesPago).length > 0 && (
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <SummaryCard label="Total Proyectado" value={formatCurrency(totalProyectado)} color="text-blue-600" bg="bg-blue-50" />
          <SummaryCard label="Total Pagado" value={formatCurrency(totalPagado)} color="text-emerald-600" bg="bg-emerald-50" />
          <SummaryCard label="Saldo Pendiente" value={formatCurrency(totalProyectado - totalPagado)} color="text-amber-600" bg="bg-amber-50" />
          <SummaryCard label="Socios con Plan" value={Object.keys(planesPago).length.toString()} color="text-violet-600" bg="bg-violet-50" />
        </div>
      )}

      {view === "recibidos" && pagos.length > 0 && (
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <SummaryCard label="Total Recibido" value={formatCurrency(pagos.reduce((s, p) => s + p.monto, 0))} color="text-emerald-600" bg="bg-emerald-50" />
          <SummaryCard label="No. de Pagos" value={pagos.length.toString()} color="text-blue-600" bg="bg-blue-50" />
          <SummaryCard label="Socios con Pago" value={new Set(pagos.map(p => p.socio_id)).size.toString()} color="text-violet-600" bg="bg-violet-50" />
          <SummaryCard label="Promedio por Pago" value={formatCurrency(Math.round(pagos.reduce((s, p) => s + p.monto, 0) / pagos.length))} color="text-amber-600" bg="bg-amber-50" />
        </div>
      )}
    </div>
  )
}

function SummaryCard({ label, value, color, bg }: { label: string; value: string; color: string; bg: string }) {
  return (
    <div className={`${bg} rounded-xl p-4 border border-zinc-200`}>
      <p className={`text-lg font-bold ${color}`}>{value}</p>
      <p className="text-sm text-zinc-600 mt-1">{label}</p>
    </div>
  )
}
