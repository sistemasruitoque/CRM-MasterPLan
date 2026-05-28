"use client"

import { Suspense, useEffect, useMemo, useRef, useState } from "react"
import { useRouter, useSearchParams } from "next/navigation"
import { supabase } from "@/lib/supabase"
import { formatCurrency } from "@/lib/utils"
import { Search, Save, ArrowLeft, ArrowRight, Plus, Trash2 } from "lucide-react"
import type { Socio, PlanPago } from "@/types"

export default function Page() {
  return <Suspense><NuevoPlanPage /></Suspense>
}

const nomMeses: Record<string, string> = {
  "01":"Ene","02":"Feb","03":"Mar","04":"Abr","05":"May","06":"Jun",
  "07":"Jul","08":"Ago","09":"Sep","10":"Oct","11":"Nov","12":"Dic",
}

function fmtPeriodo(p: string) {
  const [y, m] = p.split("-")
  return `${nomMeses[m] || m} ${y}`
}

function generarMeses(desde: string, cantidad: number): string[] {
  const [y, m] = desde.split("-").map(Number)
  const meses: string[] = []
  for (let i = 0; i < cantidad; i++) {
    const yy = y + Math.floor((m + i - 1) / 12)
    const mm = String(((m + i - 1) % 12) + 1).padStart(2, "0")
    meses.push(`${yy}-${mm}`)
  }
  return meses
}

