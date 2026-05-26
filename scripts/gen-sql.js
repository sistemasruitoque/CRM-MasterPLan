const fs = require("fs")
const socios = JSON.parse(fs.readFileSync("C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data\\socios.json"))
const lines = []
for (const s of socios) {
  let fc = s.fecha_contrato ? s.fecha_contrato : null
  if (fc) {
    const parts = fc.split("/")
    fc = `'${parts[2]}-${parts[1]}-${parts[0]}'`
  } else {
    fc = "NULL"
  }
  const obs = s.observaciones ? `'${s.observaciones.replace(/'/g, "''")}'` : "''"
  const ced = s.cedula.replace(/'/g, "''")
  const nom = s.nombre.replace(/'/g, "''")
  const mod = s.modalidad.replace(/'/g, "''")
  lines.push(
    `INSERT INTO socios (certificado_no, cedula, nombre, categoria, estatus, fecha_contrato, modalidad, aporte, referido, valor_final, ap_locker, observaciones) VALUES (${s.certificado_no}, '${ced}', '${nom}', '${s.categoria}', '${s.estatus}', ${fc}, '${mod}', ${s.aporte}, ${s.referido}, ${s.valor_final}, ${s.ap_locker}, ${obs});`
  )
}
fs.writeFileSync("C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data\\socios.sql", lines.join("\n"))
console.log(`Written ${socios.length} rows to socios.sql`)
