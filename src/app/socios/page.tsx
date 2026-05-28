"use client"

import { useEffect, useState } from "react"
import { useRouter } from "next/navigation"
import { supabase } from "@/lib/supabase"
import { formatCurrency } from "@/lib/utils"
import { Search, Plus, Filter, ChevronDown, Building2, UserCheck } from "lucide-react"
import type { Socio } from "@/types"

const emptyForm = {
  certificado_no: 0,
  cedula: "",
  nombre: "",
  categoria: "Fase III" as Socio["categoria"],
  estatus: "Por Firmar",
  fecha_contrato: "",
  modalidad: "Contado",
  aporte: 0,
  referido: 0,
  valor_final: 0,
  responsable: "",
}

export default function SociosPage() {
  const router = useRouter()
  const [socios, setSocios] = useState<Socio[]>([])
  const [search, setSearch] = useState("")
  const [filterCat, setFilterCat] = useState("")
  const [filterStatus, setFilterStatus] = useState("")
  const [showForm, setShowForm] = useState(false)
  const [form, setForm] = useState({ ...emptyForm })
  const [saving, setSaving] = useState(false)

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

  async function handleCreate() {
    setSaving(true)
    try {
      const { data: newSocio, error } = await supabase.from("socios").insert({
        certificado_no: form.certificado_no,
        cedula: form.cedula,
        nombre: form.nombre,
        categoria: form.categoria,
        estatus: form.estatus,
        fecha_contrato: form.fecha_contrato || null,
        modalidad: form.modalidad,
        aporte: form.aporte,
        referido: form.referido,
        valor_final: form.valor_final,
        responsable: form.responsable,
        admin_fee: 0,
        cuota_especial_nota: "",
        ap_locker: 0,
        cabal_cant: 0,
        cab_locker: 0,
        dama_cant: 0,
        observaciones: "",
      } as any).select()
      if (error) { alert("Error: " + error.message); return }
      if (newSocio && newSocio[0]) {
        const socio = newSocio[0] as Socio
        await generarPlanInicial(socio)
        alert("Socio creado con plan de pagos")
        router.push("/pagos")
      }
    } catch {
      alert("Conecta Supabase para guardar")
    }
    setSaving(false)
  }

  async function generarPlanInicial(socio: Socio) {
    const meses: string[] = []
    let year = 2025, month = 11
    const endYear = 2031, endMonth = 1
    while (year < endYear || (year === endYear && month <= endMonth)) {
      meses.push(`${year}-${String(month).padStart(2, "0")}`)
      month++
      if (month > 12) { month = 1; year++ }
    }
    const cuotaBase = Math.round(socio.valor_final * 0.0363)
    let saldo = socio.valor_final
    const rows: any[] = []
    for (const periodo of meses) {
      const interes = Math.round(saldo * 0.01)
      const cuota = Math.min(cuotaBase + interes, saldo + interes)
      rows.push({
        socio_id: socio.id,
        periodo,
        monto_proyectado: cuota,
        monto_pagado: 0,
        saldo,
        estado: "pendiente",
        interes_mora: 0,
        interes_mora_fecha: null,
      })
      saldo -= cuota
      if (saldo <= 0) break
    }
    await supabase.from("planes_pago").upsert(rows as any, { onConflict: "socio_id,periodo" })
  }

  const filtered = socios.filter((s) => {
    const matchSearch = !search || s.nombre.toLowerCase().includes(search.toLowerCase()) || s.certificado_no.toString().includes(search)
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
        <button
          onClick={() => setShowForm(true)}
          className="flex items-center gap-2 bg-emerald-600 hover:bg-emerald-700 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors"
        >
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
      {showForm && (
        <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50" onClick={() => setShowForm(false)}>
          <div className="bg-white rounded-xl shadow-xl w-full max-w-lg mx-4 max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
            <div className="p-6 border-b border-zinc-200">
              <h2 className="text-lg font-bold text-zinc-900">Nuevo Socio</h2>
            </div>
            <div className="p-6 space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">No. Certificado</label>
                  <input type="number" value={form.certificado_no || ""} onChange={(e) => setForm({ ...form, certificado_no: Number(e.target.value) })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Cédula</label>
                  <input type="text" value={form.cedula} onChange={(e) => setForm({ ...form, cedula: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
              </div>
              <div>
                <label className="block text-xs font-medium text-zinc-500 mb-1">Nombre</label>
                <input type="text" value={form.nombre} onChange={(e) => setForm({ ...form, nombre: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Categoría</label>
                  <select value={form.categoria} onChange={(e) => setForm({ ...form, categoria: e.target.value as Socio["categoria"] })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none">
                    <option value="Fundador">Fundador</option>
                    <option value="Fase I">Fase I</option>
                    <option value="Fase II">Fase II</option>
                    <option value="Fase III">Fase III</option>
                  </select>
                </div>
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Estado</label>
                  <select value={form.estatus} onChange={(e) => setForm({ ...form, estatus: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none">
                    <option value="Por Firmar">Por Firmar</option>
                    <option value="Firmado">Firmado</option>
                  </select>
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Fecha Contrato</label>
                  <input type="date" value={form.fecha_contrato} onChange={(e) => setForm({ ...form, fecha_contrato: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Modalidad</label>
                  <select value={form.modalidad} onChange={(e) => setForm({ ...form, modalidad: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none">
                    <option value="Contado">Contado</option>
                    <option value="Cuotas">Cuotas</option>
                  </select>
                </div>
              </div>
              <div className="grid grid-cols-3 gap-4">
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Aporte</label>
                  <input type="number" value={form.aporte || ""} onChange={(e) => setForm({ ...form, aporte: Number(e.target.value) })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Referido</label>
                  <input type="number" value={form.referido || ""} onChange={(e) => setForm({ ...form, referido: Number(e.target.value) })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Valor Final</label>
                  <input type="number" value={form.valor_final || ""} onChange={(e) => setForm({ ...form, valor_final: Number(e.target.value) })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
              </div>
              <div>
                <label className="block text-xs font-medium text-zinc-500 mb-1">Responsable</label>
                <input type="text" value={form.responsable} onChange={(e) => setForm({ ...form, responsable: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
              </div>
            </div>
            <div className="p-6 border-t border-zinc-200 flex justify-end gap-3">
              <button onClick={() => setShowForm(false)} className="px-4 py-2 text-sm text-zinc-600 hover:text-zinc-900">Cancelar</button>
              <button
                onClick={handleCreate}
                disabled={saving || !form.nombre || !form.cedula}
                className="px-4 py-2 text-sm bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 disabled:opacity-50"
              >
                {saving ? "Guardando..." : "Crear Socio"}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
