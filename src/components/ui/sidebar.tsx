"use client"

import Link from "next/link"
import { usePathname } from "next/navigation"
import { cn } from "@/lib/utils"
import {
  LayoutDashboard,
  Users,
  CreditCard,
  FileBarChart,
  LogOut,
  Building2,
} from "lucide-react"

const links = [
  { href: "/dashboard", label: "Dashboard", icon: LayoutDashboard },
  { href: "/socios", label: "Socios", icon: Users },
  { href: "/pagos", label: "Plan de Pagos", icon: CreditCard },
  { href: "/reportes", label: "Reportes", icon: FileBarChart },
]

export function Sidebar() {
  const pathname = usePathname()

  return (
    <aside className="w-64 bg-zinc-900 text-zinc-100 flex flex-col h-screen">
      <div className="p-5 border-b border-zinc-700">
        <div className="flex items-center gap-2">
          <Building2 className="h-6 w-6 text-emerald-400" />
          <span className="font-bold text-lg">Club CRM</span>
        </div>
        <p className="text-xs text-zinc-400 mt-1">Gestión de Socios</p>
      </div>
      <nav className="flex-1 p-3 space-y-1">
        {links.map((link) => {
          const Icon = link.icon
          const active = pathname === link.href || pathname.startsWith(link.href + "/")
          return (
            <Link
              key={link.href}
              href={link.href}
              className={cn(
                "flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium transition-colors",
                active
                  ? "bg-emerald-600 text-white"
                  : "text-zinc-300 hover:bg-zinc-800 hover:text-white"
              )}
            >
              <Icon className="h-4 w-4" />
              {link.label}
            </Link>
          )
        })}
      </nav>
      <div className="p-3 border-t border-zinc-700">
        <Link
          href="/login"
          className="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-zinc-300 hover:bg-zinc-800 hover:text-white transition-colors"
        >
          <LogOut className="h-4 w-4" />
          Cerrar Sesión
        </Link>
      </div>
    </aside>
  )
}
