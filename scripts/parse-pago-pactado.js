const fs = require("fs");
const buf = fs.readFileSync(
  "C:\\Users\\Usuario\\OneDrive - RUITOQUE GOLF COUNTRY CLUB S.A.S\\Documentos\\pago_pactado.prn"
);
const lines = buf.toString("latin1").split(/\r?\n/);

// --- STEP 1: Find section headers ---
function findHeader(startFrom, monthExample) {
  for (let i = startFrom; i < lines.length; i++) {
    const l = lines[i];
    if (l && l.includes(monthExample) && /^  [A-Z][a-z]{2}-\d{2}/.test(l)) return i;
  }
  return -1;
}

const h1 = findHeader(0, "Dec-25");
const h2 = findHeader(h1 + 1, "Dec-27");
const h3 = findHeader(h2 + 1, "Dec-29");

console.log(`Headers at: h1=${h1}, h2=${h2}, h3=${h3}`);

// --- STEP 2: Extract month names with their byte positions ---
function extractMonths(headerLine) {
  const map = { Jan:"01",Feb:"02",Mar:"03",Apr:"04",May:"05",Jun:"06",
    Jul:"07",Aug:"08",Sep:"09",Oct:"10",Nov:"11",Dec:"12" };
  const months = [];
  for (let i = 0; i < headerLine.length - 5; i++) {
    const chunk = headerLine.substring(i, i + 6);
    if (/^[A-Z][a-z]{2}-\d{2}$/.test(chunk)) {
      const m = map[chunk.substring(0, 3)];
      const y = 2000 + parseInt(chunk.substring(4));
      months.push({ period: `${y}-${m}`, pos: i });
    }
  }
  return months;
}

const m1 = extractMonths(lines[h1]);
const m2 = h2 ? extractMonths(lines[h2]) : [];
const m3 = h3 ? extractMonths(lines[h3]) : [];

console.log(`Months h1: ${m1.length} (${m1[0].period} to ${m1[m1.length-1].period})`);
console.log(`Months h2: ${m2.length} (${m2[0]?.period} to ${m2[m2.length-1]?.period})`);
console.log(`Months h3: ${m3.length} (${m3[0]?.period} to ${m3[m3.length-1]?.period})`);

// --- STEP 3: Parse partners from cert data ---
function parseCertNo(line) {
  const m = line.match(/^\s*(\d+)/);
  return m ? parseInt(m[1]) : null;
}

const partners = [];
for (let i = 3; i < h1; i++) {
  const l = lines[i];
  if (!l || !l.trim()) continue;
  const cert = parseCertNo(l);
  if (cert && cert > 0) partners.push(cert);
}

console.log(`\nPartners found: ${partners.length}`);
console.log("First 5:", partners.slice(0, 5));
console.log("Last 5:", partners.slice(-5));

// --- STEP 4: Parse data rows ---
function readSectionData(headerIdx, months, expectedRows) {
  if (!headerIdx) return Array(expectedRows).fill(null);
  const rows = Array(expectedRows).fill(null);
  let rowIdx = 0;
  for (let i = headerIdx + 1; i < lines.length; i++) {
    const line = lines[i];
    if (!line || !line.trim()) { rowIdx++; continue; }
    // Stop at next section header
    if (/^  [A-Z][a-z]{2}-\d{2}/.test(line) && !line.includes("No.")) break;
    
    // Extract ALL comma-formatted numbers with strict format
    const regex = /\d{1,3}(?:,\d{3})*/g;
    const values = [];
    let match;
    while ((match = regex.exec(line)) !== null) {
      const val = parseInt(match[0].replace(/,/g, ""));
      if (val > 0) {
        values.push({ val, pos: match.index });
      }
    }
    if (values.length > 0) {
      rows[rowIdx] = { lineIdx: i, values };
    }
    rowIdx++;
    if (rowIdx >= expectedRows) break;
  }
  return rows;
}

const d1 = readSectionData(h1, m1, partners.length);
const d2 = readSectionData(h2, m2, partners.length);
const d3 = readSectionData(h3, m3, partners.length);

console.log(`\nData rows: d1=${d1.length}, d2=${d2.length}, d3=${d3.length}`);

// --- STEP 4: Map values to months by position ---
function mapValuesToMonths(values, months) {
  const schedule = {};
  if (!months.length) return schedule;
  
  for (const v of values) {
    // Find closest month by byte position
    let bestDist = Infinity;
    let bestMonth = months[0].period;
    for (const m of months) {
      const dist = Math.abs(v.pos - m.pos);
      if (dist < bestDist) {
        bestDist = dist;
        bestMonth = m.period;
      }
    }
    // Only assign if within reasonable distance (10 chars)
    if (bestDist <= 10) {
      schedule[bestMonth] = (schedule[bestMonth] || 0) + v.val;
    }
  }
  return schedule;
}

// --- STEP 5: Build per-partner schedules ---
const allPlans = [];
let totalPartnerPlans = 0;
let totalRows = 0;

for (let pi = 0; pi < partners.length; pi++) {
  const cert = partners[pi];
  
  let s1 = {}, s2 = {}, s3 = {};
  
  if (d1[pi]) s1 = mapValuesToMonths(d1[pi].values, m1);
  if (d2[pi]) s2 = mapValuesToMonths(d2[pi].values, m2);
  if (d3[pi]) s3 = mapValuesToMonths(d3[pi].values, m3);
  
  const merged = { ...s1, ...s2, ...s3 };
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

// Sample first 3
console.log("\n--- Sample ---");
allPlans.slice(0, 5).forEach(p => {
  const periods = Object.keys(p.schedules).sort();
  console.log(`${p.certificado_no}: ${periods.length} periods, total=${p.total.toLocaleString()}`);
  console.log(`  ${periods.slice(0, 8).map(k => `${k}=${p.schedules[k].toLocaleString()}`).join(", ")}`);
});

// --- STEP 7: Generate SQL ---
const outPath = "C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data\\pago_pactado_planes.sql";
let sql = `-- Planes de pago pactados desde pago_pactado.prn
-- ${new Date().toISOString()}
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

// Update saldos
sql += `-- Update saldos
UPDATE planes_pago pp SET saldo = sub.remaining
FROM (
  SELECT id, SUM(monto_proyectado) OVER (PARTITION BY socio_id ORDER BY periodo DESC) AS remaining
  FROM planes_pago
) sub WHERE pp.id = sub.id;

COMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS planes, SUM(monto_proyectado) AS total FROM planes_pago;
`;

fs.writeFileSync(outPath, sql, "utf8");
console.log(`\nSQL written: ${outPath}`);
console.log(`Partners inserted: ${inserted}`);

// JSON for verification
fs.writeFileSync(
  "C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data\\pago_pactado_planes.json",
  JSON.stringify(allPlans, null, 2), "utf8"
);