function NuevoPlanPage() {
  const router = useRouter()
  const searchParams = useSearchParams()
  const socioIdParam = searchParams.get("socio_id")

  const [socios, setSocios] = useState<Socio[]>([])
  const [search, setSearch] = useState("")
  const [selectedSocio, setSelectedSocio] = useState<Socio | null>(null)

  const [cuotaBase, setCuotaBase] = useState(0)
  const [interesPct, setInteresPct] = useState(1)
  const [cantidadCuotas, setCantidadCuotas] = useState(36)
  const [fechaInicio, setFechaInicio] = useState("2025-11")
  const [cuotas, setCuotas] = useState<{ periodo: string; proyectado: number; saldo: number }[]>([])
  const [saving, setSaving] = useState(false)
  const [tab, setTab] = useState<"config" | "preview">("config")

  useEffect(() => {
    loadSocios()
  }, [])

  useEffect(() => {
    if (socioIdParam && socios.length > 0) {
      const found = socios.find(s => s.id === socioIdParam)
      if (found) selectSocio(found)
    }
  }, [socioIdParam, socios])

  async function loadSocios() {
    try {
      const { data } = await supabase.from("socios").select("*").order("certificado_no")
      if (data && data.length > 0) setSocios(data as Socio[])
    } catch {}
  }

  function selectSocio(s: Socio) {
    setSelectedSocio(s)
    setCuotaBase(Math.round(s.valor_final * 0.0363))
    setTab("config")
    setCuotas([])
  }

  const filteredSocios = useMemo(() => {
    if (!search) return socios.slice(0, 20)
    const q = search.toLowerCase()
    return socios.filter(s =>
      s.nombre.toLowerCase().includes(q) ||
      s.certificado_no.toString().includes(q) ||
      s.cedula.includes(q)
    ).slice(0, 20)
  }, [search, socios])

  function generarPreview() {
    if (!selectedSocio) return
    const meses = generarMeses(fechaInicio, cantidadCuotas)
    let saldo = selectedSocio.valor_final
    const rows: { periodo: string; proyectado: number; saldo: number }[] = []
    for (const periodo of meses) {
      const interes = Math.round(saldo * (interesPct / 100))
      const proyectado = Math.min(cuotaBase + interes, Math.max(0, saldo + interes))
      rows.push({ periodo, proyectado, saldo })
      saldo -= proyectado
      if (saldo <= 0 && proyectado <= 0) break
    }
    // if there's remaining, add last cuota
    if (saldo > 0 && rows.length > 0) {
      rows[rows.length - 1].proyectado += saldo
      saldo = 0
    }
    setCuotas(rows)
    setTab("preview")
  }

  function updateCuota(index: number, value: number) {
    setCuotas(prev => {
      const next = [...prev]
      next[index] = { ...next[index], proyectado: value }
      // recalc saldos forward
      let saldo = selectedSocio!.valor_final
      for (let i = 0; i < next.length; i++) {
        next[i] = { ...next[i], saldo }
        saldo -= next[i].proyectado
        if (saldo < 0) saldo = 0
      }
      return next
    })
  }

  async function guardarPlan() {
    if (!selectedSocio || cuotas.length === 0) return
    setSaving(true)
    try {
      let saldo = selectedSocio.valor_final
      const rows = cuotas.map(c => {
        const row = {
          socio_id: selectedSocio.id,
          periodo: c.periodo,
          monto_proyectado: c.proyectado,
          monto_pagado: 0,
          saldo,
          estado: "pendiente" as const,
          interes_mora: 0,
          interes_mora_fecha: null,
        }
        saldo -= c.proyectado
        return row
      })
      const { error } = await supabase.from("planes_pago").upsert(rows as any, { onConflict: "socio_id,periodo" })
      if (error) { alert("Error al guardar: " + error.message); return }
      alert("Plan de pagos guardado correctamente")
      router.push("/pagos")
    } catch {
      alert("Conecta Supabase para guardar")
    }
    setSaving(false)
  }

  return (
    <div className="p-6 max-w-5xl mx-auto">
      <div className="flex items-center gap-3 mb-6">
        <button onClick={() => router.back()} className="p-2 hover:bg-zinc-100 rounded-lg">
          <ArrowLeft className="h-5 w-5 text-zinc-600" />
        </button>
        <h1 className="text-2xl font-bold text-zinc-900">Plan de Pagos</h1>
      </div>

      {/* Step indicator */}
      <div className="flex items-center gap-2 mb-6 text-sm">
        {["Seleccionar Socio", "Configurar", "Previsualizar"].map((label, i) => (
          <div key={label} className="flex items-center gap-2">
            <span className={`w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold ${
              (i === 0 && selectedSocio) || (i === 1 && tab === "config") || (i === 2 && tab === "preview")
                ? "bg-emerald-600 text-white" : "bg-zinc-200 text-zinc-500"
            }`}>{i + 1}</span>
            <span className={selectedSocio ? "text-zinc-900" : "text-zinc-400"}>{label}</span>
            {i < 2 && <ArrowRight className="h-4 w-4 text-zinc-300" />}
          </div>
        ))}
      </div>

      {/* Step 1: Select socio */}
      <div className="bg-white rounded-xl shadow-sm border border-zinc-200 mb-6">
        <div className="p-4 border-b border-zinc-200">
          <h2 className="font-semibold text-zinc-900">Socio</h2>
        </div>
        <div className="p-4">
          {selectedSocio ? (
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-zinc-900">#{selectedSocio.certificado_no} — {selectedSocio.nombre}</p>
                <p className="text-sm text-zinc-500">Valor final: {formatCurrency(selectedSocio.valor_final)}</p>
              </div>
              <button onClick={() => { setSelectedSocio(null); setCuotas([]); setTab("config") }}
                className="text-sm text-red-500 hover:text-red-700">Cambiar</button>
            </div>
          ) : (
            <div className="relative">
              <Search className="absolute left-3 top-2.5 h-4 w-4 text-zinc-400" />
              <input
                type="text" placeholder="Buscar socio por nombre, cédula o certificado..."
                value={search} onChange={e => setSearch(e.target.value)}
                className="w-full pl-10 pr-4 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none"
                autoFocus
              />
              {filteredSocios.length > 0 && (
                <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-zinc-200 rounded-lg shadow-lg z-10 max-h-60 overflow-y-auto">
                  {filteredSocios.map(s => (
                    <button key={s.id} onClick={() => selectSocio(s)}
                      className="w-full text-left px-4 py-2.5 hover:bg-emerald-50 text-sm border-b border-zinc-100 last:border-0">
                      <span className="font-medium text-zinc-900">#{s.certificado_no}</span> — {s.nombre}
                    </button>
                  ))}
                </div>
              )}
            </div>
          )}
        </div>
      </div>

      {/* Step 2: Config */}
      {selectedSocio && (
        <div className="bg-white rounded-xl shadow-sm border border-zinc-200 mb-6">
          <div className="p-4 border-b border-zinc-200">
            <h2 className="font-semibold text-zinc-900">Configuración del Plan</h2>
          </div>
          <div className="p-4 grid grid-cols-2 md:grid-cols-4 gap-4">
            <div>
              <label className="block text-xs font-medium text-zinc-500 mb-1">Cuota base</label>
              <input type="number" value={cuotaBase} onChange={e => setCuotaBase(Number(e.target.value))}
                className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
            </div>
            <div>
              <label className="block text-xs font-medium text-zinc-500 mb-1">Interés mensual (%)</label>
              <input type="number" step="0.1" value={interesPct} onChange={e => setInteresPct(Number(e.target.value))}
                className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
            </div>
            <div>
              <label className="block text-xs font-medium text-zinc-500 mb-1">Cant. cuotas</label>
              <input type="number" value={cantidadCuotas} onChange={e => setCantidadCuotas(Number(e.target.value))}
                className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
            </div>
            <div>
              <label className="block text-xs font-medium text-zinc-500 mb-1">Mes inicio</label>
              <input type="month" value={fechaInicio} onChange={e => setFechaInicio(e.target.value)}
                className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
            </div>
          </div>
          <div className="px-4 pb-4">
            <button onClick={generarPreview}
              className="px-4 py-2 bg-emerald-600 text-white rounded-lg text-sm font-medium hover:bg-emerald-700">
              Previsualizar Plan
            </button>
          </div>
        </div>
      )}

      {/* Step 3: Preview */}
      {cuotas.length > 0 && (
        <div className="bg-white rounded-xl shadow-sm border border-zinc-200">
          <div className="p-4 border-b border-zinc-200 flex items-center justify-between">
            <h2 className="font-semibold text-zinc-900">Previsualización ({cuotas.length} cuotas)</h2>
            <div className="flex gap-2">
              <button onClick={() => setTab("config")}
                className="px-3 py-1.5 text-sm border border-zinc-300 rounded-lg hover:bg-zinc-50">Atrás</button>
              <button onClick={guardarPlan} disabled={saving}
                className="flex items-center gap-1.5 px-4 py-1.5 bg-emerald-600 text-white rounded-lg text-sm font-medium hover:bg-emerald-700 disabled:opacity-50">
                <Save className="h-4 w-4" /> {saving ? "Guardando..." : "Guardar Plan"}
              </button>
            </div>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-zinc-50 text-zinc-600 text-left">
                  <th className="px-4 py-3 font-medium w-8">#</th>
                  <th className="px-4 py-3 font-medium">Período</th>
                  <th className="px-4 py-3 font-medium text-right">Proyectado</th>
                  <th className="px-4 py-3 font-medium text-right">Saldo</th>
                  <th className="px-4 py-3 w-16"></th>
                </tr>
              </thead>
              <tbody className="divide-y divide-zinc-100">
                {cuotas.map((c, i) => (
                  <tr key={c.periodo} className="hover:bg-zinc-50">
                    <td className="px-4 py-2.5 text-zinc-400">{i + 1}</td>
                    <td className="px-4 py-2.5 text-zinc-900 font-medium">{fmtPeriodo(c.periodo)}</td>
                    <td className="px-4 py-2.5">
                      <input type="number" value={c.proyectado}
                        onChange={e => updateCuota(i, Number(e.target.value))}
                        className="w-full text-right px-2 py-1 border border-zinc-300 rounded text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                    </td>
                    <td className="px-4 py-2.5 text-right font-medium text-zinc-900">{formatCurrency(c.saldo)}</td>
                    <td className="px-4 py-2.5">
                      <button onClick={() => setCuotas(prev => prev.filter((_, j) => j !== i))}
                        className="p-1 hover:bg-red-50 rounded text-red-400 hover:text-red-600">
                        <Trash2 className="h-4 w-4" />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr className="bg-zinc-50 font-medium text-zinc-900">
                  <td colSpan={2} className="px-4 py-3 text-right">Totales:</td>
                  <td className="px-4 py-3 text-right">{formatCurrency(cuotas.reduce((s, c) => s + c.proyectado, 0))}</td>
                  <td colSpan={2} />
                </tr>
              </tfoot>
            </table>
          </div>
          <div className="p-4 border-t border-zinc-200 flex justify-end">
            <button onClick={guardarPlan} disabled={saving}
              className="flex items-center gap-1.5 px-4 py-2 bg-emerald-600 text-white rounded-lg text-sm font-medium hover:bg-emerald-700 disabled:opacity-50">
              <Save className="h-4 w-4" /> {saving ? "Guardando..." : "Guardar Plan"}
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
