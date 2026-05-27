const fs = require("fs")
const path = require("path")

const PRN_PATH = path.join(__dirname, "..", "data", "Recaudo_mp.prn")
const DATA_DIR = path.join(__dirname, "..", "data")

const buf = fs.readFileSync(PRN_PATH)
const lines = buf.toString("latin1").split(/\r?\n/)
const h = lines[0]

const MONTH_COLS = [
  { period: "2025-10", pos: 55 },
  { period: "2025-11", pos: 65 },
  { period: "2025-12", pos: 75 },
  { period: "2026-01", pos: 85 },
  { period: "2026-02", pos: 95 },
  { period: "2026-03", pos: 105 },
  { period: "2026-04", pos: 115 },
  { period: "2026-05", pos: 125 },
]

const MONTHS_MAP = {
  Jan: "01", Feb: "02", Mar: "03", Apr: "04", May: "05", Jun: "06",
  Jul: "07", Aug: "08", Sep: "09", Oct: "10", Nov: "11", Dec: "12",
}

function extractMonths(headerLine) {
  const months = []
  for (let i = 0; i < headerLine.length - 5; i++) {
    const chunk = headerLine.substring(i, i + 6)
    if (/^[A-Z][a-z]{2}-\d{2}$/.test(chunk)) {
      const m = MONTHS_MAP[chunk.substring(0, 3)]
      const y = 2000 + Number.parseInt(chunk.substring(4))
      months.push({ period: `${y}-${m}`, pos: i })
    }
  }
  return months
}

const headerMonths = extractMonths(h)
console.log("Header months:", headerMonths.map(m => `${m.period}@${m.pos}`).join(", "))

function extractValues(line) {
  const regex = /\d{1,3}(?:,\d{3})*/g
  const values = []
  let match
  while ((match = regex.exec(line)) !== null) {
    const val = parseInt(match[0].replace(/,/g, ""))
    if (val > 100000) {
      values.push({ val, pos: match.index })
    }
  }
  return values
}

function mapValuesToMonths(values, months, threshold) {
  const schedule = {}
  if (!months.length) return schedule
  for (const v of values) {
    let bestDist = Infinity
    let bestPeriod = months[0].period
    for (const m of months) {
      const dist = Math.abs(v.pos - m.pos)
      if (dist < bestDist) {
        bestDist = dist
        bestPeriod = m.period
      }
    }
    if (bestDist <= threshold) {
      schedule[bestPeriod] = (schedule[bestPeriod] || 0) + v.val
    }
  }
  return schedule
}

function extractCert(line) {
  const m = line.match(/^\s*(\d+)/)
  return m ? parseInt(m[1]) : null
}

function extractValues(line) {
  const regex = /\d{1,3}(?:,\d{3})*/g
  const values = []
  let match
  while ((match = regex.exec(line)) !== null) {
    const val = parseInt(match[0].replace(/,/g, ""))
    if (val > 100000) {
      values.push({ val, pos: match.index })
    }
  }
  return values
}

function mapValuesToMonths(values, months, threshold) {
  const schedule = {}
  if (!months.length) return schedule
  for (const v of values) {
    let bestDist = Infinity
    let bestPeriod = months[0].period
    for (const m of months) {
      const dist = Math.abs(v.pos - m.pos)
      if (dist < bestDist) {
        bestDist = dist
        bestPeriod = m.period
      }
    }
    if (bestDist <= threshold) {
      schedule[bestPeriod] = (schedule[bestPeriod] || 0) + v.val
    }
  }
  return schedule
}

// --- Parse all data rows ---
const results = []
let totalRecaudo = 0
let totalRows = 0
let partnersWithData = 0

for (let i = 1; i < lines.length; i++) {
  const l = lines[i]
  if (!l || !l.trim()) continue
  const cert = extractCert(l)
  if (!cert || cert < 1) continue

  const allVals = extractValues(l)
  const recaudo = mapValuesToMonths(allVals, headerMonths, 12)

  const total = Object.values(recaudo).reduce((s, v) => s + v, 0)
  if (total > 0) partnersWithData++
  totalRows += Object.keys(recaudo).length
  totalRecaudo += total

  results.push({ cert, recaudo, total })
}

console.log("\n=== RECAUDO RESULTS ===")
console.log(`Partners: ${results.length}`)
console.log(`Partners with data: ${partnersWithData}`)
console.log(`Total rows: ${totalRows}`)
console.log(`Total recaudo: $${totalRecaudo.toLocaleString()}`)

