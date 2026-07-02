import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"
import type { PlanPago, Pago } from "@/types"
import type { SupabaseClient } from "@supabase/supabase-js"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function formatCurrency(n: number): string {
  return new Intl.NumberFormat("es-CO", {
    style: "currency",
    currency: "COP",
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
  }).format(n)
}

export function diasVencidos(periodo: string): number {
  const [y, m] = periodo.split("-").map(Number)
  const cuotaDate = new Date(y, m, 0)
  const today = new Date()
  if (cuotaDate > today) return 0
  return Math.max(0, Math.floor((today.getTime() - cuotaDate.getTime()) / (1000 * 60 * 60 * 24)) - 1)
}

export function calcularInteresMora(saldo: number, dias: number, ibr: number): number {
  if (dias <= 0 || saldo <= 0) return 0
  const tasaEA = (ibr + 4) / 100
  const tasaDiaria = Math.pow(1 + tasaEA, 1 / 365) - 1
  return Math.round(saldo * tasaDiaria * dias)
}

const MONTH_MAP: Record<string, string> = {
  "Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04",
  "May": "05", "Jun": "06", "Jul": "07", "Aug": "08",
  "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12",
}

export function normalizePeriod(p: string): string {
  if (/^\d{4}-\d{2}$/.test(p)) return p
  const [m, y] = p.split("-")
  const yy = y?.length === 2 ? `20${y}` : y
  return `${yy}-${MONTH_MAP[m] || "01"}`
}

export function diasEntre(desde: string, hasta: string): number {
  const d = new Date(desde)
  const h = new Date(hasta)
  return Math.max(0, Math.floor((h.getTime() - d.getTime()) / (1000 * 60 * 60 * 24)))
}

export function hoyStr(): string {
  return new Date().toISOString().split("T")[0]
}

export function currentPeriod(): string {
  const d = new Date()
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}`
}

export async function fetchAllPlanesPago(client: SupabaseClient<any>): Promise<PlanPago[]> {
  let all: PlanPago[] = []
  let from = 0
  while (true) {
    const { data } = await client.from("planes_pago").select("*").range(from, from + 999)
    if (!data || data.length === 0) break
    all = all.concat(data as PlanPago[])
    if (data.length < 1000) break
    from += 1000
  }
  return all
}

export function parseDate(d: string): string {
  if (!d) return "-"
  const parts = d.split("-")
  if (parts.length === 3 && MONTH_MAP[parts[0]]) {
    return `${parts[2]}-${MONTH_MAP[parts[0]]}-${parts[1]}`
  }
  return d
}

export function distributePagos(plan: PlanPago[], pagos: Pago[], socioId: string): PlanPago[] {
  const result: PlanPago[] = plan.map(c => ({ ...c, monto_pagado: 0, estado: "pendiente" as PlanPago["estado"], fecha_pago: null }))
  const socioPagos = pagos
    .filter(p => p.socio_id === socioId)
    .sort((a, b) => a.fecha_pago.localeCompare(b.fecha_pago))
  if (socioPagos.length === 0) return result
  let resto = 0
  for (const pago of socioPagos) {
    let porAplicar = pago.monto + resto
    resto = 0
    for (const cuota of result) {
      if (porAplicar <= 0) break
      const pendiente = cuota.monto_proyectado - cuota.monto_pagado
      if (pendiente <= 0) continue
      const aplicar = Math.min(porAplicar, pendiente)
      cuota.monto_pagado += aplicar
      porAplicar -= aplicar
      if (cuota.monto_pagado >= cuota.monto_proyectado) {
        cuota.estado = "pagado"
        cuota.fecha_pago = pago.fecha_pago
      } else if (cuota.monto_pagado > 0) {
        cuota.estado = "parcial"
      }
    }
    resto = porAplicar
  }
  return result
}
