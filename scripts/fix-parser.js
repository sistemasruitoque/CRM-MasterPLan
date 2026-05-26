const fs = require("fs")

const content = fs.readFileSync("C:\\Users\\Usuario\\Downloads\\2026 02 18 Base de Datos Master Plan.prn", "utf8")
const lines = content.split("\n").map(l => l.replace(/\r$/, ""))

// Analyze lines 1530-1900 to find recaudo data rows
console.log("=== ANALYZING LINES 1530-1900 ===")
for (let i = 1529; i < Math.min(lines.length, 1900); i++) {
  const line = lines[i]
  if (!line || line.trim().length < 5) {
    console.log(`Line ${i+1}: [EMPTY]`)
    continue
  }
  const trimmed = line.trim()
  // Check if starts with a letter
  const startsWithAlpha = /^[A-Za-z]/.test(trimmed)
  const commaVals = (line.match(/\d{1,3}(?:,\d{3})+/g) || []).length
  const hasComma = commaVals > 0
  // Check if starts with a comma-format number
  const startsWithComma = /^\d{1,3}(?:,\d{3})/.test(trimmed)
  // Check for specific known patterns
  const isEvenRow = /^\d{1,3}(?:,\d{3})+\s+\d{1,3}(?:,\d{3})+\s+\d{1,3}(?:,\d{3})+\s+\d{1,3}(?:,\d{3})+\s+\d{1,3}(?:,\d{3})+\s+\d{1,3}(?:,\d{3})/.test(trimmed)
  
  console.log(`Line ${i+1} (len=${line.length}): alpha=${startsWithAlpha}, comma=${commaVals}, startsComma=${startsWithComma} "${trimmed.substring(0, 60)}"`)
}
