const fs = require("fs")
const content = fs.readFileSync("C:\\Users\\Usuario\\Downloads\\2026 02 18 Base de Datos Master Plan.prn", "utf8")
const lines = content.split("\n").map(l => l.replace(/\r$/, ""))

// Show header with character indices
const header = lines[1531]
console.log("=== HEADER (char positions) ===")
// Find positions of each column header
const cols = ["Apr-30", "May-30", "Jun-30", "Jul-30", "Aug-30", "Sep-30", "Oct-30", "Nov-30", "Dec-30", "Jan-31", "Check", "Oct-25", "Nov-25", "Dec-25", "Jan-26", "Feb-26", "Mar-26", "Apr-26", "May-26", "Total"]
for (const col of cols) {
  const pos = header.indexOf(col)
  if (pos > -1) console.log(col + " starts at char " + pos)
}

console.log("\n=== DATA ROW 1 (char positions) ===")
const d1 = lines[1532]
const tokens = d1.trim().split(/\s+/)
console.log("Full line length: " + d1.length)
// Find position of each token in the line
let searchPos = 0
for (const t of tokens) {
  const pos = d1.indexOf(t, searchPos)
  console.log("Token '" + t + "' at char " + pos)
  searchPos = pos + 1
}

// Now build mapping: which tokens correspond to which columns
console.log("\n=== COLUMN MAPPING ===")
// Based on character positions:
// - Apr-30 at pos ~0-10 (header)
// - Tokens start appearing around char 108+
// So: first 10 projection columns (Apr-30 through Jan-31) are all 0 in data
// They appear as whitespace + "0" tokens

// Analyze the whitespace between token positions
let prev = 0
for (const t of tokens) {
  const pos = d1.indexOf(t, prev)
  const gap = d1.substring(prev, pos)
  const gapLen = gap.length
  // Count how many "0" characters are in the gap that are NOT part of other numbers
  // Each isolated "0" (surrounded by spaces) represents a zero-value column
  if (gapLen > 0) {
    // Count "0" surrounded by spaces
    const zeroMatches = gap.match(/\b0\b/g)
    console.log("Gap from " + prev + " to " + pos + " (len=" + gapLen + "): " + JSON.stringify(gap.substring(0,40)) + (zeroMatches ? " zeros=" + zeroMatches.length : " no zeros"))
  }
  prev = pos + t.length
}

// Simple approach: count total data positions (columns) based on known format
// The Recuado A section columns (in order):
// 10 far-future projections (Apr-30..Jan-31) = all 0
// 1 Check column = 0 
// 8 monthly (Oct-25..May-26) = mixed
// 1 Total Recaudo A = sum of monthly
// Total: 20 values per row

// In the whitespace split:
// - Leading zeros correspond to far-future projections + Check
// - Then comma-formatted values for monthly columns
// - Padded with zeros for months with no payment
// - Final value is Total Recaudo A

// Let's figure out how many "virtual" columns exist before the first comma value
// For row 1: tokens = 10, so 20-10 = 10 virtual columns are absorbed
// Row 1 has 2 zeros + 5 comma values + 3 more values (some zero, some comma) + 1 final total = 10 tokens
// But we need 20 values.

// Actually the split by whitespace is unreliable. Let me try splitting by runs of spaces.
const parts = d1.split(/ {2,}/)
console.log("\n=== PARTS SPLIT BY 2+ SPACES ===")
parts.forEach((p, i) => console.log(i + ': len=' + p.length + ' "' + p.trim() + '"'))

// Now try this: split by 2+ spaces for ALL data rows in recaudo section
console.log("\n=== ALL DATA ROW STRUCTURES ===")
let dataRows = 0
for (let ri = 1532; ri < 1900; ri++) {
  const l = lines[ri]
  if (!l || l.trim().length < 10) continue
  const tkns = l.trim().split(/\s+/)
  const commaVals = tkns.filter(t => /^\d{1,3}(?:,\d{3})+$/.test(t))
  if (commaVals.length === 0) continue
  if (/^(Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|Check|Total|Saldo)/i.test(l.trim())) continue
  if (tkns.length <= 2) continue
  dataRows++
  if (dataRows <= 3 || dataRows % 20 === 0) {
    console.log("Row " + (ri + 1) + ": tokens=" + tkns.length + ", comma=" + commaVals.length + ", last_token=" + tkns[tkns.length-1])
  }
}
console.log("Total recaudo data rows: " + dataRows)

// Now let me try a positional approach: extract values based on known column start positions
// From header analysis:
// Check column starts around where "Check" appears in header
// Oct-25 column starts around where "Oct-25" appears
// etc.

// Let me find exact positions of each data column
console.log("\nHeader column positions:")
for (const col of cols) {
  const pos = header.indexOf(col)
  if (pos > -1) {
    // Find the end of this column
    const nextCol = cols[cols.indexOf(col) + 1]
    const nextPos = nextCol ? header.indexOf(nextCol) : header.length
    const width = nextPos > pos ? nextPos - pos : 15
    console.log("  " + col + ": start=" + pos + ", width=" + width)
  }
}
