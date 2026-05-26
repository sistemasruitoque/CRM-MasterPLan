const fs = require("fs");
const { createClient } = require("@supabase/supabase-js");

const buf = fs.readFileSync("C:\\Users\\Usuario\\OneDrive - RUITOQUE GOLF COUNTRY CLUB S.A.S\\Documentos\\DATOS_INICIO_MP.prn");
const lines = buf.toString("latin1").split(/\r?\n/);

// Parse PRN line
function parsePRNLine(l) {
  // Cert: positions 0-6 (7 chars, right-aligned)
  const cert = parseInt(l.substring(0, 7).trim(), 10);
  if (!cert || cert > 10000) return null;

  // Rest of line after cert
  const rest = l.substring(7);

  // Cedula: first contiguous digits in rest (skip leading spaces)
  const cedMatch = rest.match(/^\s*(\d+)/);
  if (!cedMatch) return null;
  const cedula = cedMatch[1];
  const afterCed = rest.substring(cedMatch[0].length);

  // Category: look for "Fundado" or "Fase I" or "Fase II"
  let catStart = -1;
  let categoria = "";
  const cats = ["Fundado", "Fase I", "Fase II"];
  for (const c of cats) {
    const idx = afterCed.indexOf(c);
    if (idx >= 0 && (catStart < 0 || idx < catStart)) {
      catStart = idx;
      categoria = c === "Fundado" ? "Fundador" : c;
    }
  }
  if (catStart < 0) return null;

  // Name: between cedula end and category
  const nombre = afterCed.substring(0, catStart).trim();

  // Rest after category (use original match length, not mapped name)
  const catLen = cats.reduce((a, c) => afterCed.indexOf(c) === catStart ? c.length : a, 0);
  const afterCat = afterCed.substring(catStart + catLen);

  // Status: "Firmado" or "Por Firmar"
  const afterCatTrim = afterCat.trimStart();
  let estatus = "Pendiente";
  if (afterCatTrim.startsWith("Firmado")) estatus = "Firmado";
  else if (afterCatTrim.startsWith("Por Firmar")) estatus = "Por Firmar";

  const statusOffset = afterCat.length - afterCatTrim.length;
  const afterStatus = afterCat.substring(statusOffset + estatus.length);

  // Extract date: DD-Mon-YY or DD-Mon-YYYY pattern
  const dateMatch = afterStatus.match(/(\d{2}-[A-Za-z]{3}-\d{2,4})/);
  let fecha_contrato = null;
  let afterDate = afterStatus;
  if (dateMatch) {
    fecha_contrato = dateMatch[1];
    // Normalize to YYYY-MM-DD
    const parts = fecha_contrato.split("-");
    const months = {Jan:"01",Feb:"02",Mar:"03",Apr:"04",May:"05",Jun:"06",Jul:"07",Aug:"08",Sep:"09",Oct:"10",Nov:"11",Dec:"12"};
    const year = parseInt(parts[2]) < 50 ? "20" + parts[2] : "19" + parts[2];
    fecha_contrato = year + "-" + (months[parts[1]] || "01") + "-" + parts[0];
    afterDate = afterStatus.substring(dateMatch.index + dateMatch[0].length);
  }

  // Extract numbers at the end: 10-char fields with truncated last digit
  // Format: "NNN,NNN,NN" or " NNN,NNN,N" etc. (trailing digit truncated)
  function parsePRNAmount(s) {
    let cleaned = s.replace(/[^0-9,]/g, "");
    if (!cleaned) return 0;
    // If last group has only 1-2 digits, the last digit is truncated
    const groups = cleaned.split(",");
    if (groups.length > 1 && groups[groups.length-1].length < 3) {
      // Pad with zeros to make 3 digits
      groups[groups.length-1] = groups[groups.length-1].padEnd(3, "0");
    }
    cleaned = groups.join("");
    return parseInt(cleaned, 10) || 0;
  }

  // Find all comma-formatted numbers in the line
  const allNums = [];
  for (let i = 0; i < l.length; i++) {
    if (l[i] === " " || l[i] === "," || /\d/.test(l[i])) {
      // Try to extract from this position
      const chunk = l.substring(i, i + 11).trim();
      if (/^\d{1,3}(?:,\d{1,3}){1,3}$/.test(chunk.replace(/\s/g, ""))) {
        allNums.push({ val: parsePRNAmount(chunk), pos: i });
        i += 10;
      }
    }
  }

  // Also extract using regex for comma-formatted numbers
  const numRegex = /\d{1,3}(?:,\d{1,3})+/g;
  let m;
  const nums = [];
  while ((m = numRegex.exec(l)) !== null) {
    nums.push({ val: parsePRNAmount(m[0]), pos: m.index });
  }

  // The last 3 numbers are: aporte, referido, valor_final
  // But sometimes referido=0 and doesn't match the regex
  // Try from end of string backward: 10-char fixed fields
  const lineEnd = l.length;
  const endFields = [];
  for (let pos = lineEnd - 10; pos >= 70; pos -= 10) {
    const chunk = l.substring(pos, pos + 10).trim();
    if (chunk) {
      endFields.unshift({ val: parsePRNAmount(chunk), pos });
    }
  }

  // The last 3 fields from position ~79 onward should be aporte, referido, valor_final
  // But sometimes referido is empty (zeros)
  let valor_final = 0, referido = 0, aporte = 0;
  if (nums.length >= 3) {
    aporte = nums[nums.length - 3].val;
    referido = nums[nums.length - 2].val;
    valor_final = nums[nums.length - 1].val;
  } else if (nums.length === 2) {
    // If referido is 0, it won't match the regex
    aporte = nums[0].val;
    valor_final = nums[1].val;
  } else if (nums.length === 1) {
    valor_final = nums[0].val;
    aporte = valor_final;
  }

  return {
    certificado_no: cert,
    cedula,
    nombre,
    categoria,
    estatus,
    fecha_contrato,
    aporte,
    referido,
    valor_final,
  };
}

