import { supabase } from "./supabase"

export interface AuditoriaEntry {
  tabla: string
  registro_id?: string
  accion: string
  usuario?: string
  datos_anteriores?: Record<string, unknown>
  datos_nuevos?: Record<string, unknown>
}

export async function registrarAuditoria(entry: AuditoriaEntry) {
  try {
    const usuario = typeof window !== "undefined" ? localStorage.getItem("user") || "desconocido" : "desconocido"
    const { error } = await (supabase.from("auditoria") as any).insert({
      tabla: entry.tabla,
      registro_id: entry.registro_id,
      accion: entry.accion,
      usuario,
      datos_anteriores: entry.datos_anteriores || null,
      datos_nuevos: entry.datos_nuevos || null,
    })
    if (error) console.error("Error auditoría:", error)
  } catch {
    console.error("Error auditoría: sin conexión")
  }
}
