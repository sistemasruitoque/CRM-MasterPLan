"use client"

import { useEffect, useRef, useState } from "react"
import { useRouter } from "next/navigation"
import { supabase } from "@/lib/supabase"
import { formatCurrency } from "@/lib/utils"
import { registrarAuditoria } from "@/lib/auditoria"
import { Search, Plus, Filter, ChevronDown, Building2, UserCheck, Edit3 } from "lucide-react"
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
  const [editingSocio, setEditingSocio] = useState<Socio | null>(null)
  const [certificadoStatus, setCertificadoStatus] = useState<"idle" | "checking" | "available" | "taken">("idle")
  const certTimeout = useRef<ReturnType<typeof setTimeout> | undefined>(undefined)

  function checkCertificado(val: number) {
    if (certTimeout.current) clearTimeout(certTimeout.current)
    if (!val || val <= 0) { setCertificadoStatus("idle"); return }
    setCertificadoStatus("checking")
    certTimeout.current = setTimeout(async () => {
      const { data } = await supabase.from("socios").select("id").eq("certificado_no", val).maybeSingle()
      setCertificadoStatus(data ? "taken" : "available")
    }, 400)
  }

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

  function handleEdit(socio: Socio) {
    setForm({
      certificado_no: socio.certificado_no,
      cedula: socio.cedula || "",
      nombre: socio.nombre || "",
      categoria: socio.categoria,
      estatus: socio.estatus,
      fecha_contrato: socio.fecha_contrato || "",
      modalidad: socio.modalidad,
      aporte: socio.aporte,
      referido: socio.referido,
      valor_final: socio.valor_final,
      responsable: socio.responsable || "",
    })
    setEditingSocio(socio)
    setShowForm(true)
  }

  async function handleSave() {
    setSaving(true)
    try {
      if (editingSocio) {
        const res = await (supabase.from("socios") as any).update({
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
        }).eq("id", editingSocio.id)
        if (res.error) { alert("Error: " + res.error.message); return }
        registrarAuditoria({ tabla: "socios", registro_id: editingSocio.id, accion: "editar", datos_anteriores: { certificado_no: editingSocio.certificado_no, nombre: editingSocio.nombre, aporte: editingSocio.aporte, valor_final: editingSocio.valor_final }, datos_nuevos: { certificado_no: form.certificado_no, nombre: form.nombre, aporte: form.aporte, valor_final: form.valor_final } })
        setShowForm(false)
        setEditingSocio(null)
        loadSocios()
      } else {
        const { data: existing } = await supabase.from("socios").select("id").eq("certificado_no", form.certificado_no).maybeSingle()
        if (existing) { alert("Ya existe un socio con ese No. Certificado"); setSaving(false); return }
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
        if (newSocio && (newSocio as any[])[0]) {
          const s = (newSocio as any[])[0]
          registrarAuditoria({ tabla: "socios", registro_id: s.id, accion: "crear", datos_nuevos: { certificado_no: s.certificado_no, nombre: s.nombre, aporte: s.aporte, valor_final: s.valor_final } })
          router.push("/pagos/nuevo?socio_id=" + s.id)
        }
      }
    } catch {
      alert("Conecta Supabase para guardar")
    }
    setSaving(false)
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
          onClick={() => { setForm({ ...emptyForm }); setEditingSocio(null); setShowForm(true) }}
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
                <th className="px-4 py-3 font-medium"></th>
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
                  <td className="px-4 py-3">
                    <button onClick={() => handleEdit(socio)} className="p-1.5 text-zinc-400 hover:text-emerald-600 hover:bg-emerald-50 rounded-lg transition-colors" title="Editar socio">
                      <Edit3 className="h-4 w-4" />
                    </button>
                  </td>
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
                <td />
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
      {showForm && (
        <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50" onClick={() => { setShowForm(false); setEditingSocio(null) }}>
          <div className="bg-white rounded-xl shadow-xl w-full max-w-lg mx-4 max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
            <div className="p-6 border-b border-zinc-200">
              <h2 className="text-lg font-bold text-zinc-900">{editingSocio ? "Editar Socio" : "Nuevo Socio"}</h2>
            </div>
            <div className="p-6 space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">No. Certificado</label>
                  <input type="number" required value={form.certificado_no || ""} onChange={(e) => { const v = Number(e.target.value); setForm({ ...form, certificado_no: v }); checkCertificado(v) }} className={`w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none ${certificadoStatus === "taken" ? "border-red-400" : certificadoStatus === "available" ? "border-emerald-400" : "border-zinc-300"}`} />
                  {certificadoStatus === "taken" && <p className="text-xs text-red-500 mt-1">Ya está en uso</p>}
                  {certificadoStatus === "available" && <p className="text-xs text-emerald-500 mt-1">Disponible</p>}
                  {certificadoStatus === "checking" && <p className="text-xs text-zinc-400 mt-1">Verificando...</p>}
                </div>
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Cédula</label>
                  <input type="text" required value={form.cedula} onChange={(e) => setForm({ ...form, cedula: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
              </div>
              <div>
                <label className="block text-xs font-medium text-zinc-500 mb-1">Nombre</label>
                <input type="text" required value={form.nombre} onChange={(e) => setForm({ ...form, nombre: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
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
                  <input type="date" required value={form.fecha_contrato} onChange={(e) => setForm({ ...form, fecha_contrato: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
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
                  <input type="number" required value={form.aporte || ""} onChange={(e) => setForm({ ...form, aporte: Number(e.target.value) })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Referido</label>
                  <input type="number" required value={form.referido || ""} onChange={(e) => setForm({ ...form, referido: Number(e.target.value) })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
                <div>
                  <label className="block text-xs font-medium text-zinc-500 mb-1">Valor Final</label>
                  <input type="number" required value={form.valor_final || ""} onChange={(e) => setForm({ ...form, valor_final: Number(e.target.value) })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
                </div>
              </div>
              <div>
                <label className="block text-xs font-medium text-zinc-500 mb-1">Responsable</label>
                <input type="text" required value={form.responsable} onChange={(e) => setForm({ ...form, responsable: e.target.value })} className="w-full px-3 py-2 border border-zinc-300 rounded-lg text-sm focus:ring-2 focus:ring-emerald-500 outline-none" />
              </div>
            </div>
            <div className="p-6 border-t border-zinc-200 flex justify-end gap-3">
              <button onClick={() => { setShowForm(false); setEditingSocio(null) }} className="px-4 py-2 text-sm text-zinc-600 hover:text-zinc-900">Cancelar</button>
              <button
                onClick={handleSave}
                disabled={saving || (!editingSocio && certificadoStatus === "taken") || form.certificado_no <= 0 || (editingSocio ? false : (!form.cedula || !form.nombre || !form.fecha_contrato || !form.responsable)) || form.aporte < 0 || form.valor_final < 0}
                className="px-4 py-2 text-sm bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 disabled:opacity-50"
              >
                {saving ? "Guardando..." : editingSocio ? "Guardar Cambios" : "Crear Socio"}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