// Parse all lines
const prnSocios = [];
for (let i = 1; i < lines.length; i++) {
  const s = parsePRNLine(lines[i]);
  if (s) prnSocios.push(s);
}

console.log("Parsed " + prnSocios.length + " socios from PRN");

// Print sample
console.log("\nSample:");
for (let i = 0; i < 3; i++) {
  const s = prnSocios[i];
  console.log("  #" + s.certificado_no + " " + s.nombre + " | Cat:" + s.categoria + " Est:" + s.estatus + " Fecha:" + s.fecha_contrato + " A:" + s.aporte.toLocaleString() + " R:" + s.referido.toLocaleString() + " VF:" + s.valor_final.toLocaleString());
}
console.log("  ...");
for (let i = prnSocios.length - 3; i < prnSocios.length; i++) {
  const s = prnSocios[i];
  console.log("  #" + s.certificado_no + " " + s.nombre + " | Cat:" + s.categoria + " Est:" + s.estatus + " Fecha:" + s.fecha_contrato + " A:" + s.aporte.toLocaleString() + " R:" + s.referido.toLocaleString() + " VF:" + s.valor_final.toLocaleString());
}

// Verify totals
const totalAportes = prnSocios.reduce((s, p) => s + p.aporte, 0);
const totalReferidos = prnSocios.reduce((s, p) => s + p.referido, 0);
const totalValor = prnSocios.reduce((s, p) => s + p.valor_final, 0);
console.log("\nTotals: Aportes=" + totalAportes.toLocaleString() + " Referidos=" + totalReferidos.toLocaleString() + " Valor Final=" + totalValor.toLocaleString());

// Compare with DB
const supabase = createClient(
  "https://ailnztbkrgnnjccipztj.supabase.co",
  "sb_publishable_ozkbUAswbu_Dx41kOhY2Qg_fk96MEnH"
);

async function main() {
  const { data: dbSocios } = await supabase.from("socios").select("*");
  if (!dbSocios) { console.log("No DB socios"); return; }
  
  const dbMap = {};
  for (const s of dbSocios) dbMap[s.certificado_no] = s;
  
  let realDiffs = 0;
  let diffDetails = [];
  
  for (const p of prnSocios) {
    const d = dbMap[p.certificado_no];
    if (!d) {
      diffDetails.push("MISSING #" + p.certificado_no + ": " + p.nombre);
      realDiffs++;
      continue;
    }
    
    const updates = [];
    const dn = d.nombre.trim();
    const pn = p.nombre.trim();
    // Compare names: the PRN might have fuller names
    if (dn !== pn && !pn.startsWith(dn)) {
      // Only flag if PRN name is significantly different
      const shorter = dn.length < pn.length ? dn : pn;
      const longer = dn.length < pn.length ? pn : dn;
      if (!longer.startsWith(shorter)) {
        updates.push("nombre: '" + dn + "' vs '" + pn + "'");
      }
    }
    if (d.cedula !== p.cedula) updates.push("cedula: " + d.cedula + " -> " + p.cedula);
    if (d.categoria !== p.categoria) updates.push("categoria: " + d.categoria + " -> " + p.categoria);
    if (d.estatus !== p.estatus) updates.push("estatus: " + d.estatus + " -> " + p.estatus);
    if ((d.fecha_contrato || "") !== (p.fecha_contrato || "")) {
      updates.push("fecha: " + d.fecha_contrato + " -> " + p.fecha_contrato);
    }
    if (d.aporte !== p.aporte) updates.push("aporte: " + d.aporte.toLocaleString() + " -> " + p.aporte.toLocaleString());
    if (d.referido !== p.referido) updates.push("referido: " + d.referido.toLocaleString() + " -> " + p.referido.toLocaleString());
    if (d.valor_final !== p.valor_final) updates.push("valor_final: " + d.valor_final.toLocaleString() + " -> " + p.valor_final.toLocaleString());
    
    if (updates.length > 0) {
      diffDetails.push("#" + p.certificado_no + ": " + updates.join("; "));
      realDiffs++;
    }
  }
  
  console.log("\nReal differences: " + realDiffs);
  diffDetails.forEach(d => console.log("  " + d));
}

main().catch(console.error);