// Show first 5
results.slice(0, 5).forEach(r => {
  const periods = Object.keys(r.recaudo).sort()
  console.log(`\nCert ${r.cert}:`)
  console.log(`  Periods: ${periods.map(p => `${p}=$${(r.recaudo[p] / 1e6).toFixed(1)}M`).join(", ")}`)
  console.log(`  Total: $${r.total.toLocaleString()}`)
})

// --- Compare with existing plan schedules ---
const planData = JSON.parse(fs.readFileSync(path.join(DATA_DIR, "pago_pactado_planes.json"), "utf8"))
console.log("\n=== COMPARISON WITH PLAN SCHEDULES (first 10 partners) ===")
let matchCount = 0
let diffCount = 0
let totalDiff = 0

results.slice(0, 10).forEach(r => {
  const plan = planData.find(p => p.certificado_no === r.cert)
  if (!plan) return

  const planOctMay = {}
  for (const k of Object.keys(r.recaudo)) {
    planOctMay[k] = plan.schedules[k] || 0
  }

  let diffs = []
  for (const k of Object.keys(r.recaudo)) {
    const recVal = r.recaudo[k]
    const planVal = planOctMay[k]
    if (recVal !== planVal) {
      diffs.push(`${k}: rec=${recVal} plan=${planVal} diff=${recVal - planVal}`)
    }
  }

  if (diffs.length === 0) {
    matchCount++
    console.log(`  Cert ${r.cert}: SAME as plan schedule`)
  } else {
    diffCount++
    totalDiff += diffs.reduce((s, d) => s + Math.abs(parseInt(d.match(/diff=([-\d]+)/)?.[1] || "0")), 0)
    console.log(`  Cert ${r.cert}: DIFFERS`)
    diffs.forEach(d => console.log(`    ${d}`))
  }
})

console.log(`\nMatch: ${matchCount}, Diff: ${diffCount}, Total diff amt: $${totalDiff.toLocaleString()}`)

// --- Generate SQL ---
let insertSQL = `-- Recaudo MP: actual payments collected Oct-25 to May-26
-- ${results.length} partners, ${partnersWithData} with data
-- Total recaudo: $${totalRecaudo.toLocaleString()}

BEGIN;

-- Clear any previously imported recaudo records (idempotent)
DELETE FROM pagos WHERE concepto LIKE 'Recaudo%';

`

let updateSQL = `-- Update planes_pago with recaudo amounts

BEGIN;

`

let insertCount = 0
let updateCount = 0

for (const r of results) {
  const periods = Object.keys(r.recaudo).sort()
  if (periods.length === 0) continue

  for (const period of periods) {
    const monto = r.recaudo[period]
    if (monto <= 0) continue

    // INSERT into pagos table
    insertCount++
    const dateParts = period.split("-")
    const lastDay = new Date(parseInt(dateParts[0]), parseInt(dateParts[1]), 0).getDate()
    const fechaPago = `${period}-${String(lastDay).padStart(2, "0")}`

    insertSQL += `INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = ${r.cert}), ${monto}, '${fechaPago}', 'cuota', 'Recaudo ${period}');
`
    // UPDATE planes_pago
    updateCount++
    updateSQL += `UPDATE planes_pago
SET monto_pagado = ${monto},
    estado = CASE WHEN ${monto} >= monto_proyectado THEN 'pagado' WHEN ${monto} > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = ${r.cert})
  AND periodo = '${period}';
`
  }
}

insertSQL += `COMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS pagos, SUM(monto) AS total FROM pagos WHERE concepto LIKE 'Recaudo%';
`

updateSQL += `COMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS actualizados FROM planes_pago WHERE monto_pagado > 0;
`

fs.writeFileSync(path.join(DATA_DIR, "recaudo_mp_insert.sql"), insertSQL, "utf8")
fs.writeFileSync(path.join(DATA_DIR, "recaudo_mp_update.sql"), updateSQL, "utf8")

console.log(`\n=== SQL GENERATED ===`)
console.log(`INSERT: ${insertCount} payments into pagos table`)
console.log(`UPDATE: ${updateCount} plan periods in planes_pago`)
console.log(`Files: recaudo_mp_insert.sql, recaudo_mp_update.sql`)
