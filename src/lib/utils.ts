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

export function parseDate(d: string): string {
  if (!d) return "-"
  const months: Record<string, string> = {
    "Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04",
    "May": "05", "Jun": "06", "Jul": "07", "Aug": "08",
    "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12",
  }
  const parts = d.split("-")
  if (parts.length === 3 && months[parts[0]]) {
    return `${parts[2]}-${months[parts[0]]}-${parts[1]}`
  }
  return d
}
