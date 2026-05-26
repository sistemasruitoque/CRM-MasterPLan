import { createClient } from "@supabase/supabase-js"

const supabaseUrl = typeof process !== "undefined" ? process.env.NEXT_PUBLIC_SUPABASE_URL || "" : ""
const supabaseAnonKey = typeof process !== "undefined" ? process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "" : ""

let client: ReturnType<typeof createClient> | null = null
let initAttempted = false

function getClient() {
  if (initAttempted) return client
  initAttempted = true
  if (!supabaseUrl || !supabaseAnonKey) {
    client = null
    return null
  }
  try {
    client = createClient(supabaseUrl, supabaseAnonKey)
  } catch {
    client = null
  }
  return client
}

function nopPromise() {
  return Promise.resolve({ data: null, error: new Error("Supabase no configurado") })
}

function nopBuilder() {
  const b: any = () => b
  b.select = () => nopPromise()
  b.insert = () => ({ select: () => nopPromise() })
  b.update = () => ({ select: () => nopPromise() })
  b.delete = () => nopPromise()
  b.upsert = () => ({ select: () => nopPromise() })
  b.order = () => b
  b.eq = () => b
  b.in = () => b
  b.limit = () => b
  b.single = () => nopPromise()
  b.maybeSingle = () => nopPromise()
  b.range = () => b
  b.gte = () => b
  b.lte = () => b
  b.neq = () => b
  b.is = () => b
  b.textSearch = () => b
  b.filter = () => b
  b.not = () => b
  b.or = () => b
  b.contains = () => b
  b.returns = () => b
  b.then = undefined
  return b
}

export const supabase = new Proxy({} as ReturnType<typeof createClient>, {
  get(_, prop: string) {
    const c = getClient()
    if (!c) {
      if (prop === "from") return () => nopBuilder()
      if (prop === "channel") return () => ({ subscribe: () => {}, unsubscribe: () => {} })
      if (typeof prop === "string" && (prop.startsWith("rpc") || prop.startsWith("functions"))) return () => nopPromise()
      return undefined
    }
    return (c as any)[prop]
  },
})
