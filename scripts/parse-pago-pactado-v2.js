const fs = require("fs");
const path = require("path");

const PRN_PATH = path.join(__dirname, "..", "data", "pago_pactado.prn");
const DATA_DIR = path.join(__dirname, "..", "data");

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

function mapValuesToMonths(values, months) {
  const schedule = {};
  if (!months.length) return schedule;
  for (const v of values) {
    let bestDist = Infinity;
    let bestMonth = months[0].period;
    for (const m of months) {
      const dist = Math.abs(v.pos - m.pos);
      if (dist < bestDist) {
        bestDist = dist;
        bestMonth = m.period;
      }
    }
    if (bestDist <= 10) {
      schedule[bestMonth] = (schedule[bestMonth] || 0) + v.val;
    }
  }
  return schedule;
}

function extractNameAndCedula(line) {
  const certMatch = line.match(/^\s*(\d+)/);
  const certNo = certMatch ? parseInt(certMatch[1]) : null;
  if (!certNo) return null;

  let s = "";
  for (let i = 13; i < Math.min(35, line.length); i++) {
    if (/\d/.test(line[i])) s += line[i];
    else if (s.length > 0) break;
  }
  const cedula = s;

  let cedEnd = 13;
  for (let i = 13; i < Math.min(35, line.length); i++) {
    if (!/\d/.test(line[i])) {
      if (i > 13) { cedEnd = i; break; }
      cedEnd = i + 1;
    } else {
      cedEnd = i + 1;
    }
  }
  const nombre = line.substring(cedEnd, 48).trim();

  return { certificado_no: certNo, cedula, nombre };
}

// Read file
const buf = fs.readFileSync(PRN_PATH);
const prnLines = buf.toString("latin1").split(/\r?\n/);

// Section headers: line 0 is the first combined header
const H1 = 0;
const m1 = extractMonths(prnLines[H1]);

function findHeaderIdx(startFrom, monthExample) {
  for (let i = startFrom; i < prnLines.length; i++) {
    const l = prnLines[i];
    if (l && l.includes(monthExample) && /^  [A-Z][a-z]{2}-\d{2}/.test(l)) return i;
  }
  return -1;
}

const H2 = findHeaderIdx(H1 + 1, "Mar-27");
const H3 = findHeaderIdx(H2 + 1, "Mar-29");

console.log(`Headers at: H1=${H1}, H2=${H2}, H3=${H3}`);

const m2 = H2 > 0 ? extractMonths(prnLines[H2]) : [];
const m3 = H3 > 0 ? extractMonths(prnLines[H3]) : [];

console.log(`Months s1: ${m1.length} (${m1[0]?.period} to ${m1[m1.length-1]?.period})`);
console.log(`Months s2: ${m2.length} (${m2[0]?.period} to ${m2[m2.length-1]?.period})`);
console.log(`Months s3: ${m3.length} (${m3[0]?.period} to ${m3[m3.length-1]?.period})`);

// Extract partners from section 1 data rows
const partnerInfo = [];
for (let i = 1; i < H2; i++) {
  const l = prnLines[i];
  if (!l || !l.trim()) continue;
  const info = extractNameAndCedula(l);
  if (info && info.certificado_no > 0) {
    partnerInfo.push(info);
  }
}

const partners = partnerInfo.map(p => p.certificado_no);
console.log(`\nPartners found: ${partners.length}`);

// Read data from each section
function readSectionData(headerIdx, months, expectedRows, startOffset) {
  if (headerIdx === undefined || headerIdx === null || headerIdx < 0) return Array(expectedRows).fill(null);
  const rows = Array(expectedRows).fill(null);
  let rowIdx = 0;
  const start = startOffset !== undefined ? startOffset : headerIdx + 1;
  for (let i = start; i < prnLines.length; i++) {
    const line = prnLines[i];
    if (!line || !line.trim()) { rowIdx++; continue; }
    if (/^  [A-Z][a-z]{2}-\d{2}/.test(line) && !line.includes("No.")) break;
    const values = extractValues(line);
    if (values.length > 0) {
      rows[rowIdx] = { lineIdx: i, values };
    }
    rowIdx++;
    if (rowIdx >= expectedRows) break;
  }
  return rows;
}

const d1 = readSectionData(H1, m1, partners.length, 1);
const d2 = readSectionData(H2, m2, partners.length);
const d3 = readSectionData(H3, m3, partners.length);

console.log(`Data rows: s1=${d1.filter(Boolean).length}, s2=${d2.filter(Boolean).length}, s3=${d3.filter(Boolean).length}`);

// Build per-partner plans
// Section 1: first month (2025-11) is the FLAG value, exclude from schedule
const FLAG_MONTH = "2025-11";

const allPlans = [];
let totalPartnerPlans = 0;
let totalRows = 0;

