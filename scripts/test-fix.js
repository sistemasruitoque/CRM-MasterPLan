const fs = require("fs");
const path = require("path");

const PRN_PATH = path.join(__dirname, "..", "data", "pago_pactado.prn");
const buf = fs.readFileSync(PRN_PATH);
const lines = buf.toString("latin1").split(/\r?\n/);

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

function mapValuesToMonths(values, months, threshold) {
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
    if (bestDist <= threshold) {
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

const H1 = 0;
const m1 = extractMonths(lines[H1]);

function findHeaderIdx(startFrom, monthExample) {
  for (let i = startFrom; i < lines.length; i++) {
    const l = lines[i];
    if (l && l.includes(monthExample) && /^  [A-Z][a-z]{2}-\d{2}/.test(l)) return i;
  }
  return -1;
}

const H2 = findHeaderIdx(H1 + 1, "Mar-27");
const H3 = findHeaderIdx(H2 + 1, "Mar-29");

const m2 = H2 > 0 ? extractMonths(lines[H2]) : [];
const m3 = H3 > 0 ? extractMonths(lines[H3]) : [];

// Partners
const partnerInfo = [];
for (let i = 1; i < H2; i++) {
  const l = lines[i];
  if (!l || !l.trim()) continue;
  const info = extractNameAndCedula(l);
  if (info && info.certificado_no > 0) {
    partnerInfo.push(info);
  }
}
const partners = partnerInfo.map(p => p.certificado_no);

console.log("=== Testing different thresholds ===");
for (const threshold of [10, 15, 18, 20, 22, 25]) {
  let totalRows = 0;
  let firstValCount = 0;
  let firstValTotal = 0;

  // Simplified: only section 1, all partners
  function readSectionData(headerIdx, months, expectedRows, startOffset) {
    if (headerIdx === undefined || headerIdx === null || headerIdx < 0) return Array(expectedRows).fill(null);
    const rows = Array(expectedRows).fill(null);
    let rowIdx = 0;
    const start = startOffset !== undefined ? startOffset : headerIdx + 1;
    for (let i = start; i < lines.length; i++) {
      const line = lines[i];
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

  let grandTotal = 0;
  let partnerCount = 0;
  let nov25Total = 0;
  let nov25Count = 0;

  for (let pi = 0; pi < partners.length; pi++) {
    const s1 = d1[pi] ? mapValuesToMonths(d1[pi].values, m1, threshold) : {};
    const s2 = d2[pi] ? mapValuesToMonths(d2[pi].values, m2, threshold) : {};
    const s3 = d3[pi] ? mapValuesToMonths(d3[pi].values, m3, threshold) : {};
    const merged = { ...s1, ...s2, ...s3 };
    const total = Object.values(merged).reduce((s, v) => s + v, 0);
    const count = Object.keys(merged).length;
    if (count > 0) partnerCount++;
    totalRows += count;
    grandTotal += total;
    if (s1["2025-11"]) {
      nov25Total += s1["2025-11"];
      nov25Count++;
    }
  }

  console.log(`\nThreshold = ${threshold}:`);
  console.log(`  Partners with plans: ${partnerCount}/${partners.length}`);
  console.log(`  Total rows: ${totalRows}`);
  console.log(`  Grand total: ${grandTotal.toLocaleString()}`);
  console.log(`  Partners with Nov-25: ${nov25Count}, total Nov-25: ${nov25Total.toLocaleString()}`);
}
