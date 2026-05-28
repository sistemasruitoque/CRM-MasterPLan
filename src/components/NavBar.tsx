"use client"

import Link from "next/link"
import { usePathname } from "next/navigation"
import { cn } from "@/lib/utils"
import { Home, CreditCard, AlertTriangle, Users, FileBarChart, CheckSquare } from "lucide-react"

const links = [
  { href: "/dashboard", label: "Inicio", icon: Home },
  { href: "/pagos", label: "Plan de Pagos", icon: CreditCard },
  { href: "/mora", label: "Mora", icon: AlertTriangle },
  { href: "/socios", label: "Socios", icon: Users },
  { href: "/reportes", label: "Reportes", icon: FileBarChart },
  { href: "/validar", label: "Validar", icon: CheckSquare },
]

export function NavBar() {
  const pathname = usePathname()
  if (pathname === "/login") return null

  return (
    <nav className="sticky top-0 z-50 bg-white border-b border-zinc-200 shadow-sm">
      <div className="max-w-7xl mx-auto px-4 flex items-center gap-1 h-12 overflow-x-auto">
        {links.map((link) => {
          const Icon = link.icon
          const active = pathname === link.href || pathname.startsWith(link.href + "/")
          return (
            <Link
              key={link.href}
              href={link.href}
              className={cn(
                "flex items-center gap-1.5 px-3 py-1.5 rounded-md text-sm font-medium transition-colors whitespace-nowrap",
                active
                  ? "bg-emerald-100 text-emerald-800"
                  : "text-zinc-600 hover:bg-zinc-100 hover:text-zinc-900"
              )}
            >
              <Icon className="h-4 w-4" />
              {link.label}
            </Link>
          )
        })}
      </div>
    </nav>
  )
}
