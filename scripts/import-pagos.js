const fs = require("fs")
const path = require("path")

const PRN_PATH = process.argv[2] || "C:\\Users\\Usuario\\Downloads\\2026 02 18 Base de Datos Master Plan.prn"
const SOCIOS_PATH = path.join(__dirname, "..", "data", "socios.json")

function parseCop(str) {
  if (!str || !str.trim()) return 0
  return Number.parseInt(str.trim().replace(/[,.]/g, ""), 10) || 0
}

// Load socios with VF -> socio lookup
const socios = JSON.parse(fs.readFileSync(SOCIOS_PATH, "utf8"))

// Build VF -> [socios] map (handles duplicates)
const vfMap = {}
for (const s of socios) {
  const key = s.valor_final
  if (!vfMap[key]) vfMap[key] = []
  vfMap[key].push(s)
}

// Group VFs that have duplicates
const dupeVFs = Object.keys(vfMap).filter(k => vfMap[k].length > 1)
console.log(`Total socios: ${socios.length}`)
console.log(`Unique VF values: ${Object.keys(vfMap).length}`)
console.log(`Duplicate VF values: ${dupeVFs.length} groups`)
for (const vf of dupeVFs) {
  const names = vfMap[vf].map(s => `#${s.certificado_no} ${s.nombre}`).join(", ")
  console.log(`  ${parseInt(vf).toLocaleString("en-US")}: ${names}`)
}

// Parse payment tracking section
const content = fs.readFileSync(PRN_PATH, "utf8")
const lines = content.split("\n").map(l => l.replace(/\r$/, ""))

// Track used socios (for duplicate VF handling)
const usedSocioIds = new Set()
const pagos = []

// Process lines 2000-2269
for (let i = 1999; i < Math.min(lines.length, 2270); i++) {
  const line = lines[i]
  if (!line || line.trim().length < 20) continue

  // Extract all COP-format monetary values
  const matches = line.match(/-?\d{1,3}(?:,\d{3})+/g)
  if (!matches || matches.length < 1) continue

  const vals = matches.map(m => parseCop(m))
  const vf = vals[0]

  // Find matching socio by VF
  const candidates = vfMap[vf] || []
  if (candidates.length === 0) continue

  // Filter out already-used socios
  let available = candidates.filter(s => !usedSocioIds.has(s.certificado_no))
  if (available.length === 0) {
    // All used, skip this row
    continue
  }

  // Extract the "abonos" (total received) value
  // Pattern analysis:
  // - 2 comma-values (VF + 1): cuota only, no payment received
  // - 3 comma-values (VF + 2): cuota + abono received
  // - 4+ comma-values: includes monthly amounts + cuota + abono
  const nonVf = vals.slice(1).filter(v => v !== 0)

  let totalAbonos = 0
  let monthlyAmount = 0

  if (nonVf.length >= 2) {
    // If last value == VF, full payment
    // Otherwise last value = total abonos
    totalAbonos = nonVf[nonVf.length - 1]
    // Monthly amounts are the non-VF values that aren't the last one
    const monthlyValues = nonVf.slice(0, -1).filter(v => Math.abs(v) < Math.abs(vf) && v > 0)
    if (monthlyValues.length > 0) {
      monthlyAmount = monthlyValues.reduce((a, b) => a + b, 0)
    }
  } else if (nonVf.length === 1) {
    // Single non-VF value. Could be cuota (no payment) or could be a payment.
    // Check if non-VF == VF (fully paid in a single line item)
    if (Math.abs(nonVf[0]) === vf) {
      totalAbonos = nonVf[0]
    }
    // Otherwise: it's just a cuota, no payment received
  }

  if (totalAbonos === 0 && monthlyAmount === 0) continue

  // Handle the amount: use totalAbonos if available, otherwise monthlyAmount
  const montoRecibido = totalAbonos !== 0 ? totalAbonos : monthlyAmount
  if (montoRecibido === 0) continue

  // Pick the socio (first available)
  const socio = available[0]
  usedSocioIds.add(socio.certificado_no)

  // Determine payment date (from the PRN context - cerca Feb 2026)
  const fechaPago = "2026-02-18"

  pagos.push({
    certificado_no: socio.certificado_no,
    nombre: socio.nombre,
    valor_final: vf,
    monto: Math.abs(montoRecibido),
    fecha_pago: fechaPago,
    tipo: montoRecibido < 0 ? "ajuste" : "cuota",
    concepto: montoRecibido < 0
      ? `Ajuste/exoneración (${montoRecibido.toLocaleString("en-US")})`
      : `Abono recibido: ${montoRecibido.toLocaleString("en-US")}`,
  })
}

console.log(`\nPayment records extracted: ${pagos.length}`)
console.log(`Socios with payments: ${usedSocioIds.size}`)

// Print some examples
for (const p of pagos.slice(0, 5)) {
  console.log(`  #${p.certificado_no} ${p.nombre}: $${p.monto.toLocaleString("en-US")} - ${p.concepto}`)
}

// Generate INSERT SQL (lookup UUID from certificado_no)
const sqlLines = []
for (const p of pagos) {
  sqlLines.push(
    `INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) SELECT id, ${p.monto}, '${p.fecha_pago}', '${p.tipo}', '${p.concepto.replace(/'/g, "''")}' FROM socios WHERE certificado_no = ${p.certificado_no};`
  )
}

const sqlPath = path.join(__dirname, "..", "data", "pagos.sql")
fs.writeFileSync(sqlPath, sqlLines.join("\n"), "utf8")
console.log(`\nSQL written: ${sqlPath} (${sqlLines.length} statements)`)

// Also write JSON for inspection
const jsonPath = path.join(__dirname, "..", "data", "pagos.json")
fs.writeFileSync(jsonPath, JSON.stringify(pagos, null, 2), "utf8")
console.log(`JSON written: ${jsonPath}`)
