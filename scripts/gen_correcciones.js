const fs = require("fs");
const { createClient } = require("@supabase/supabase-js");

const buf = fs.readFileSync("C:\\Users\\Usuario\\OneDrive - RUITOQUE GOLF COUNTRY CLUB S.A.S\\Documentos\\DATOS_INICIO_MP.prn");
const lines = buf.toString("latin1").split(/\r?\n/);

function parsePRNAmount(s) {
  let cleaned = s.replace(/[^0-9,]/g, "");
  if (!cleaned) return 0;
  const groups = cleaned.split(",");
  if (groups.length > 1 && groups[groups.length-1].length < 3) {
    groups[groups.length-1] = groups[groups.length-1].padEnd(3, "0");
  }
  cleaned = groups.join("");
  return parseInt(cleaned, 10) || 0;
}

// Manual overrides for lines where regex fails (adjacent number fields)
const OVERRIDES = {
  //  59: All   59      13540944Allen Yamith ... 21-Nov-25 187,500,0022,500,000165,000,00
  // Values: aporte=187,500,000 referido=22,500,000 valor_final=165,000,000
  59: { aporte: 187500000, referido: 22500000, valor_final: 165000000 },
  // 161: Nelson ... 20-Feb-26 187,500,0067,500,000120,000,00
  // Values: aporte=187,500,000 referido=67,500,000 valor_final=120,000,000
  161: { aporte: 187500000, referido: 67500000, valor_final: 120000000 },
};

function parsePRNLine(l) {
  const cert = parseInt(l.substring(0, 7).trim(), 10);
  if (!cert || cert > 10000) return null;
  const rest = l.substring(7);
  const cedMatch = rest.match(/^\s*(\d+)/);
  if (!cedMatch) return null;
  const cedula = cedMatch[1];
  const afterCed = rest.substring(cedMatch[0].length);
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
  const nombre = afterCed.substring(0, catStart).trim();
  const catLen = cats.reduce((a, c) => afterCed.indexOf(c) === catStart ? c.length : a, 0);
  const afterCat = afterCed.substring(catStart + catLen);
  const afterCatTrim = afterCat.trimStart();
  let estatus = "Pendiente";
  if (afterCatTrim.startsWith("Firmado")) estatus = "Firmado";
  else if (afterCatTrim.startsWith("Por Firmar")) estatus = "Por Firmar";
  const statusOffset = afterCat.length - afterCatTrim.length;
  const afterStatus = afterCat.substring(statusOffset + estatus.length);
  const dateMatch = afterStatus.match(/(\d{2}-[A-Za-z]{3}-\d{2,4})/);
  let fecha_contrato = null;
  let afterDate = afterStatus;
  if (dateMatch) {
    fecha_contrato = dateMatch[1];
    const parts = fecha_contrato.split("-");
    const months = {Jan:"01",Feb:"02",Mar:"03",Apr:"04",May:"05",Jun:"06",Jul:"07",Aug:"08",Sep:"09",Oct:"10",Nov:"11",Dec:"12"};
    const year = parseInt(parts[2]) < 50 ? "20" + parts[2] : "19" + parts[2];
    fecha_contrato = year + "-" + (months[parts[1]] || "01") + "-" + parts[0];
    afterDate = afterStatus.substring(dateMatch.index + dateMatch[0].length);
  }

  // Use regex for number extraction
  const numRegex = /\d{1,3}(?:,\d{1,3})+/g;
  let m;
  const nums = [];
  while ((m = numRegex.exec(afterDate)) !== null) {
    nums.push({ val: parsePRNAmount(m[0]), pos: m.index });
  }

  let aporte = 0, referido = 0, valor_final = 0;
  if (cert in OVERRIDES) {
    aporte = OVERRIDES[cert].aporte;
    referido = OVERRIDES[cert].referido;
    valor_final = OVERRIDES[cert].valor_final;
  } else if (nums.length >= 3) {
    aporte = nums[nums.length - 3].val;
    referido = nums[nums.length - 2].val;
    valor_final = nums[nums.length - 1].val;
  } else if (nums.length === 2) {
    aporte = nums[0].val;
    valor_final = nums[1].val;
  } else if (nums.length === 1) {
    valor_final = nums[0].val;
    aporte = valor_final;
  }

  return {
    certificado_no: cert,
    cedula, nombre, categoria, estatus, fecha_contrato,
    aporte, referido, valor_final,
  };
}

const prnSocios = [];
for (let i = 1; i < lines.length; i++) {
  const s = parsePRNLine(lines[i]);
  if (s) prnSocios.push(s);
}

const totalAportes = prnSocios.reduce((s, p) => s + p.aporte, 0);
const totalReferidos = prnSocios.reduce((s, p) => s + p.referido, 0);
const totalValor = prnSocios.reduce((s, p) => s + p.valor_final, 0);
console.log("Parsed " + prnSocios.length + " socios from PRN");
console.log("Totals: Aportes=" + totalAportes.toLocaleString() + " Referidos=" + totalReferidos.toLocaleString() + " Valor Final=" + totalValor.toLocaleString() + "\n");

const supabase = createClient(
  "https://ailnztbkrgnnjccipztj.supabase.co",
  "sb_publishable_ozkbUAswbu_Dx41kOhY2Qg_fk96MEnH"
);

async function main() {
  const { data: dbSocios } = await supabase.from("socios").select("*");
  if (!dbSocios) { console.log("No DB socios"); return; }
  const dbMap = {};
  for (const s of dbSocios) dbMap[s.certificado_no] = s;

  const corrections = [];

  for (const p of prnSocios) {
    const d = dbMap[p.certificado_no];
    if (!d) continue;

    const sets = [];
    if (d.cedula !== p.cedula) sets.push("cedula = '" + p.cedula + "'");
    const dn = d.nombre.trim();
    const pn = p.nombre.trim();
    if (dn !== pn) {
      const shorter = dn.length < pn.length ? dn : pn;
      const longer = dn.length < pn.length ? pn : dn;
      if (!longer.startsWith(shorter)) {
        sets.push("nombre = '" + pn.replace(/'/g, "''") + "'");
      }
    }
    if (d.categoria !== p.categoria) sets.push("categoria = '" + p.categoria + "'");
    const df = d.fecha_contrato || "";
    const pf = p.fecha_contrato || "";
    if (df !== pf) {
      if (p.fecha_contrato) sets.push("fecha_contrato = '" + p.fecha_contrato + "'");
      else sets.push("fecha_contrato = NULL");
    }
    // Skip numeric changes where PRN truncated last digit (pad creates false diff)
    const skipNumeric = [311, 562].includes(p.certificado_no);
    if (!skipNumeric) {
      if (d.aporte !== p.aporte) sets.push("aporte = " + p.aporte);
      if (d.referido !== p.referido) sets.push("referido = " + p.referido);
      if (d.valor_final !== p.valor_final) sets.push("valor_final = " + p.valor_final);
    }

    if (sets.length > 0) {
      corrections.push("UPDATE socios SET " + sets.join(", ") + " WHERE certificado_no = " + p.certificado_no + ";");
    }
  }

  console.log("SQL corrections: " + corrections.length + "\n");
  console.log("BEGIN;\n");
  corrections.forEach(c => console.log(c));
  console.log("\nCOMMIT;");
}

main().catch(console.error);
