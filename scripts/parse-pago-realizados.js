const fs = require("fs")
const path = require("path")

const PRN_PATH = path.join(__dirname, "..", "data", "pago_realizados.prn")
const DATA_DIR = path.join(__dirname, "..", "data")

const buf = fs.readFileSync(PRN_PATH)
const lines = buf.toString("latin1").split(/\r?\n/)
const h = lines[0]

// Column positions based on header analysis
const MONTH_COLS = [
  { period: "2025-10", pos: 32 }, // Oct-25
  { period: "2025-11", pos: 42 }, // Nov-25
  { period: "2025-12", pos: 52 }, // Dec-25
  { period: "2026-01", pos: 62 }, // Jan-26
  { period: "2026-02", pos: 72 }, // Feb-26
  { period: "2026-03", pos: 82 }, // Mar-26
  { period: "2026-04", pos: 92 }, // Apr-26
  { period: "2026-05", pos: 102 }, // May-26
]

const DATE_COLS = [
  { date: "2025-10-31", pos: 132 }, // 31-Oct
  { date: "2025-11-30", pos: 142 }, // 30-Nov
  { date: "2025-12-31", pos: 152 }, // 31-Dec
  { date: "2026-01-31", pos: 162 }, // 31-Jan
  { date: "2026-02-28", pos: 172 }, // 28-Feb
  { date: "2026-03-31", pos: 182 }, // 31-Mar
  { date: "2026-04-30", pos: 192 }, // 30-Apr
  { date: "2026-05-31", pos: 202 }, // 31-May
]

function extractValues(line) {
  const regex = /\d{1,3}(?:,\d{3})*/g
  const values = []
  let match
  while ((match = regex.exec(line)) !== null) {
    const val = parseInt(match[0].replace(/,/g, ""))
    if (val > 100000) { // filter out noise (fragments, cert#, cedula parts)
      values.push({ val, pos: match.index })
    }
  }
  return values
}

function mapValuesToCols(values, cols, threshold) {
  const result = {}
  if (!cols.length) return result
  for (const v of values) {
    let bestDist = Infinity
    let bestKey = cols[0].period || cols[0].date
    for (const c of cols) {
      const dist = Math.abs(v.pos - c.pos)
      if (dist < bestDist) {
        bestDist = dist
        bestKey = c.period || c.date
      }
    }
    if (bestDist <= threshold) {
      result[bestKey] = (result[bestKey] || 0) + v.val
    }
  }
  return result
}

function extractCert(line) {
  const m = line.match(/^\s*(\d+)/)
  return m ? parseInt(m[1]) : null
}

function extractName(line) {
  // Name starts after cedula digits (around pos 13-26 roughly)
  let s = ""
  for (let i = 13; i < Math.min(30, line.length); i++) {
    if (/\d/.test(line[i])) s += line[i]
    else if (s.length > 0) break
  }
  let cedEnd = 13
  for (let i = 13; i < Math.min(30, line.length); i++) {
    if (!/\d/.test(line[i])) {
      if (i > 13) { cedEnd = i; break }
      cedEnd = i + 1
    } else {
      cedEnd = i + 1
    }
  }
  return line.substring(cedEnd, 40).trim()
}

const results = []
let totalPlanRows = 0
let totalPayments = 0
let totalPaymentAmount = 0
let partnersWithPayments = 0

for (let i = 1; i < lines.length; i++) {
  const l = lines[i]
  if (!l || !l.trim()) continue
  const cert = extractCert(l)
  if (!cert || cert < 1) continue

  const name = extractName(l)
  const allVals = extractValues(l)

  // Only consider values in the payment date column region (pos >= 125)
  const paymentVals = allVals.filter(v => v.pos >= 125)
  const payments = mapValuesToCols(paymentVals, DATE_COLS, 12)

  const paymentTotal = Object.values(payments).reduce((s, v) => s + v, 0)

  if (paymentTotal > 0) {
    partnersWithPayments++
    totalPayments += Object.keys(payments).length
    totalPaymentAmount += paymentTotal
  }

  results.push({
    cert,
    name,
    payments,
    paymentTotal,
  })
}

// Generate SQL
let sql = `-- Pagos realizados extracted from pago_realizados.prn
-- ${results.length} partners, ${partnersWithPayments} with payments
-- Total payments: ${totalPayments} rows, \$ ${totalPaymentAmount.toLocaleString()}

BEGIN;

`

let paymentCount = 0
const paymentRows = []

for (const r of results) {
  const dates = Object.keys(r.payments).sort()
  if (dates.length === 0) continue

  for (const date of dates) {
    const monto = r.payments[date]
    paymentCount++
    const concepto = `Pago realizado ${date}`
    paymentRows.push({
      socio_cert: r.cert,
      fecha_pago: date,
      monto,
      tipo: "cuota",
      concepto,
    })

    sql += `INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = ${r.cert}), ${monto}, '${date}', 'cuota', '${concepto}');
`
  }
}

sql += `\nCOMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS pagos, SUM(monto) AS total FROM pagos;
`

// Second SQL: update planes_pago with actual payment amounts
let updateSQL = `-- Update planes_pago with actual payments received
-- Matching payments to plan periods by year-month

BEGIN;

`

let updateCount = 0
for (const r of results) {
  const dates = Object.keys(r.payments).sort()
  if (dates.length === 0) continue
  for (const date of dates) {
    const period = date.substring(0, 7)
    const monto = r.payments[date]
    updateSQL += `UPDATE planes_pago
SET monto_pagado = monto_pagado + ${monto},
    estado = CASE
      WHEN monto_pagado + ${monto} >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + ${monto} > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = ${r.cert})
  AND periodo = '${period}';
`
    updateCount++
  }
}

updateSQL += `\nCOMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS actualizados FROM planes_pago WHERE monto_pagado > 0;
`

const updateSqlPath = path.join(DATA_DIR, "pagos_realizados_update.sql")
fs.writeFileSync(updateSqlPath, updateSQL, "utf8")

// Append update SQL to main sql file
sql += `\n\n-- =============================================
-- Update planes_pago with actual payments
-- =============================================
` + updateSQL.replace("BEGIN;\n\n", "")

const sqlPath = path.join(DATA_DIR, "pagos_realizados.sql")
fs.writeFileSync(sqlPath, sql, "utf8")

console.log("=== PAGOS REALIZADOS ===")
console.log(`Partners: ${results.length}`)
console.log(`Partners with payments: ${partnersWithPayments}`)
console.log(`Total payment rows: ${totalPayments}`)
console.log(`Total payment amount: \$ ${totalPaymentAmount.toLocaleString()}`)
console.log(`SQL written to: pagos_realizados.sql`)

// Show payments per partner
console.log("\n=== PAYMENTS ===")
for (const r of results) {
  if (Object.keys(r.payments).length === 0) continue
  console.log(`\nCert ${r.cert} (${r.name}):`)
  console.log(`  Payments: ${JSON.stringify(r.payments)}`)
}
