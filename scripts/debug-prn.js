const fs = require("fs")
const content = fs.readFileSync("C:\\Users\\Usuario\\Downloads\\2026 02 18 Base de Datos Master Plan.prn", "utf8")
const lines = content.split("\n").map(l => l.replace(/\r$/, ""))

// Show recaudo header and first data row
console.log("=== HEADER (line 1532) ===")
console.log(lines[1531])

console.log("\n=== FIRST DATA ROW (line 1533) ===")
console.log(lines[1532])

// Show first data row with character index markers
const line = lines[1532]
for (let i = 0; i < line.length; i += 15) {
  const chunk = line.substring(i, Math.min(i + 15, line.length))
  console.log(i.toString().padStart(4) + ': "' + chunk + '"')
}

// Extract all tokens
const tokens = line.trim().split(/\s+/)
console.log("\n=== TOKENS (" + tokens.length + ") ===")
tokens.forEach((t, i) => console.log(i + ': "' + t + '"'))

// Token types
console.log("\n=== TOKEN TYPES ===")
tokens.forEach((t, i) => {
  const hasComma = /^\d{1,3}(?:,\d{3})+$/.test(t)
  const isZero = /^0+$/.test(t)
  console.log(i + ': "' + t + '" ' + (hasComma ? "COMMA" : isZero ? "ZERO" : "OTHER"))
})

// Analyze more data rows for pattern
for (let ri = 1532; ri < 1545; ri++) {
  const l = lines[ri]
  if (!l || l.trim().length < 10) continue
  const tkns = l.trim().split(/\s+/)
  const commaVals = tkns.filter(t => /^\d{1,3}(?:,\d{3})+$/.test(t))
  const zeros = tkns.filter(t => /^0+$/.test(t))
  console.log("Row " + (ri + 1) + ": tokens=" + tkns.length + ", comma=" + commaVals.length + ", zeros=" + zeros.length + ", vals=" + commaVals.join(","))
}

// Now count how many rows in total recaudo section
let dataRowCount = 0
for (let ri = 1532; ri < 1900; ri++) {
  const l = lines[ri]
  if (!l || l.trim().length < 10) continue
  const tkns = l.trim().split(/\s+/)
  const commaVals = tkns.filter(t => /^\d{1,3}(?:,\d{3})+$/.test(t))
  if (commaVals.length > 0 && !/^(Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|Check|Total)/i.test(l.trim())) {
    dataRowCount++
  }
}
console.log("\nTotal recaudo data rows (non-header, non-total): " + dataRowCount)
