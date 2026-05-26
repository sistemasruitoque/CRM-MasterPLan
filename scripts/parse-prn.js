const fs = require("fs")
const path = require("path")

const MONTHS = {
  Jan: "01", Feb: "02", Mar: "03", Apr: "04", May: "05", Jun: "06",
  Jul: "07", Aug: "08", Sep: "09", Oct: "10", Nov: "11", Dec: "12",
}

function parseCop(str) {
  if (!str || !str.trim()) return 0
  const cleaned = str.trim().replace(/\./g, "").replace(/,/g, "")
  const num = Number.parseInt(cleaned, 10)
  return Number.isNaN(num) ? 0 : num
}

function findAllCopAmounts(str) {
  const amounts = []
  const re = /\d{1,3}(?:\.\d{3})*(?:,\d+)?/g
  let m
  while ((m = re.exec(str)) !== null) {
    amounts.push(parseCop(m[0]))
  }
  return amounts
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

function extractCedulaAndName(line) {
  // Positions 13-22 contain the start of cedula/name area
  // The cedula, if present, contains only digits starting at position 13
  let cedEnd = 13
  for (let i = 13; i < Math.min(35, line.length); i++) {
    if (!/\d/.test(line[i])) {
      cedEnd = i
      break
    }
    cedEnd = i + 1
  }
  const cedula = line.substring(13, cedEnd).trim()
  const nombre = line.substring(cedEnd, 48).trim()
  return { cedula, nombre }
}

function parseLine(line) {
  const certStr = line.substring(4, 8).trim()
  const certNo = Number.parseInt(certStr, 10)
  if (!certNo || certNo <= 0) return null

  // Name and cedula
  const { cedula, nombre } = extractCedulaAndName(line)
  if (!nombre) return null // placeholder row

  // Categoria: positions 48-58
  const catRaw = line.substring(48, 58).trim()
  // Normalize category
  let categoria = catRaw
  if (/fundador/i.test(catRaw)) categoria = "Fundador"
  else if (/fase\s*i/i.test(catRaw)) categoria = "Fase I"
  else if (/fase\s*ii/i.test(catRaw)) categoria = "Fase II"
  else if (/fase\s*iii/i.test(catRaw)) categoria = "Fase III"

  // Estatus: positions 60-66
  const estRaw = line.substring(60, 67).trim()
  let estatus = estRaw
  // Check for "Por Firmar" which may be split across columns
  if (line.substring(60, 90).includes("Por Firmar")) {
    estatus = "Por Firmar"
  } else if (!estatus || estatus.length < 3) {
    estatus = "Pendiente"
  }

  // Contract date - find anywhere in the line
  const fechaContrato = findDate(line)

  // Modalidad
  const modRaw = line.substring(139, 147).trim()
  let modalidad = "Corporación"
  if (/avalfid/i.test(modRaw) || /avalf/i.test(modRaw)) {
    modalidad = "AvalFiduciari"
  }

  // Find all monetary values in this line
  const allAmounts = findAllCopAmounts(line)

  // Filter meaningful amounts (> 1000000) and sort descending
  const largeAmounts = allAmounts.filter(a => a > 1000000).sort((a, b) => b - a)
  const smallAmounts = allAmounts.filter(a => a > 0 && a <= 1000000)

  // Determine referido: it should be present in the line near position 164-176
  // and typically matches a value that when subtracted from aporte gives valor_final
  let aporte = 0
  let referido = 0
  let valorFinal = 0

  if (largeAmounts.length >= 2) {
    // The largest amounts are typically aporte and valor_final
    // In some rows, valor_final = aporte - referido
    // Heuristic: find three values where third = first - second
    const sorted = [...largeAmounts].sort((a, b) => a - b)

    // Try to find a trio where a - b = c
    let foundTrio = false
    for (let i = 0; i < sorted.length && !foundTrio; i++) {
      for (let j = 0; j < sorted.length && !foundTrio; j++) {
        if (i === j) continue
        const diff = sorted[i] - sorted[j]
        if (sorted.includes(diff) && diff > 0) {
          aporte = sorted[i]
          referido = sorted[j]
          valorFinal = diff
          foundTrio = true
        }
      }
    }

    if (!foundTrio) {
      // Fallback: pick largest as aporte, check if another matches "aporte - X"
      aporte = Math.max(...largeAmounts)
      const remaining = largeAmounts.filter(a => a !== aporte)
      valorFinal = Math.max(...remaining)
      referido = aporte - valorFinal
      if (referido <= 0 || referido > aporte) referido = 0
    }
  } else if (largeAmounts.length === 1) {
    aporte = largeAmounts[0]
    valorFinal = aporte
  }

  // ApLocker: find 2,000,000 values that appear after valor_final in the line
  const vfEnd = line.lastIndexOf(String(valorFinal).replace(/,/g, ""))
  // Actually, just look for amounts around 2,000,000
  const lockerAmounts = allAmounts.filter(a =>
    a === 2000000 || a === 4000000 || (a > 0 && a <= 10000000)
  )
  const apLocker = lockerAmounts.length > 0 ? lockerAmounts[lockerAmounts.length - 1] : 0

  // Observaciones: extract free-form text from the notes area
  const obsArea = line.substring(83, 139).replace(/#/g, "").trim()

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
    observaciones: obsArea || "",
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
    if (record) {
      socios.push(record)
    }
  }

  console.log(`Parsed ${socios.length} socios`)

  if (socios.length === 0) {
    console.log("Debug first rows:")
    for (let i = 5; i < Math.min(10, lines.length); i++) {
      const line = lines[i]
      console.log(`Row ${i + 1}: cert='${line.substring(4, 8).trim()}' name='${line.substring(22, 48).trim()}' cat='${line.substring(48, 58).trim()}'`)
    }
    return
  }

  // Print first 3
  for (let i = 0; i < 3 && i < socios.length; i++) {
    console.log(`\n--- Socio ${i + 1} (cert=${socios[i].certificado_no}) ---`)
    console.log(JSON.stringify(socios[i], null, 2))
  }

  // Summary
  const cats = {}
  for (const s of socios) { cats[s.categoria] = (cats[s.categoria] || 0) + 1 }
  console.log("\nBy category:", cats)
  const totalVF = socios.reduce((s, x) => s + x.valor_final, 0)
  const totalAp = socios.reduce((s, x) => s + x.aporte, 0)
  const totalRef = socios.reduce((s, x) => s + x.referido, 0)
  console.log(`Total aporte: ${totalAp.toLocaleString("en-US")}`)
  console.log(`Total referido: ${totalRef.toLocaleString("en-US")}`)
  console.log(`Total valor final: ${totalVF.toLocaleString("en-US")}`)

  // Write JSON
  const outDir = path.dirname(outputPath)
  if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true })
  fs.writeFileSync(outputPath, JSON.stringify(socios, null, 2), "utf8")
  console.log(`\nWritten: ${outputPath}`)
}

main()
