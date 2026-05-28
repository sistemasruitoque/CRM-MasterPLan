import { createClient } from "@supabase/supabase-js"

const SUPABASE_URL = "https://ailnztbkrgnnjccipztj.supabase.co"
const SUPABASE_KEY = "sb_publishable_ozkbUAswbu_Dx41kOhY2Qg_fk96MEnH"
const supabase = createClient(SUPABASE_URL, SUPABASE_KEY)

const { data: socio, error: sErr } = await supabase
  .from("socios")
  .select("*")
  .eq("certificado_no", 779)
  .single()

if (sErr) { console.error("Error socio:", sErr.message); process.exit(1) }
console.log("SOCIO:")
console.log(JSON.stringify(socio, null, 2))

const { data: pagos, error: pErr } = await supabase
  .from("pagos")
  .select("*")
  .eq("socio_id", socio.id)
  .order("fecha_pago")

if (pErr) { console.error("Error pagos:", pErr.message); process.exit(1) }
console.log("\nPAGOS (" + pagos.length + "):")
const pTotal = pagos.reduce((s, p) => s + p.monto, 0)
console.log("Total pagado: " + pTotal.toLocaleString())
for (const p of pagos) {
  console.log(`  ${p.fecha_pago}: $${p.monto.toLocaleString()} (${p.tipo} - ${p.concepto})`)
}

const { data: planes, error: plErr } = await supabase
  .from("planes_pago")
  .select("*")
  .eq("socio_id", socio.id)
  .order("periodo")

if (plErr) { console.error("Error planes:", plErr.message); process.exit(1) }
console.log("\nPLANES_PAGO (" + planes.length + "):")
const plTotal = planes.reduce((s, p) => s + p.monto_pagado, 0)
console.log("Total monto_pagado: " + plTotal.toLocaleString())
for (const p of planes) {
  console.log(`  ${p.periodo}: proy=$${p.monto_proyectado.toLocaleString()} pag=$${p.monto_pagado.toLocaleString()} ${p.estado}`)
}
