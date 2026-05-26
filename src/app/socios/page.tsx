"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import { supabase } from "@/lib/supabase"
import { formatCurrency } from "@/lib/utils"
import { Search, Plus, Filter, ChevronDown, Building2, UserCheck } from "lucide-react"
import type { Socio } from "@/types"

const mockSocios: Socio[] = [
  { id: "1", certificado_no: 259, cedula: "804004189", nombre: "Inversiones Palermo Y Cia", categoria: "Fundador", estatus: "Firmado", fecha_contrato: "13-Nov-25", admin_fee: 4000000, cuota_especial_nota: "", modalidad: "Corporación", aporte: 150000000, referido: 0, valor_final: 150000000, ap_locker: 0, cabal_cant: 0, cab_locker: 0, dama_cant: 0, responsable: "Diana", observaciones: "", created_at: "" },
  { id: "2", certificado_no: 773, cedula: "79485762", nombre: "Orlando Lopez Gutierrez", categoria: "Fundador", estatus: "Firmado", fecha_contrato: "30-Oct-25", admin_fee: 2000000, cuota_especial_nota: "Saco a las parejas de los Hijo", modalidad: "Corporación", aporte: 150000000, referido: 0, valor_final: 150000000, ap_locker: 0, cabal_cant: 0, cab_locker: 0, dama_cant: 0, responsable: "Jose Mattos", observaciones: "", created_at: "" },
  { id: "3", certificado_no: 80, cedula: "1098778566", nombre: "Daniel Santiago Pico Toled", categoria: "Fundador", estatus: "Firmado", fecha_contrato: "27-Oct-25", admin_fee: 2000000, cuota_especial_nota: "", modalidad: "Corporación", aporte: 75000000, referido: 0, valor_final: 75000000, ap_locker: 0, cabal_cant: 0, cab_locker: 0, dama_cant: 0, responsable: "Diana", observaciones: "", created_at: "" },
  { id: "4", certificado_no: 92, cedula: "91209996", nombre: "Roberto Clavijo Puyana", categoria: "Fundador", estatus: "Firmado", fecha_contrato: "28-Oct-25", admin_fee: 2000000, cuota_especial_nota: "", modalidad: "Corporación", aporte: 75000000, referido: 0, valor_final: 75000000, ap_locker: 0, cabal_cant: 0, cab_locker: 0, dama_cant: 0, responsable: "Diana", observaciones: "", created_at: "" },
  { id: "5", certificado_no: 40, cedula: "91522585", nombre: "Kleyber Julian Acevedo Car", categoria: "Fundador", estatus: "Firmado", fecha_contrato: "28-Oct-25", admin_fee: 2000000, cuota_especial_nota: "", modalidad: "Corporación", aporte: 150000000, referido: 0, valor_final: 150000000, ap_locker: 0, cabal_cant: 0, cab_locker: 0, dama_cant: 0, responsable: "Diana", observaciones: "", created_at: "" },
  { id: "6", certificado_no: 245, cedula: "1098636862", nombre: "Silvia Juliana Guerra Rang", categoria: "Fundador", estatus: "Firmado", fecha_contrato: "30-Oct-25", admin_fee: 2000000, cuota_especial_nota: "", modalidad: "Corporación", aporte: 187500000, referido: 0, valor_final: 187500000, ap_locker: 0, cabal_cant: 0, cab_locker: 0, dama_cant: 0, responsable: "Diana", observaciones: "", created_at: "" },
  { id: "7", certificado_no: 112, cedula: "1095804765", nombre: "Lizeth Calderon Ordoñez", categoria: "Fundador", estatus: "Firmado", fecha_contrato: "30-Oct-25", admin_fee: 2000000, cuota_especial_nota: "", modalidad: "Corporación", aporte: 187500000, referido: 0, valor_final: 187500000, ap_locker: 2000000, cabal_cant: 1, cab_locker: 1, dama_cant: 0, responsable: "Diana", observaciones: "", created_at: "" },
  { id: "8", certificado_no: 159, cedula: "1098630705", nombre: "Laura Soraya Saba Santiago", categoria: "Fundador", estatus: "Firmado", fecha_contrato: "30-Oct-25", admin_fee: 2000000, cuota_especial_nota: "tiene a favor 3.145.783 por er", modalidad: "Corporación", aporte: 120000000, referido: 7500000, valor_final: 112500000, ap_locker: 2000000, cabal_cant: 1, cab_locker: 1, dama_cant: 0, responsable: "Diana", observaciones: "", created_at: "" },
  { id: "9", certificado_no: 610, cedula: "18928103", nombre: "Leoncio Picon Rosado", categoria: "Fase I", estatus: "Firmado", fecha_contrato: "06-Nov-25", admin_fee: 2000000, cuota_especial_nota: "", modalidad: "Corporación", aporte: 150000000, referido: 0, valor_final: 150000000, ap_locker: 2000000, cabal_cant: 1, cab_locker: 1, dama_cant: 0, responsable: "Rolando", observaciones: "", created_at: "" },
  { id: "10", certificado_no: 306, cedula: "1098738126", nombre: "Nicolas Mauricio Grau Prad", categoria: "Fase II", estatus: "Firmado", fecha_contrato: "07-Nov-25", admin_fee: 2000000, cuota_especial_nota: "", modalidad: "Corporación", aporte: 247500000, referido: 0, valor_final: 247500000, ap_locker: 0, cabal_cant: 0, cab_locker: 0, dama_cant: 0, responsable: "Juliana", observaciones: "", created_at: "" },
]

