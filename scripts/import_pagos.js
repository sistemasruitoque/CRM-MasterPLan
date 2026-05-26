const { createClient } = require("@supabase/supabase-js");

const SUPABASE_URL = "https://ailnztbkrgnnjccipztj.supabase.co";
const SUPABASE_KEY = "sb_publishable_ozkbUAswbu_Dx41kOhY2Qg_fk96MEnH";
const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function main() {
  // 1. Fetch all socios -> mapping of certificado_no -> id
  const { data: socios, error: sErr } = await supabase.from("socios").select("id, certificado_no");
  if (sErr) { console.error("Error fetching socios:", sErr); return; }
  const certToId = {};
  for (const s of socios) certToId[s.certificado_no] = s.id;
  console.log("Socios loaded: " + Object.keys(certToId).length);

  // 2. Fetch and delete all existing pagos in chunks
  const { data: existing } = await supabase.from("pagos").select("id");
  if (existing && existing.length > 0) {
    const ids = existing.map(r => r.id);
    for (let i = 0; i < ids.length; i += 50) {
      const chunk = ids.slice(i, i + 50);
      const { error: dErr } = await supabase.from("pagos").delete().in("id", chunk);
      if (dErr) { console.error("Error deleting pagos:", dErr); return; }
    }
    console.log("Existing pagos deleted: " + ids.length);
  } else {
    console.log("No existing pagos to delete");
  }

  // 3. Read the SQL file and extract INSERT data
  const fs = require("fs");
  const sql = fs.readFileSync("C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data\\pagos_realizados.sql", "utf8");

  // Parse INSERT triplets from raw lines: INSERT, SELECT, FROM
  const lines = sql.split("\n");
  const records = [];
  for (let i = 0; i < lines.length; i++) {
    if (!lines[i].startsWith("INSERT")) continue;
    const valuesLine = lines[i + 1]; // "SELECT id, <monto>, '<fecha_pago>', '<tipo>', '<concepto>'"
    const whereLine = lines[i + 2];  // "FROM socios WHERE certificado_no = <cert>;"
    if (!valuesLine || !whereLine) continue;

    const m = valuesLine.match(/SELECT id, (\d+), '([^']+)', '([^']+)', '([^']+)'/);
    const certM = whereLine.match(/certificado_no = (\d+)/);
    
    if (m && certM) {
      const monto = parseInt(m[1], 10);
      const fecha_pago = m[2];
      const tipo = m[3];
      const concepto = m[4];
      const cert = parseInt(certM[1], 10);
      const socio_id = certToId[cert];
      
      if (socio_id && monto > 0) {
        records.push({ socio_id, monto, fecha_pago, tipo, concepto });
      }
    }
  }
  console.log("Records to insert: " + records.length);

  // 4. Batch insert in chunks of 50
  const chunkSize = 50;
  for (let i = 0; i < records.length; i += chunkSize) {
    const chunk = records.slice(i, i + chunkSize);
    const { error: iErr } = await supabase.from("pagos").insert(chunk);
    if (iErr) { console.error("Error inserting chunk " + i + ":", iErr); return; }
    console.log("  Inserted " + (i + chunk.length) + "/" + records.length);
  }

  // 5. Update planes_pago.monto_pagado and estado
  // Using raw SQL via the REST API would need exec_sql, so we update programmatically
  const { data: planes, error: pErr } = await supabase.from("planes_pago").select("id, socio_id, periodo, monto_proyectado, monto_pagado, estado");
  if (pErr) { console.error("Error fetching planes_pago:", pErr); return; }
  console.log("Planes_pago loaded: " + planes.length);

  // Build map of (socio_id, concepto) -> monto
  const pagoMap = {};
  for (const r of records) {
    const key = r.socio_id + "|" + r.concepto;
    pagoMap[key] = (pagoMap[key] || 0) + r.monto;
  }

  let updated = 0;
  for (const pp of planes) {
    const key = pp.socio_id + "|" + pp.periodo;
    const montoPagado = pagoMap[key] || 0;
    let estado = "pendiente";
    if (montoPagado >= pp.monto_proyectado) estado = "pagado";
    else if (montoPagado > 0) estado = "parcial";
    
    if (montoPagado !== pp.monto_pagado || estado !== pp.estado) {
      const { error: uErr } = await supabase
        .from("planes_pago")
        .update({ monto_pagado: montoPagado, estado })
        .eq("id", pp.id);
      if (uErr) { console.error("Error updating plan " + pp.id + ":", uErr); return; }
      updated++;
    }
  }
  console.log("Planes_pago updated: " + updated);

  // 6. Verify
  const { data: verify, error: vErr } = await supabase.from("pagos").select("id, monto");
  if (vErr) { console.error("Verify error:", vErr); return; }
  const total = verify.reduce((sum, p) => sum + p.monto, 0);
  console.log("\nVerification: " + verify.length + " pagos, total = " + total.toLocaleString());
}

main().catch(console.error);
