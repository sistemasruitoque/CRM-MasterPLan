const fs = require("fs");
const path = require("path");

const PRN_PATH = path.join(__dirname, "..", "data", "pago_pactado.prn");
const buf = fs.readFileSync(PRN_PATH);
const lines = buf.toString("latin1").split(/\r?\n/);
const h1 = lines[0];

const MONTHS_MAP = {
  Jan: "01", Feb: "02", Mar: "03", Apr: "04", May: "05", Jun: "06",
  Jul: "07", Aug: "08", Sep: "09", Oct: "10", Nov: "11", Dec: "12",
};

function extractMonths(headerLine) {
  const months = [];
  for (let i = 0; i < headerLine.length - 5; i++) {
    const chunk = headerLine.substring(i, i + 6);
    if (/^[A-Z][a-z]{2}-\d{2}$/.test(chunk)) {
      const m = MONTHS_MAP[chunk.substring(0, 3)];
      const y = 2000 + Number.parseInt(chunk.substring(4));
      months.push({ period: `${y}-${m}`, pos: i });
    }
  }
  return months;
}

function extractValues(line) {
  const regex = /\d{1,3}(?:,\d{3})*/g;
  const values = [];
  let match;
  while ((match = regex.exec(line)) !== null) {
    const val = parseInt(match[0].replace(/,/g, ""));
    if (val > 0) {
      values.push({ val, pos: match.index });
    }
  }
  return values;
}

const months = extractMonths(h1);
console.log("Month columns:");
months.forEach(m => console.log(" ", m.period, "at pos", m.pos));

// Check Mattos line
const mattosLine = lines.find(l => l.includes("Mattos"));
const vals = extractValues(mattosLine);
console.log("\nMattos values:");
vals.forEach(v => {
  let best = null, bestDist = Infinity, bestMonth = "none";
  for (const m of months) {
    const dist = Math.abs(v.pos - m.pos);
    if (dist < bestDist) { bestDist = dist; bestMonth = m.period; }
  }
  console.log("  val=" + v.val + " pos=" + v.pos + " best=" + bestMonth + " dist=" + bestDist + (bestDist <= 10 ? " MAPPED" : " EXCLUDED"));
});

// Check socio 259
const socio259Line = lines.find(l => l.trim().startsWith("259") && l.includes("Inversiones"));
const vals259 = extractValues(socio259Line);
console.log("\nSocio 259 values:");
vals259.forEach(v => {
  let best = null, bestDist = Infinity, bestMonth = "none";
  for (const m of months) {
    const dist = Math.abs(v.pos - m.pos);
    if (dist < bestDist) { bestDist = dist; bestMonth = m.period; }
  }
  console.log("  val=" + v.val + " pos=" + v.pos + " best=" + bestMonth + " dist=" + bestDist + (bestDist <= 10 ? " MAPPED" : " EXCLUDED"));
});

// Count how many partners lose their first value
console.log("\n=== Partner loss analysis ===");
const partners = [];
for (let i = 1; i < lines.length; i++) {
  const l = lines[i];
  if (!l || !l.trim()) continue;
  if (/^  [A-Z][a-z]{2}-\d{2}/.test(l) && !l.includes("No.")) break;
  const vals = extractValues(l);
  const payments = vals.filter(v => v.val > 100000);
  if (payments.length > 0) {
    const cert = parseInt(l.trim());
    if (cert > 0 && cert < 1000) {
      partners.push({ cert, firstPaymentPos: payments[0].pos, firstPaymentVal: payments[0].val });
    }
  }
}
const lost = partners.filter(p => (p.firstPaymentPos < 71 && (71 - p.firstPaymentPos) > 10));
console.log("Partners with first payment >10 away from Nov-25 column:", lost.length);
lost.forEach(p => console.log("  cert", p.cert, "first val", p.firstPaymentVal, "at pos", p.firstPaymentPos, "dist to Nov-25:", 71 - p.firstPaymentPos));

// Check what the loss totals to
let lostTotal = 0;
for (const p of partners) {
  if (p.firstPaymentPos < 71 && (71 - p.firstPaymentPos) > 10) {
    lostTotal += p.firstPaymentVal;
  }
}
console.log("\nTotal lost amount:", lostTotal.toLocaleString());
console.log("Total lost partners:", lost.length);
