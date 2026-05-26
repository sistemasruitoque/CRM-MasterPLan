const fs = require("fs")
const path = require("path")

const MONTHS = {
  Jan: "01", Feb: "02", Mar: "03", Apr: "04", May: "05", Jun: "06",
  Jul: "07", Aug: "08", Sep: "09", Oct: "10", Nov: "11", Dec: "12",
}

function parseCop(str) {
  if (!str || !str.trim()) return 0
  return Number.parseInt(str.trim().replace(/[,.]/g, ""), 10) || 0
}

function findDate(str) {
  const m = str.match(/(\d{1,2})-([A-Za-z]{3})-(\d{2,4})/)
  if (!m) return null
  const day = m[1].padStart(2, "0")
  const mon = MONTHS[m[2]] || m[2]
  let yr = m[3]
  if (yr.length === 2) yr = "20" + yr
  return `${day}/${mon}/${yr}`
}

function extractCedula(line) {
  let s = ""
  for (let i = 13; i < Math.min(35, line.length); i++) {
    if (/\d/.test(line[i])) s += line[i]
    else if (s.length > 0) break
  }
  return s
}

function extractName(line) {
  let cedEnd = 13
  for (let i = 13; i < Math.min(35, line.length); i++) {
    if (!/\d/.test(line[i])) {
      if (i > 13) { cedEnd = i; break }
      cedEnd = i + 1
    } else {
      cedEnd = i + 1
    }
  }
  return line.substring(cedEnd, 48).trim()
}