export default function SociosPage() {
  const router = useRouter()
  const [socios, setSocios] = useState<Socio[]>(mockSocios)
  const [search, setSearch] = useState("")
  const [filterCat, setFilterCat] = useState("")
  const [filterStatus, setFilterStatus] = useState("")

  useEffect(() => {
    if (typeof window !== "undefined" && !localStorage.getItem("club-auth")) {
      router.push("/login")
    }
    loadSocios()
  }, [])

  async function loadSocios() {
    try {
      const { data } = await supabase.from("socios").select("*").order("certificado_no")
      if (data && data.length > 0) setSocios(data)
    } catch { /* use mock data */ }
  }

  const filtered = socios.filter((s) => {
    const matchSearch = !search || s.nombre.toLowerCase().includes(search.toLowerCase()) || s.cedula.includes(search) || s.certificado_no.toString().includes(search)
    const matchCat = !filterCat || s.categoria === filterCat
    const matchStatus = !filterStatus || s.estatus === filterStatus
    return matchSearch && matchCat && matchStatus
  })

  const totalValor = filtered.reduce((s, p) => s + p.valor_final, 0)

  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-zinc-900">Socios</h1>
          <p className="text-zinc-500 text-sm mt-1">{socios.length} socios registrados</p>
        </div>
        <button className="flex items-center gap-2 bg-emerald-600 hover:bg-emerald-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors">
          <Plus className="h-4 w-4" />
          Nuevo Socio
        </button>
      </div>

      <div className="bg-white rounded-xl shadow-sm border border-zinc-200 overflow-hidden">
        <div className="p-4 border-b border-zinc-200 flex flex-wrap gap-3">
          <div className="relative flex-1 min-w-[200px]">
            <Search className="absolute left-3 top-2.5 h-4 w-4 text-zinc-400" />
            <input
              type="text"
              placeholder="Buscar por nombre, cédula o certificado..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none"
            />
          </div>
          <select value={filterCat} onChange={(e) => setFilterCat(e.target.value)} className="px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none">
            <option value="">Todas las categorías</option>
            <option value="Fundador">Fundador</option>
            <option value="Fase I">Fase I</option>
            <option value="Fase II">Fase II</option>
            <option value="Fase III">Fase III</option>
          </select>
          <select value={filterStatus} onChange={(e) => setFilterStatus(e.target.value)} className="px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none">
            <option value="">Todos los estados</option>
            <option value="Firmado">Firmado</option>
            <option value="Por Firmar">Por Firmar</option>
          </select>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-sm">
            <thead>
              <tr className="bg-zinc-50 text-zinc-600 text-left">
                <th className="px-4 py-3 font-medium">No.</th>
                <th className="px-4 py-3 font-medium">Cédula</th>
                <th className="px-4 py-3 font-medium">Nombre</th>
                <th className="px-4 py-3 font-medium">Categoría</th>
                <th className="px-4 py-3 font-medium">Estado</th>
                <th className="px-4 py-3 font-medium">Fecha Contrato</th>
                <th className="px-4 py-3 font-medium text-right">Aporte</th>
                <th className="px-4 py-3 font-medium text-right">Referido</th>
                <th className="px-4 py-3 font-medium text-right">Valor Final</th>
                <th className="px-4 py-3 font-medium">Responsable</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-zinc-100">
              {filtered.map((socio) => (
                <tr key={socio.id} className="hover:bg-zinc-50 transition-colors">
                  <td className="px-4 py-3 text-zinc-900 font-medium">{socio.certificado_no}</td>
                  <td className="px-4 py-3 text-zinc-600">{socio.cedula}</td>
                  <td className="px-4 py-3">
                    <span className="font-medium text-zinc-900">{socio.nombre}</span>
                  </td>
                  <td className="px-4 py-3">
                    <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${
                      socio.categoria === "Fundador" ? "bg-purple-100 text-purple-700" :
                      socio.categoria === "Fase I" ? "bg-blue-100 text-blue-700" :
                      socio.categoria === "Fase II" ? "bg-amber-100 text-amber-700" :
                      "bg-emerald-100 text-emerald-700"
                    }`}>
                      {socio.categoria}
                    </span>
                  </td>
                  <td className="px-4 py-3">
                    <span className={`inline-flex items-center gap-1 ${
                      socio.estatus === "Firmado" ? "text-emerald-600" : "text-amber-600"
                    }`}>
                      <UserCheck className="h-3.5 w-3.5" />
                      {socio.estatus}
                    </span>
                  </td>
                  <td className="px-4 py-3 text-zinc-600">{socio.fecha_contrato || "-"}</td>
                  <td className="px-4 py-3 text-right font-medium text-zinc-900">{formatCurrency(socio.aporte)}</td>
                  <td className="px-4 py-3 text-right text-red-500">{formatCurrency(socio.referido)}</td>
                  <td className="px-4 py-3 text-right font-bold text-zinc-900">{formatCurrency(socio.valor_final)}</td>
                  <td className="px-4 py-3 text-zinc-600">{socio.responsable}</td>
                </tr>
              ))}
            </tbody>
            <tfoot>
              <tr className="bg-zinc-50 font-medium text-zinc-900">
                <td colSpan={6} className="px-4 py-3 text-right">Totales:</td>
                <td className="px-4 py-3 text-right">{formatCurrency(filtered.reduce((s, p) => s + p.aporte, 0))}</td>
                <td className="px-4 py-3 text-right">{formatCurrency(filtered.reduce((s, p) => s + p.referido, 0))}</td>
                <td className="px-4 py-3 text-right">{formatCurrency(totalValor)}</td>
                <td />
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  )
}
