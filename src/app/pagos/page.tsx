"use client"

import React, { useEffect, useRef, useState } from "react"
import { useRouter } from "next/navigation"
import { supabase } from "@/lib/supabase"
import { formatCurrency, distributePagos, fetchAllPlanesPago, calcularInteresMora, diasVencidos, diasEntre, hoyStr } from "@/lib/utils"
import { Search, ChevronDown, ChevronRight, DollarSign, CheckCircle2, Clock, AlertCircle, FileDown, Plus, Save, Trash2 } from "lucide-react"
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
      interes_mora: 0,
      interes_mora_fecha: null,
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
        interes_mora: 0,
        interes_mora_fecha: null,
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
  const [search, setSearch] = useState("")
  const [expanded, setExpanded] = useState<Set<string>>(new Set())
  const [selectedSocio, setSelectedSocio] = useState<string | null>(null)
  const [editingPagadoId, setEditingPagadoId] = useState<string | null>(null)
  const [editingMoraId, setEditingMoraId] = useState<string | null>(null)
  const [editingProyectadoId, setEditingProyectadoId] = useState<string | null>(null)
  const [editPagado, setEditPagado] = useState("")
  const [editMora, setEditMora] = useState("")
  const [editProyectado, setEditProyectado] = useState("")
  const editingRef = useRef<HTMLInputElement | null>(null)
  const [editSocioId, setEditSocioId] = useState<string | null>(null)
  const [editRows, setEditRows] = useState<{ periodo: string; proyectado: number; id?: string }[]>([])

  function openEditor(socioId: string) {
    const plan = planesPago[socioId] || []
    setEditRows(plan.map(p => ({ periodo: p.periodo, proyectado: p.monto_proyectado, id: p.id })))
    setEditSocioId(socioId)
  }

  function closeEditor() { setEditSocioId(null); setEditRows([]) }

  function addRow(afterIndex: number) {
    setEditRows(prev => {
      const next = [...prev]
      const last = next[afterIndex] || next[next.length - 1]
      const [y, m] = (last?.periodo || "2025-11").split("-").map(Number)
      const nextM = m + 1 > 12 ? 1 : m + 1
      const nextY = nextM === 1 ? y + 1 : y
      const newPeriodo = `${nextY}-${String(nextM).padStart(2, "0")}`
      next.splice(afterIndex + 1, 0, { periodo: newPeriodo, proyectado: 0 })
      return next
    })
  }

  function removeRow(index: number) {
    setEditRows(prev => prev.filter((_, i) => i !== index))
  }

  async function saveEdits() {
    if (!editSocioId) return
    const socio = socios.find(s => s.id === editSocioId)
    if (!socio || editRows.length === 0) return
    let saldo = socio.valor_final
    const rows = editRows.map(r => {
      const row = {
        socio_id: editSocioId,
        periodo: r.periodo,
        monto_proyectado: r.proyectado,
        monto_pagado: 0,
        saldo,
        estado: "pendiente" as const,
        interes_mora: 0,
        interes_mora_fecha: null,
      }
      saldo -= r.proyectado
      return row
    })
    const { error } = await supabase.from("planes_pago").upsert(rows as any, { onConflict: "socio_id,periodo" })
    if (error) { alert("Error al guardar: " + error.message); return }
    await loadData()
    closeEditor()
  }

  const [ibr, setIbr] = useState<number>(() => {
    if (typeof window !== "undefined") {
      const saved = localStorage.getItem("ibr-rate")
      return saved ? Number(saved) : 9.53
    }
    return 9.53
  })
  const planesPagoRef = useRef(planesPago)
  planesPagoRef.current = planesPago

  useEffect(() => {
    localStorage.setItem("ibr-rate", String(ibr))
  }, [ibr])

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
              interes_mora: p.interes_mora,
              interes_mora_fecha: p.interes_mora_fecha,
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
        interes_mora: p.interes_mora,
        interes_mora_fecha: p.interes_mora_fecha,
      }))
      const { error: upsertErr } = await supabase.from("planes_pago").upsert(rows as any, { onConflict: "socio_id,periodo" })
      if (upsertErr) { if (!silent) alert("Error al guardar: " + upsertErr.message); return }
      if (!silent) {
        const { data: freshPlanes } = await supabase.from("planes_pago").select("*").eq("socio_id", socioId)
        if (freshPlanes) {
          setPlanesPago((prev) => {
            const next = { ...prev, [socioId]: freshPlanes as PlanPago[] }
            planesPagoRef.current = next
            return next
          })
        }
        alert("Plan guardado exitosamente")
      }
    } catch {
      if (!silent) alert("Conecta Supabase para guardar (funciona en demo)")
    }
  }

  function guardarPlan(socioId: string) {
    const plan = planesPagoRef.current[socioId]
    if (!plan) return
    const hoy = hoyStr()
    let changed = false
    const updatedPlan = plan.map(p => {
      if (p.estado === "pagado" || p.estado === "exonerado") return p
      const saldoActual = p.monto_proyectado - p.monto_pagado
      if (saldoActual <= 0) return p
      const dias = diasVencidos(p.periodo)
      if (dias <= 0) return p
      if (p.interes_mora_fecha === hoy) return p
      const moraHoy = calcularInteresMora(saldoActual, dias, ibr)
      if (moraHoy <= 0) return p
      changed = true
      return { ...p, interes_mora: (p.interes_mora || 0) + moraHoy, interes_mora_fecha: hoy }
    })
    if (!changed) { savePlan(socioId, false); return }
    setPlanesPago((prev) => {
      const next = { ...prev, [socioId]: updatedPlan }
      planesPagoRef.current = next
      return next
    })
    savePlan(socioId, false)
  }

  function commitPagado(p: PlanPago, socioId: string) {
    const pagadoVal = editPagado === "" ? 0 : Number(editPagado)
    const saldoAnterior = p.monto_proyectado - p.monto_pagado
    const hoy = hoyStr()
    const dias = diasVencidos(p.periodo)
    const moraHoy = (dias > 0 && saldoAnterior > 0) ? calcularInteresMora(saldoAnterior, dias, ibr) : 0
    const nuevoMora = (p.interes_mora || 0) + moraHoy
    const elUsuarioTocoMora = editingMoraId === p.id
    const moraVal = elUsuarioTocoMora ? (editMora === "" ? 0 : Number(editMora)) : nuevoMora
    setPlanesPago((prev) => {
      const next = { ...prev, [socioId]: (prev[socioId] || []).map((pp) =>
        pp.id === p.id
          ? { ...pp, monto_pagado: pagadoVal, interes_mora: moraVal, interes_mora_fecha: hoy, estado: (pagadoVal >= pp.monto_proyectado ? "pagado" : pagadoVal > 0 ? "parcial" : "pendiente") as PlanPago["estado"] }
          : pp
      )}
      planesPagoRef.current = next
      return next
    })
    setEditingPagadoId(null)
    savePlan(socioId, true)
  }

  function commitMora(p: PlanPago, socioId: string) {
    const moraVal = editMora === "" ? 0 : Number(editMora)
    const hoy = hoyStr()
    setPlanesPago((prev) => {
      const next = { ...prev, [socioId]: (prev[socioId] || []).map((pp) =>
        pp.id === p.id ? { ...pp, interes_mora: moraVal, interes_mora_fecha: hoy } : pp
      )}
      planesPagoRef.current = next
      return next
    })
    setEditingMoraId(null)
    savePlan(socioId, true)
  }

  function commitProyectado(p: PlanPago, socioId: string) {
    const val = editProyectado === "" ? 0 : Number(editProyectado)
    setPlanesPago((prev) => {
      const next = { ...prev, [socioId]: (prev[socioId] || []).map((pp) =>
        pp.id === p.id ? { ...pp, monto_proyectado: val } : pp
      )}
      planesPagoRef.current = next
      return next
    })
    setEditingProyectadoId(null)
    savePlan(socioId, true)
  }

  function addCuota(socioId: string, afterPeriodo: string) {
    setPlanesPago((prev) => {
      const plan = prev[socioId] || []
      const [y, m] = afterPeriodo.split("-").map(Number)
      const nextM = m + 1 > 12 ? 1 : m + 1
      const nextY = nextM === 1 ? y + 1 : y
      const newPeriodo = `${nextY}-${String(nextM).padStart(2, "0")}`
      const newRow: PlanPago = {
        id: `${socioId}-${newPeriodo}`,
        socio_id: socioId,
        periodo: newPeriodo,
        monto_proyectado: 0,
        monto_pagado: 0,
        saldo: 0,
        interes_mora: 0,
        interes_mora_fecha: null,
        estado: "pendiente",
        fecha_pago: null,
        created_at: "",
      }
      const next = { ...prev, [socioId]: [...plan, newRow] }
      planesPagoRef.current = next
      return next
    })
  }

  function deleteCuota(socioId: string, p: PlanPago) {
    setPlanesPago((prev) => {
      const next = { ...prev, [socioId]: (prev[socioId] || []).filter(pp => pp.id !== p.id) }
      planesPagoRef.current = next
      return next
    })
    supabase.from("planes_pago").delete().eq("socio_id", socioId).eq("periodo", p.periodo).then()
    savePlan(socioId, true)
  }

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
            Calendario de cuotas pactadas · {Object.values(planesPago).flat().length} cuotas registradas
          </p>
        </div>
        <div className="flex items-center gap-3">
          <div className="flex items-center gap-1.5 text-sm">
            <label className="text-zinc-500 font-medium">IBR:</label>
            <input
              type="text"
              inputMode="decimal"
              value={ibr}
              onChange={(e) => {
                const raw = e.target.value.replace(",", ".")
                const val = parseFloat(raw)
                if (!isNaN(val)) setIbr(val)
              }}
              className="w-16 px-2 py-1 border border-zinc-300 rounded text-right text-sm font-mono focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none"
            />
            <span className="text-zinc-400">%</span>
          </div>
          <button
            onClick={exportToExcel}
            className="flex items-center gap-2 px-3 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors text-sm"
          >
            <FileDown className="h-4 w-4" />
            Exportar Excel
          </button>
        </div>
      </div>

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
                      <td className="px-4 py-3 text-right font-bold text-zinc-900">{plan.length > 0 ? formatCurrency(saldo) : formatCurrency(socio.valor_final)}</td>
                      <td className="px-4 py-3">
                        {plan.length > 0 ? (
                          <button
                            onClick={(e) => { e.stopPropagation(); openEditor(socio.id) }}
                            className="text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded hover:bg-blue-200"
                          >
                            Editar
                          </button>
                        ) : (
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
                                    <th className="px-2 py-1 text-right">Int. Mora</th>
                                    <th className="px-2 py-1 text-right">Int. Acumulado</th>
                                    <th className="px-2 py-1 text-center">Estado</th>
                                    <th className="px-2 py-1" />
                                    <th className="px-2 py-1 w-16"></th>
                                  </tr>
                                </thead>
                                <tbody>
                                  {plan.map((p) => {
                                    const saldoActual = p.monto_proyectado - p.monto_pagado
                                    const dias = diasVencidos(p.periodo)
                                    const moraCalculada = calcularInteresMora(saldoActual, dias, ibr)
                                    const vencida = dias > 0 && p.estado !== "pagado" && p.estado !== "exonerado"
                                    const totalIntAcum = p.interes_mora || 0
                                    return (
                                      <tr key={p.id} className={`hover:bg-white border-b border-zinc-100 ${vencida ? "bg-red-50" : ""}`}>
                                        <td className="px-2 py-1.5 text-zinc-700 font-medium">{fmtPeriodo(p.periodo)}</td>
                                        <td className="px-2 py-1.5 text-right">
                                          {editingProyectadoId === p.id ? (
                                            <input
                                              type="number"
                                              value={editProyectado}
                                              autoFocus
                                              onChange={e => setEditProyectado(e.target.value)}
                                              onBlur={() => commitProyectado(p, socio.id)}
                                              onKeyDown={e => { if (e.key === "Enter") (e.target as HTMLInputElement).blur(); if (e.key === "Escape") setEditingProyectadoId(null) }}
                                              className="w-24 px-2 py-0.5 border border-zinc-200 rounded text-right text-sm"
                                            />
                                          ) : (
                                            <span onClick={() => { setEditingProyectadoId(p.id); setEditProyectado(String(p.monto_proyectado)) }}
                                              className="cursor-pointer text-zinc-700 hover:bg-zinc-100 px-2 py-0.5 rounded block text-right text-sm"
                                            >{formatCurrency(p.monto_proyectado)}</span>
                                          )}
                                        </td>
                                        <td className="px-2 py-1.5 text-right">
                                          {editingPagadoId === p.id ? (
                                            <input
                                              ref={(el) => { editingRef.current = el }}
                                              type="text"
                                              inputMode="numeric"
                                              value={editPagado}
                                              autoFocus
                                              onChange={(e) => {
                                                const raw = e.target.value.replace(/[^0-9]/g, "")
                                                setEditPagado(raw)
                                              }}
                                              onBlur={() => commitPagado(p, socio.id)}
                                              onKeyDown={(e) => {
                                                if (e.key === "Enter") (e.target as HTMLInputElement).blur()
                                                if (e.key === "Escape") { setEditingPagadoId(null) }
                                              }}
                                              className="w-28 px-2 py-0.5 border border-zinc-200 rounded text-right text-sm"
                                            />
                                          ) : (
                                            <span
                                              onClick={() => { setEditingPagadoId(p.id); setEditPagado(String(p.monto_pagado)) }}
                                              className="cursor-pointer text-zinc-700 hover:bg-zinc-100 px-2 py-0.5 rounded block text-right text-sm"
                                            >
                                              {formatCurrency(p.monto_pagado)}
                                            </span>
                                          )}
                                        </td>
                                        <td className="px-2 py-1.5 text-right font-medium text-zinc-800">{formatCurrency(saldoActual)}</td>
                                        <td className="px-2 py-1.5 text-right">
                                          <span className={`px-2 py-0.5 block text-right text-sm ${moraCalculada > 0 ? "text-red-500" : "text-zinc-400"}`}>
                                            {moraCalculada > 0 ? formatCurrency(moraCalculada) : "-"}
                                          </span>
                                        </td>
                                        <td className="px-2 py-1.5 text-right">
                                          {editingMoraId === p.id ? (
                                            <input
                                              type="text"
                                              inputMode="numeric"
                                              value={editMora}
                                              autoFocus
                                              onChange={(e) => {
                                                const raw = e.target.value.replace(/[^0-9]/g, "")
                                                setEditMora(raw)
                                              }}
                                              onBlur={() => commitMora(p, socio.id)}
                                              onKeyDown={(e) => {
                                                if (e.key === "Enter") (e.target as HTMLInputElement).blur()
                                                if (e.key === "Escape") { setEditingMoraId(null) }
                                              }}
                                              className="w-24 px-2 py-0.5 border border-zinc-200 rounded text-right text-sm"
                                            />
                                          ) : (
                                            <span
                                              onClick={() => { setEditingMoraId(p.id); setEditMora(String(totalIntAcum)) }}
                                              className={`cursor-pointer px-2 py-0.5 rounded block text-right text-sm ${totalIntAcum > 0 ? "text-red-600 font-medium" : "text-zinc-400"}`}
                                            >
                                              {totalIntAcum > 0 ? formatCurrency(totalIntAcum) : "-"}
                                            </span>
                                          )}
                                        </td>
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
                                        <td className="px-2 py-1.5">
                                          <button onClick={() => deleteCuota(socio.id, p)}
                                            className="p-1 hover:bg-red-50 rounded text-red-400 hover:text-red-600">
                                            <Trash2 className="h-3.5 w-3.5" />
                                          </button>
                                        </td>
                                      </tr>
                                    )
                                  })}
                                </tbody>
                                <tfoot>
                                  <tr>
                                    <td colSpan={8} className="px-2 py-2">
                                      <button onClick={() => addCuota(socio.id, plan[plan.length - 1]?.periodo || "2025-11")}
                                        className="flex items-center gap-1 text-xs text-emerald-600 hover:text-emerald-700">
                                        <Plus className="h-3.5 w-3.5" /> Agregar Cuota
                                      </button>
                                    </td>
                                  </tr>
                                </tfoot>
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

      {/* Modal editor */}
      {editSocioId && (
        <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50" onClick={closeEditor}>
          <div className="bg-white rounded-xl shadow-xl w-full max-w-2xl mx-4 max-h-[80vh] flex flex-col" onClick={(e) => e.stopPropagation()}>
            <div className="p-4 border-b border-zinc-200 flex items-center justify-between">
              <h2 className="font-semibold text-zinc-900">
                Editar Cuotas — #{socios.find(s => s.id === editSocioId)?.certificado_no} {socios.find(s => s.id === editSocioId)?.nombre}
              </h2>
              <button onClick={closeEditor} className="text-zinc-400 hover:text-zinc-600 text-lg leading-none">&times;</button>
            </div>
            <div className="overflow-y-auto flex-1 p-4">
              <table className="w-full text-sm">
                <thead>
                  <tr className="text-zinc-500 border-b border-zinc-200">
                    <th className="px-3 py-2 text-left w-8">#</th>
                    <th className="px-3 py-2 text-left">Período</th>
                    <th className="px-3 py-2 text-right">Proyectado</th>
                    <th className="px-3 py-2 w-16"></th>
                    <th className="px-3 py-2 w-16"></th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-zinc-100">
                  {editRows.map((r, i) => (
                    <tr key={i} className="hover:bg-zinc-50">
                      <td className="px-3 py-2 text-zinc-400">{i + 1}</td>
                      <td className="px-3 py-2">
                        <input type="month" value={r.periodo}
                          onChange={e => setEditRows(prev => prev.map((row, j) => j === i ? { ...row, periodo: e.target.value } : row))}
                          className="w-full px-2 py-1 border border-zinc-300 rounded text-sm focus:ring-2 focus:ring-emerald-500 outline-none"
                        />
                      </td>
                      <td className="px-3 py-2">
                        <input type="number" value={r.proyectado}
                          onChange={e => setEditRows(prev => prev.map((row, j) => j === i ? { ...row, proyectado: Number(e.target.value) } : row))}
                          className="w-full text-right px-2 py-1 border border-zinc-300 rounded text-sm focus:ring-2 focus:ring-emerald-500 outline-none"
                        />
                      </td>
                      <td className="px-3 py-2">
                        <button onClick={() => addRow(i)}
                          className="p-1 hover:bg-emerald-50 rounded text-emerald-500 hover:text-emerald-700">
                          <Plus className="h-4 w-4" />
                        </button>
                      </td>
                      <td className="px-3 py-2">
                        <button onClick={() => removeRow(i)}
                          className="p-1 hover:bg-red-50 rounded text-red-400 hover:text-red-600">
                          <Trash2 className="h-4 w-4" />
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
              {editRows.length === 0 && (
                <div className="text-center py-8 text-zinc-400">
                  <p>Sin cuotas</p>
                  <button onClick={() => addRow(-1)} className="mt-2 text-sm text-emerald-600 hover:text-emerald-700">Agregar primera cuota</button>
                </div>
              )}
            </div>
            <div className="p-4 border-t border-zinc-200 flex justify-end gap-3">
              <button onClick={closeEditor} className="px-4 py-2 text-sm text-zinc-600 hover:text-zinc-900">Cancelar</button>
              <button onClick={saveEdits}
                className="flex items-center gap-1.5 px-4 py-2 bg-emerald-600 text-white rounded-lg text-sm font-medium hover:bg-emerald-700">
                <Save className="h-4 w-4" /> Guardar Cambios
              </button>
            </div>
          </div>
        </div>
      )}

      {Object.keys(planesPago).length > 0 && (
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <SummaryCard label="Total Proyectado" value={formatCurrency(totalProyectado)} color="text-blue-600" bg="bg-blue-50" />
          <SummaryCard label="Total Pagado" value={formatCurrency(totalPagado)} color="text-emerald-600" bg="bg-emerald-50" />
          <SummaryCard label="Saldo Pendiente" value={formatCurrency(totalProyectado - totalPagado)} color="text-amber-600" bg="bg-amber-50" />
          <SummaryCard label="Socios con Plan" value={Object.keys(planesPago).length.toString()} color="text-violet-600" bg="bg-violet-50" />
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