function parseLine(line) {
  const certRaw = line.substring(4, 8).trim()
  const certNo = Number.parseInt(certRaw, 10)
  if (!certNo || certNo <= 0) return null

  const nombre = extractName(line)
  if (!nombre) return null
  const cedula = extractCedula(line)

  // Category
  const catRaw = line.substring(48, 58).trim()
  let categoria = ""
  if (/^fundador$/i.test(catRaw)) categoria = "Fundador"
  else if (/^fase\s*i$/i.test(catRaw)) categoria = "Fase I"
  else if (/^fase\s*ii$/i.test(catRaw)) categoria = "Fase II"
  else if (/^fase\s*iii$/i.test(catRaw)) categoria = "Fase III"
  if (!categoria) return null

  // Status
  const statusArea = line.substring(58, 90)
  let estatus = "Pendiente"
  if (/por\s*firmar/i.test(statusArea)) estatus = "Por Firmar"
  else if (/firmado/i.test(statusArea)) estatus = "Firmado"

  // Date
  const fechaContrato = findDate(line.substring(68, 90))

  // Modalidad
  const modRaw = line.substring(139, 147)
  const modalidad = /avalf/i.test(modRaw) ? "AvalFiduciari" : "Corporación"

  // Extract monetary values with commas (e.g. 150,000,000)
  const monArea = line.substring(147)
  const amounts = []
  const re = /\d{1,3}(?:,\d{3})+/g
  let m
  while ((m = re.exec(monArea)) !== null) {
    amounts.push(parseCop(m[0]))
  }

  // Separate small values (likely admin/clubes ≤ 10M) and large values
  const allLarge = amounts.filter(a => a > 10000000)
  const small = amounts.filter(a => a > 0 && a <= 10000000)

  let aporte = 0, referido = 0, valorFinal = 0, apLocker = 0

  if (allLarge.length >= 1) {
    aporte = allLarge[0]

    if (allLarge.length >= 2) {
      // Find the best (referido, valorFinal) pair where aporte - ref = vf
      // and where ref < vf (referido is the smaller deduction)
      const candidates = []
      for (let i = 1; i < allLarge.length; i++) {
        const candidateRef = aporte - allLarge[i]
        if (candidateRef > 0 && candidateRef < aporte) {
          const refExists = amounts.indexOf(candidateRef) !== -1 || small.indexOf(candidateRef) !== -1
          if (refExists) candidates.push({ ref: candidateRef, vf: allLarge[i] })
        }
      }
      // Pick candidate where ref < vf (referido is smaller than valor final)
      // Among those, prefer smallest ref
      const valid = candidates.filter(c => c.ref <= c.vf)
      if (valid.length > 0) {
        valid.sort((a, b) => a.ref - b.ref)
        referido = valid[0].ref
        valorFinal = valid[0].vf
      } else if (candidates.length > 0) {
        // No valid pair with ref < vf, use the first candidate
        referido = candidates[0].ref
        valorFinal = candidates[0].vf
      } else {
        // Fallback: no referido detected
        valorFinal = allLarge[0]
        referido = 0
      }
    } else {
      valorFinal = aporte
    }

    // ApLocker: small values not used as referido
    const leftover = small.filter(a => a !== referido)
    apLocker = leftover.length > 0 ? leftover[leftover.length - 1] : 0
  }

  // Observaciones
  const obsArea = line.substring(83, 139)
    .replace(/#{2,}/g, "")
    .replace(/\s+/g, " ").trim()
  const observaciones = obsArea
    .replace(/^(2|4),0\s*/, "")
    .replace(/Activo\s*\d+\s*de\s*\d+/gi, "")
    .trim()

  return {
    certificado_no: certNo,
    cedula,
    nombre,
    categoria,
    estatus,
    fecha_contrato: fechaContrato,
    modalidad,
    aporte,
    referido,
    valor_final: valorFinal,
    ap_locker: apLocker,
    observaciones: observaciones || "",
  }
}

function main() {
  const prnPath = process.argv[2] || "C:\\Users\\Usuario\\Downloads\\2026 02 18 Base de Datos Master Plan.prn"
  const outputPath = process.argv[3] || path.join(__dirname, "..", "data", "socios.json")

  const content = fs.readFileSync(prnPath, "utf8")
  const lines = content.split("\n").map(l => l.replace(/\r$/, ""))

  const socios = []
  for (let i = 5; i < lines.length; i++) {
    const line = lines[i]
    if (!line || line.length < 180) continue
    const record = parseLine(line)
    if (record) socios.push(record)
    else if (socios.length > 10) {
      // Once we've found some partners and start seeing non-matching rows, stop
      const catCheck = line.substring(48, 58).trim()
      const certCheck = line.substring(4, 8).trim()
      if (!certCheck && /fase/i.test(catCheck)) break
    }
  }

  console.log(`Parsed ${socios.length} socios`)

  // Print first 3
  for (let i = 0; i < 3 && i < socios.length; i++) {
    console.log(`\n--- ${i+1}. cert=${socios[i].certificado_no} ${socios[i].nombre} ---`)
    console.log(JSON.stringify(socios[i], null, 2))
  }

  // Spot-check rows with referido
  const withRef = socios.filter(s => s.referido > 0)
  console.log(`\nSocios con referido: ${withRef.length}`)
  for (const s of withRef.slice(0, 5)) {
    console.log(`  #${s.certificado_no} ${s.nombre}: aporte=${s.aporte.toLocaleString()}, ref=${s.referido.toLocaleString()}, vf=${s.valor_final.toLocaleString()}`)
  }

  // Check some rows with ap_locker
  const withLocker = socios.filter(s => s.ap_locker > 0)
  console.log(`\nSocios con ap_locker: ${withLocker.length}`)

  // Summary
  const cats = {}
  for (const s of socios) cats[s.categoria] = (cats[s.categoria] || 0) + 1
  console.log(`\nBy category:`, cats)

  const totals = { ap: 0, ref: 0, vf: 0 }
  for (const s of socios) { totals.ap += s.aporte; totals.ref += s.referido; totals.vf += s.valor_final }
  console.log(`Total aporte: ${totals.ap.toLocaleString("en-US")}`)
  console.log(`Total referido: ${totals.ref.toLocaleString("en-US")}`)
  console.log(`Total valor final: ${totals.vf.toLocaleString("en-US")}`)

  // Write JSON
  const outDir = path.dirname(outputPath)
  if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true })
  fs.writeFileSync(outputPath, JSON.stringify(socios, null, 2), "utf8")
  console.log(`\nWritten: ${outputPath}`)

  // Write SQL
  const sqlPath = outputPath.replace(/\.json$/, ".sql")
  const sqlLines = []
  for (const s of socios) {
    const fc = s.fecha_contrato ? `'${s.fecha_contrato}'` : "NULL"
    const obs = s.observaciones ? `'${s.observaciones.replace(/'/g, "''")}'` : "''"
    sqlLines.push(
      `INSERT INTO socios (certificado_no, cedula, nombre, categoria, estatus, fecha_contrato, modalidad, aporte, referido, valor_final, ap_locker, observaciones) VALUES (${s.certificado_no}, '${s.cedula.replace(/'/g, "''")}', '${s.nombre.replace(/'/g, "''")}', '${s.categoria}', '${s.estatus}', ${fc}, '${s.modalidad.replace(/'/g, "''")}', ${s.aporte}, ${s.referido}, ${s.valor_final}, ${s.ap_locker}, ${obs});`
    )
  }
  fs.writeFileSync(sqlPath, sqlLines.join("\n"), "utf8")
  console.log(`SQL written: ${sqlPath}`)
}

main()
