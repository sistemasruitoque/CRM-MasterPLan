const fs = require("fs")
const path = require("path")

const pagosSQL = fs.readFileSync(path.join("C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data","pagos_recaudo.sql"),"utf8")
const preventaSQL = fs.readFileSync(path.join("C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data","preventa.sql"),"utf8")
const socios = JSON.parse(fs.readFileSync(path.join("C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data","socios.json"),"utf8"))

// Generate plan schedule generation SQL
const planSQL = socios.map(s => "SELECT generar_plan_pagos(id, 1.0) FROM socios WHERE certificado_no = " + s.certificado_no + ";").join("\n")

// Validation SQL
const validationSQL = [
  "-- Verify payment totals",
  "SELECT COUNT(*) AS total_pagos, SUM(monto) AS monto_total FROM pagos;",
  "",
  "-- Verify plan schedules",
  "SELECT COUNT(*) AS total_planes FROM planes_pago;",
  "",
  "-- Top payers",
  "SELECT s.certificado_no, s.nombre, SUM(p.monto) AS total_pagado FROM socios s JOIN pagos p ON p.socio_id = s.id GROUP BY s.certificado_no, s.nombre ORDER BY total_pagado DESC LIMIT 10;",
  "",
  "-- Socios without payments",
  "SELECT s.certificado_no, s.nombre, s.valor_final FROM socios s LEFT JOIN pagos p ON p.socio_id = s.id WHERE p.id IS NULL AND s.categoria <> 'Preventa' ORDER BY s.certificado_no;",
].join("\n")

const fullSQL = [
  "-- ============================================",
  "-- FULL DATA IMPORT",
  "-- Generated from PRN file: 2026 02 18 Base de Datos Master Plan.prn",
  "-- Date: " + new Date().toISOString(),
  "-- ============================================",
  "",
  "-- 1. Add Preventa partners",
  preventaSQL,
  "",
  "-- 2. Delete existing payments and insert new ones",
  pagosSQL,
  "",
  "-- 3. Generate plan schedules for all partners (using 1% monthly interest)",
  planSQL,
  "",
  "-- 4. Validation queries",
  validationSQL,
].join("\n")

const outPath = path.join("C:\\Users\\Usuario\\AppData\\Local\\Temp\\opencode\\club-crm\\data","import_completo.sql")
fs.writeFileSync(outPath, fullSQL, "utf8")
console.log("Written: " + outPath)
console.log("Size: " + (fullSQL.length/1024).toFixed(1) + " KB")
console.log("Statements: " + (fullSQL.match(/;/g)||[]).length)
