import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

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

export function currentPeriod(): string {
  const d = new Date()
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}`
}

export function parseDate(d: string): string {
  if (!d) return "-"
  const parts = d.split("-")
  if (parts.length === 3 && MONTH_MAP[parts[0]]) {
    return `${parts[2]}-${MONTH_MAP[parts[0]]}-${parts[1]}`
  }
  return d
}
