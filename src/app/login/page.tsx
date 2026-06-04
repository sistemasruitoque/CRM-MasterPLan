"use client"

import { useState } from "react"
import { useRouter } from "next/navigation"
import { Building2, Eye, EyeOff } from "lucide-react"

const users = [
  { name: "Admin", password: "admin123" },
  { name: "Cartera", password: "cartera123" },
]

export default function LoginPage() {
  const [selectedUser, setSelectedUser] = useState("Admin")
  const [password, setPassword] = useState("")
  const [show, setShow] = useState(false)
  const [error, setError] = useState("")
  const router = useRouter()

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault()
    const user = users.find(u => u.name === selectedUser)
    if (user && password === user.password) {
      localStorage.setItem("club-auth", "true")
      localStorage.setItem("club-user", user.name)
      router.push("/dashboard")
    } else {
      setError("Contraseña incorrecta")
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-zinc-900 via-zinc-800 to-emerald-950">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-8 mx-4">
        <div className="flex flex-col items-center mb-8">
          <div className="bg-emerald-100 p-3 rounded-full mb-4">
            <Building2 className="h-8 w-8 text-emerald-600" />
          </div>
          <h1 className="text-2xl font-bold text-zinc-900">Club CRM</h1>
          <p className="text-sm text-zinc-500 mt-1">Gestión de Socios y Plan de Pagos</p>
        </div>

        <form onSubmit={handleLogin} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-zinc-700 mb-1">Usuario</label>
            <select value={selectedUser} onChange={e => { setSelectedUser(e.target.value); setError("") }}
              className="w-full px-4 py-2.5 border border-zinc-300 rounded-lg focus:ring-2 focus:ring-emerald-500 outline-none">
              {users.map(u => <option key={u.name} value={u.name}>{u.name}</option>)}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-zinc-700 mb-1">Contraseña</label>
            <div className="relative">
              <input
                type={show ? "text" : "password"}
                value={password}
                onChange={(e) => { setPassword(e.target.value); setError("") }}
                className="w-full px-4 py-2.5 border border-zinc-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none pr-10"
                placeholder="Ingrese la contraseña"
              />
              <button
                type="button"
                onClick={() => setShow(!show)}
                className="absolute right-3 top-2.5 text-zinc-400"
              >
                {show ? <EyeOff className="h-5 w-5" /> : <Eye className="h-5 w-5" />}
              </button>
            </div>
            {error && <p className="text-red-500 text-sm mt-1">{error}</p>}
          </div>
          <button
            type="submit"
            className="w-full bg-emerald-600 hover:bg-emerald-700 text-white font-medium py-2.5 rounded-lg transition-colors"
          >
            Ingresar
          </button>
        </form>
      </div>
    </div>
  )
}
