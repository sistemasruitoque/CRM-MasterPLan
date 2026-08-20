"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import { supabase } from "@/lib/supabase"
import { formatCurrency, fetchAllPlanesPago, normalizePeriod, currentPeriod, distributePagos, calcularInteresMora, diasVencidos } from "@/lib/utils"
import { Download, FileText, BarChart3, Calendar, AlertTriangle, CheckCircle2 } from "lucide-react"
import type { Socio, PlanPago, Pago } from "@/types"

interface CuotaPorVencer {
  socio: Socio
  cuota: PlanPago
  fechaVencimiento: string
  semana: number
}

export default function ReportesPage() {
  const router = useRouter()
  const [socios, setSocios] = useState<Socio[]>([])
  const [cuotasPorVencer, setCuotasPorVencer] = useState<CuotaPorVencer[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (typeof window !== "undefined" && !localStorage.getItem("club-auth")) {
      router.push("/login")
    }
    loadData()
  }, [])

  async function loadData() {
    setLoading(true)
    try {
      const [sociosRes, planesRes, pagosRes] = await Promise.all([
        supabase.from("socios").select("*"),
        fetchAllPlanesPago(supabase),
        supabase.from("pagos").select("*"),
      ])

      const sociosData: Socio[] = sociosRes.data || []
      const planesData: PlanPago[] = planesRes || []
      const pagosData: Pago[] = pagosRes.data || []
      setSocios(sociosData)

      const grouped: Record<string, PlanPago[]> = {}
      for (const p of planesData) {
        if (!grouped[p.socio_id]) grouped[p.socio_id] = []
        grouped[p.socio_id].push(p)
      }
      for (const socio of sociosData) {
        if (!grouped[socio.id]) {
          grouped[socio.id] = []
        }
        grouped[socio.id] = distributePagos(grouped[socio.id], pagosData, socio.id)
      }

      const hoy = new Date()
      const mesActual = hoy.getMonth()
      const anioActual = hoy.getFullYear()

      const result: CuotaPorVencer[] = []

      for (const socio of sociosData) {
        const plan = grouped[socio.id] || []
        for (const cuota of plan) {
          if (cuota.estado === "pagado" || cuota.estado === "exonerado") continue
          const saldo = cuota.monto_proyectado - cuota.monto_pagado
          if (saldo <= 0) continue

          let fechaVen: Date
          const [y, m] = cuota.periodo.split("-").map(Number)
          if (cuota.fecha_vencimiento) {
            const fv = new Date(cuota.fecha_vencimiento)
            if (fv.getMonth() === m - 1 && fv.getFullYear() === y) {
              fechaVen = fv
            } else {
              fechaVen = new Date(y, m, 0)
            }
          } else {
            fechaVen = new Date(y, m, 0)
          }

          if (fechaVen.getMonth() === mesActual && fechaVen.getFullYear() === anioActual) {
            const semana = Math.ceil(fechaVen.getDate() / 7)
            result.push({
              socio,
              cuota,
              fechaVencimiento: fechaVen.toISOString().split("T")[0],
              semana,
            })
          }
        }
      }

      result.sort((a, b) => a.fechaVencimiento.localeCompare(b.fechaVencimiento))
      setCuotasPorVencer(result)
    } catch { /* demo */ }
    setLoading(false)
  }

  const semanas = [1, 2, 3, 4, 5]
  const semanaLabels: Record<number, string> = {
    1: "Sem 1 (día 1-7)",
    2: "Sem 2 (día 8-14)",
    3: "Sem 3 (día 15-21)",
    4: "Sem 4 (día 22-28)",
    5: "Sem 5 (día 29-31)",
  }

  function getSemanaData(semana: number) {
    return cuotasPorVencer.filter(c => c.semana === semana)
  }

  function totalSemana(semana: number) {
    return getSemanaData(semana).reduce((s, c) => s + (c.cuota.monto_proyectado - c.cuota.monto_pagado), 0)
  }

  const totalGeneral = cuotasPorVencer.reduce((s, c) => s + (c.cuota.monto_proyectado - c.cuota.monto_pagado), 0)
  const totalIntereses = cuotasPorVencer.reduce((s, c) => {
    const saldo = c.cuota.monto_proyectado - c.cuota.monto_pagado
    const dias = diasVencidos(c.cuota.periodo, c.cuota.fecha_vencimiento)
    return s + calcularInteresMora(saldo, dias, 9.53)
  }, 0)

  function exportExcel() {
    const bom = "\uFEFF"
    const sep = ";"
    const rows = [["Semana", "Codigo Socio", "Nombre", "Categoría", "Período", "Vence", "Saldo", "Valor Acción"].join(sep)]
    for (const c of cuotasPorVencer) {
      const saldo = c.cuota.monto_proyectado - c.cuota.monto_pagado
      rows.push([semanaLabels[c.semana], c.socio.certificado_no, `"${c.socio.nombre}"`, c.socio.categoria, c.cuota.periodo, c.fechaVencimiento, saldo, c.socio.valor_final].join(sep))
    }
    const blob = new Blob([bom + rows.join("\n")], { type: "text/csv;charset=utf-8" })
    const url = URL.createObjectURL(blob)
    const a = document.createElement("a")
    a.href = url
    a.download = "cuotas_por_vencer.csv"
    a.click()
    URL.revokeObjectURL(url)
  }

  function exportSociosReport() {
    const bom = "\uFEFF"
    const sep = ";"
    const rows = [["Accion", "Documento", "Nombre", "Categoria", "Estado", "Aporte", "Referido", "Valor Final"].join(sep)]
    for (const s of socios) {
      rows.push([s.certificado_no, s.cedula, `"${s.nombre}"`, s.categoria, s.estatus, s.aporte, s.referido, s.valor_final].join(sep))
    }
    const blob = new Blob([bom + rows.join("\n")], { type: "text/csv;charset=utf-8" })
    const url = URL.createObjectURL(blob)
    const a = document.createElement("a")
    a.href = url
    a.download = "reporte_socios.csv"
    a.click()
    URL.revokeObjectURL(url)
  }

  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-zinc-900">Reportes</h1>
          <p className="text-zinc-500 text-sm mt-1">Análisis y exportación de datos</p>
        </div>
        <div className="flex gap-2 items-center">
          <button onClick={exportExcel} className="flex items-center gap-2 bg-white border border-zinc-300 text-zinc-700 px-4 py-2 rounded-lg text-sm font-medium hover:bg-zinc-50 transition-colors">
            <Download className="h-4 w-4" />
            Exportar Excel
          </button>
          <button onClick={exportSociosReport} className="flex items-center gap-2 bg-white border border-zinc-300 text-zinc-700 px-4 py-2 rounded-lg text-sm font-medium hover:bg-zinc-50 transition-colors">
            <FileText className="h-4 w-4" />
            Reporte
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
        <div className="bg-amber-50 rounded-xl p-4 border border-amber-200">
          <div className="flex items-center gap-2 mb-1">
            <Calendar className="h-4 w-4 text-amber-600" />
            <span className="text-sm font-medium text-amber-700">Cuotas por Vencer</span>
          </div>
          <p className="text-2xl font-bold text-amber-900">{cuotasPorVencer.length}</p>
        </div>
        <div className="bg-red-50 rounded-xl p-4 border border-red-200">
          <div className="flex items-center gap-2 mb-1">
            <AlertTriangle className="h-4 w-4 text-red-600" />
            <span className="text-sm font-medium text-red-700">Saldo Total</span>
          </div>
          <p className="text-2xl font-bold text-red-900">{formatCurrency(totalGeneral)}</p>
        </div>
        <div className="bg-orange-50 rounded-xl p-4 border border-orange-200">
          <div className="flex items-center gap-2 mb-1">
            <AlertTriangle className="h-4 w-4 text-orange-600" />
            <span className="text-sm font-medium text-orange-700">Intereses Estimados</span>
          </div>
          <p className="text-2xl font-bold text-orange-900">{formatCurrency(totalIntereses)}</p>
        </div>
        <div className="bg-emerald-50 rounded-xl p-4 border border-emerald-200">
          <div className="flex items-center gap-2 mb-1">
            <CheckCircle2 className="h-4 w-4 text-emerald-600" />
            <span className="text-sm font-medium text-emerald-700">Socios Afectados</span>
          </div>
          <p className="text-2xl font-bold text-emerald-900">{new Set(cuotasPorVencer.map(c => c.socio.id)).size}</p>
        </div>
      </div>

      {loading ? (
        <div className="flex items-center justify-center h-32">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-emerald-600" />
        </div>
      ) : cuotasPorVencer.length === 0 ? (
        <div className="bg-white rounded-xl shadow-sm border border-zinc-200 p-12 text-center">
          <CheckCircle2 className="h-10 w-10 mx-auto mb-3 text-emerald-400" />
          <p className="font-medium text-zinc-700">No hay cuotas por vencer este mes</p>
        </div>
      ) : (
        <div className="space-y-6">
          {semanas.map(sem => {
            const data = getSemanaData(sem)
            if (data.length === 0) return null
            return (
              <div key={sem} className="bg-white rounded-xl shadow-sm border border-zinc-200 overflow-hidden">
                <div className="flex items-center justify-between px-5 py-3 bg-zinc-50 border-b border-zinc-200">
                  <h3 className="font-semibold text-zinc-800 flex items-center gap-2">
                    <Calendar className="h-4 w-4 text-emerald-500" />
                    {semanaLabels[sem]}
                  </h3>
                  <div className="flex items-center gap-4 text-sm">
                    <span className="text-zinc-500">{data.length} cuotas</span>
                    <span className="font-bold text-zinc-900">{formatCurrency(totalSemana(sem))}</span>
                  </div>
                </div>
                <div className="overflow-x-auto">
                  <table className="w-full text-sm">
                    <thead>
                      <tr className="text-left text-zinc-500 text-xs border-b border-zinc-100">
                        <th className="px-5 py-2 font-medium">No.</th>
                        <th className="px-5 py-2 font-medium">Nombre</th>
                        <th className="px-5 py-2 font-medium">Categoría</th>
                        <th className="px-5 py-2 font-medium">Período</th>
                        <th className="px-5 py-2 font-medium">Vence</th>
                        <th className="px-5 py-2 font-medium text-right">Saldo</th>
                        <th className="px-5 py-2 font-medium text-right">Valor Acción</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-zinc-50">
                      {data.map((c, i) => {
                        const saldo = c.cuota.monto_proyectado - c.cuota.monto_pagado
                        return (
                          <tr key={i} className="hover:bg-zinc-50">
                            <td className="px-5 py-2 font-medium text-zinc-900">{c.socio.certificado_no}</td>
                            <td className="px-5 py-2 text-zinc-700">{c.socio.nombre}</td>
                            <td className="px-5 py-2">
                              <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${c.socio.categoria === "Fundador" ? "bg-purple-100 text-purple-700" : c.socio.categoria === "Fase I" ? "bg-blue-100 text-blue-700" : "bg-amber-100 text-amber-700"}`}>
                                {c.socio.categoria}
                              </span>
                            </td>
                            <td className="px-5 py-2 text-zinc-700">{c.cuota.periodo}</td>
                            <td className="px-5 py-2 text-zinc-700">{c.fechaVencimiento}</td>
                            <td className="px-5 py-2 text-right font-medium text-red-600">{formatCurrency(saldo)}</td>
                            <td className="px-5 py-2 text-right text-zinc-700">{formatCurrency(c.socio.valor_final)}</td>
                          </tr>
                        )
                      })}
                    </tbody>
                  </table>
                </div>
              </div>
            )
          })}

          <div className="bg-zinc-50 rounded-xl border border-zinc-200 px-5 py-3 flex items-center justify-between">
            <span className="font-semibold text-zinc-800">Total General - Mes Actual</span>
            <div className="flex items-center gap-6 text-sm">
              <span className="text-zinc-500">{cuotasPorVencer.length} cuotas</span>
              <span className="font-bold text-red-600">{formatCurrency(totalGeneral)}</span>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