for (let pi = 0; pi < partners.length; pi++) {
  const cert = partners[pi];
  const s1 = d1[pi] ? mapValuesToMonths(d1[pi].values, m1) : {};
  const s2 = d2[pi] ? mapValuesToMonths(d2[pi].values, m2) : {};
  const s3 = d3[pi] ? mapValuesToMonths(d3[pi].values, m3) : {};

  // Merge all, but exclude the flag month from the schedule
  const merged = { ...s1, ...s2, ...s3 };
  delete merged[FLAG_MONTH];

  const total = Object.values(merged).reduce((s, v) => s + v, 0);
  const count = Object.keys(merged).length;

  if (count > 0) totalPartnerPlans++;
  totalRows += count;

  allPlans.push({ certificado_no: cert, schedules: merged, total, count });
}

console.log(`\nPartners with plans: ${totalPartnerPlans}/${partners.length}`);
console.log(`Total plan rows: ${totalRows}`);

const grandTotal = allPlans.reduce((s, p) => s + p.total, 0);
console.log(`Grand total payments: ${grandTotal.toLocaleString()}`);

// Sample first 5
console.log("\n--- Sample ---");
allPlans.slice(0, 5).forEach(p => {
  const periods = Object.keys(p.schedules).sort();
  console.log(`${p.certificado_no}: ${periods.length} periods, total=${p.total.toLocaleString()}`);
  console.log(`  ${periods.slice(0, 6).map(k => `${k}=${p.schedules[k].toLocaleString()}`).join(", ")}`);
});

// --- Generate plan_schedules.json ---
const planSchedules = [];
for (let pi = 0; pi < partners.length; pi++) {
  const info = partnerInfo[pi];
  if (!info) continue;

  // Extract flag from section 1 data: the value that maps to 2025-11
  const s1 = d1[pi] ? mapValuesToMonths(d1[pi].values, m1) : {};
  const flag = s1[FLAG_MONTH] || 0;

  // For separation, use the first value that maps to 2025-12 (Dec-25 column)
  const separacion = s1["2025-12"] || 0;

  // Monthly amounts = sorted schedule values (excluding flag month)
  const s2v = d2[pi] ? mapValuesToMonths(d2[pi].values, m2) : {};
  const s3v = d3[pi] ? mapValuesToMonths(d3[pi].values, m3) : {};
  const merged = { ...s1, ...s2v, ...s3v };
  delete merged[FLAG_MONTH];

  const monthlyAmounts = Object.keys(merged).sort().map(k => merged[k]);

  planSchedules.push({
    index: pi,
    certificado_no: info.certificado_no,
    nombre: info.nombre,
    flag,
    separacion,
    monthlyAmounts,
  });
}

// --- Write JSON files ---
fs.writeFileSync(
  path.join(DATA_DIR, "pago_pactado_planes.json"),
  JSON.stringify(allPlans, null, 2),
  "utf8"
);
console.log(`\nWritten: pago_pactado_planes.json (${allPlans.length} plans)`);

fs.writeFileSync(
  path.join(DATA_DIR, "plan_schedules.json"),
  JSON.stringify(planSchedules, null, 2),
  "utf8"
);
console.log(`Written: plan_schedules.json (${planSchedules.length} entries)`);

// --- Generate SQL ---
const sqlPath = path.join(DATA_DIR, "pago_pactado_planes.sql");
let sql = `-- Planes de pago pactados (actualizado ${new Date().toISOString().split("T")[0]})
-- ${totalPartnerPlans} partners, ${totalRows} rows, total: ${grandTotal.toLocaleString()}

BEGIN;

DELETE FROM planes_pago;

`;

let inserted = 0;
for (const p of allPlans) {
  const periods = Object.keys(p.schedules).sort();
  if (periods.length === 0) continue;
  inserted++;

  const valueRows = periods.map(k => {
    return `  ('${k}', ${p.schedules[k]}, (SELECT id FROM socios WHERE certificado_no = ${p.certificado_no}))`;
  });

  sql += `-- ${p.certificado_no}: ${periods.length} cuotas, total ${p.total.toLocaleString()}
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
${valueRows.join(",\n")};

`;
}

sql += `-- Update saldos
UPDATE planes_pago pp SET saldo = sub.remaining
FROM (
  SELECT id, SUM(monto_proyectado) OVER (PARTITION BY socio_id ORDER BY periodo DESC) AS remaining
  FROM planes_pago
) sub WHERE pp.id = sub.id;

COMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS planes, SUM(monto_proyectado) AS total FROM planes_pago;
`;

fs.writeFileSync(sqlPath, sql, "utf8");
console.log(`SQL written: ${sqlPath}`);
console.log(`Partners inserted: ${inserted}`);

// Summary
console.log("\n=== SUMMARY ===");
console.log(`Total partners with plans: ${totalPartnerPlans}`);
console.log(`Total payment rows: ${totalRows}`);
console.log(`Grand total: ${grandTotal.toLocaleString()}`);
