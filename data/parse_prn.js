const fs = require("fs")

const raw = fs.readFileSync("data/Recaudo_mp.prn", "utf8")
const lines = raw.split("\n").slice(1).filter(l => l.trim().length > 0)

const monthLabels = ["Oct-25", "Nov-25", "Dec-25", "Jan-26", "Feb-26", "Mar-26", "Apr-26", "May-26"]
const months = ["2025-10", "2025-11", "2025-12", "2026-01", "2026-02", "2026-03", "2026-04", "2026-05"]
const COL_W = 10

function parseAmount(s) {
  s = s.trim()
  if (!s || s === "0") return 0
  return parseInt(s.replace(/,/g, ""), 10)
}

const sqlLines = ["DELETE FROM pagos;"]
let totalPayments = 0
const sociosSet = new Set()

for (const line of lines) {
  const clean = line.replace(/\r$/, "")
  const certNo = parseInt(clean, 10)
  if (isNaN(certNo) || certNo <= 0) continue

  // Last N chars = 8 payment columns of 10 chars each
  const section = clean.slice(-80)

  for (let i = 0; i < 8; i++) {
    const chunk = section.slice(i * COL_W, i * COL_W + COL_W)
    const monto = parseAmount(chunk)
    if (monto > 0) {
      sqlLines.push(
        `INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) SELECT id, ${monto}, '${months[i]}-15', 'cuota', 'Cuota ${monthLabels[i]}' FROM socios WHERE certificado_no = ${certNo};`
      )
      totalPayments++
      sociosSet.add(certNo)
    }
  }
}

console.log(sqlLines.join("\n"))
console.log(`\n-- Total: ${totalPayments} payments for ${sociosSet.size} socios`)
