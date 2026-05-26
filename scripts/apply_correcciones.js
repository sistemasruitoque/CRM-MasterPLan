const { createClient } = require("@supabase/supabase-js");

const sql = require("fs").readFileSync(
  "C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data\\correcciones.sql",
  "utf8"
);

const supabase = createClient(
  "https://ailnztbkrgnnjccipztj.supabase.co",
  "sb_publishable_ozkbUAswbu_Dx41kOhY2Qg_fk96MEnH"
);

// Parse individual UPDATE statements
const updates = sql
  .split(";")
  .map(s => s.trim())
  .filter(s => s.startsWith("UPDATE"));

async function main() {
  let ok = 0, fail = 0;
  for (const stmt of updates) {
    // Extract certificado_no
    const match = stmt.match(/certificado_no\s*=\s*(\d+)/);
    if (!match) { fail++; continue; }
    const cert = parseInt(match[1]);

    // Build update object from SET clause
    const setsMatch = stmt.match(/SET\s+(.+?)\s+WHERE/i);
    if (!setsMatch) { fail++; continue; }
    const sets = {};
    const pairs = setsMatch[1].split(",").map(s => s.trim());
    for (const pair of pairs) {
      const [key, ...valParts] = pair.split("=").map(s => s.trim());
      const val = valParts.join("=");
      if (val === "NULL") {
        sets[key] = null;
      } else if (!isNaN(Number(val))) {
        sets[key] = Number(val);
      } else {
        sets[key] = val.replace(/^'(.*)'$/, "$1");
      }
    }

    const { error } = await supabase
      .from("socios")
      .update(sets)
      .eq("certificado_no", cert);

    if (error) {
      console.log("FAIL #" + cert + ": " + error.message);
      fail++;
    } else {
      console.log("OK   #" + cert + ": " + Object.keys(sets).join(", "));
      ok++;
    }
  }

  console.log("\n" + ok + " applied, " + fail + " failed");
}

main().catch(console.error);
