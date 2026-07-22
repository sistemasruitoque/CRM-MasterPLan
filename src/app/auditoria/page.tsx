"use client"

import { useEffect, useState } from "react"
import { supabase } from "@/lib/supabase"
import { Search, Filter } from "lucide-react"

interface AuditLog {
  id: number
  tabla: string
  registro_id: string | null
  accion: string
  usuario: string | null
  datos_anteriores: Record<string, unknown> | null
  datos_nuevos: Record<string, unknown> | null
  created_at: string
}

export default function AuditoriaPage() {
  const [logs, setLogs] = useState<AuditLog[]>([])
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState("")
  const [filterTabla, setFilterTabla] = useState("")
  const [expandedId, setExpandedId] = useState<number | null>(null)

  useEffect(() => {
    loadLogs()
  }, [])

  async function loadLogs() {
    setLoading(true)
    try {
      const { data, error } = await supabase.from("auditoria").select("*").order("created_at", { ascending: false }).limit(200)
      if (error) { console.error(error); return }
      setLogs((data as AuditLog[]) || [])
    } catch { /* demo mode */ }
    setLoading(false)
  }

  const filtered = logs.filter(l => {
    if (search) {
      const q = search.toLowerCase()
      const match = l.tabla.toLowerCase().includes(q) || (l.usuario || "").toLowerCase().includes(q) || (l.accion || "").toLowerCase().includes(q) || (l.registro_id || "").toLowerCase().includes(q)
      if (!match) return false
    }
    if (filterTabla && l.tabla !== filterTabla) return false
    return true
  })

  function formatDate(iso: string) {
    return new Date(iso).toLocaleString("es-CO", { day: "2-digit", month: "short", year: "numeric", hour: "2-digit", minute: "2-digit" })
  }

  function accionLabel(a: string) {
    const labels: Record<string, string> = { crear: "Crear", editar: "Editar", eliminar: "Eliminar", editar_pagado: "Editar Pagado", acumular_interes: "Acumular Interés", agregar_cuota: "Agregar Cuota" }
    return labels[a] || a
  }

  function tablaLabel(t: string) {
    const labels: Record<string, string> = { socios: "Socios", planes_pago: "Planes de Pago" }
    return labels[t] || t
  }

  return (
    <div className="p-6">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-zinc-900">Auditoría</h1>
        <p className="text-zinc-500 text-sm mt-1">Historial de acciones realizadas en el sistema</p>
      </div>

      <div className="flex gap-3 mb-4 items-center">
        <div className="relative flex-1 max-w-md">
          <Search className="absolute left-3 top-2.5 h-4 w-4 text-zinc-400" />
          <input value={search} onChange={e => setSearch(e.target.value)} placeholder="Buscar..." className="pl-9 pr-3 py-2 text-sm border rounded-lg w-full" />
        </div>
        <select value={filterTabla} onChange={e => setFilterTabla(e.target.value)} className="border rounded-lg px-3 py-2 text-sm">
          <option value="">Todas las tablas</option>
          <option value="socios">Socios</option>
          <option value="planes_pago">Planes de Pago</option>
        </select>
        <button onClick={loadLogs} className="text-sm text-blue-600 hover:text-blue-800">Actualizar</button>
      </div>

      {loading ? (
        <p className="text-zinc-400">Cargando...</p>
      ) : filtered.length === 0 ? (
        <p className="text-zinc-400">No hay registros de auditoría</p>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full text-sm border-collapse">
            <thead>
              <tr className="bg-zinc-50 text-left">
                <th className="px-3 py-2 font-medium">Fecha</th>
                <th className="px-3 py-2 font-medium">Tabla</th>
                <th className="px-3 py-2 font-medium">Acción</th>
                <th className="px-3 py-2 font-medium">Usuario</th>
                <th className="px-3 py-2 font-medium">Registro</th>
                <th className="px-3 py-2 font-medium">Detalle</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-zinc-100">
              {filtered.map(log => (
                <tr key={log.id} className="hover:bg-zinc-50">
                  <td className="px-3 py-2 whitespace-nowrap text-zinc-600">{formatDate(log.created_at)}</td>
                  <td className="px-3 py-2">{tablaLabel(log.tabla)}</td>
                  <td className="px-3 py-2">
                    <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${log.accion === "eliminar" ? "bg-red-100 text-red-700" : log.accion === "crear" ? "bg-green-100 text-green-700" : "bg-blue-100 text-blue-700"}`}>
                      {accionLabel(log.accion)}
                    </span>
                  </td>
                  <td className="px-3 py-2 text-zinc-600">{log.usuario || "-"}</td>
                  <td className="px-3 py-2 text-zinc-500 text-xs font-mono">{log.registro_id || "-"}</td>
                  <td className="px-3 py-2">
                    {(log.datos_anteriores || log.datos_nuevos) && (
                      <button onClick={() => setExpandedId(expandedId === log.id ? null : log.id)} className="text-blue-600 text-xs hover:underline">
                        {expandedId === log.id ? "Ocultar" : "Ver"}
                      </button>
                    )}
                  </td>
                </tr>
              ))}
              {expandedId && (() => {
                const log = filtered.find(l => l.id === expandedId)
                if (!log) return null
                return (
                  <tr key="detail">
                    <td colSpan={6} className="px-3 py-3 bg-zinc-50">
                      <div className="flex gap-8 text-xs">
                        {log.datos_anteriores && (
                          <div>
                            <p className="font-semibold text-red-600 mb-1">Antes:</p>
                            <pre className="bg-white border rounded p-2 max-w-lg overflow-x-auto">{JSON.stringify(log.datos_anteriores, null, 2)}</pre>
                          </div>
                        )}
                        {log.datos_nuevos && (
                          <div>
                            <p className="font-semibold text-green-600 mb-1">Después:</p>
                            <pre className="bg-white border rounded p-2 max-w-lg overflow-x-auto">{JSON.stringify(log.datos_nuevos, null, 2)}</pre>
                          </div>
                        )}
                      </div>
                    </td>
                  </tr>
                )
              })()}
            </tbody>
          </table>
        </div>
      )}
    </div>
  )
}
