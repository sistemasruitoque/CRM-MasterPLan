const fs = require("fs")
const lines = fs.readFileSync("C:\\Users\\Usuario\\Downloads\\2026 02 18 Base de Datos Master Plan.prn", "utf8").split("\n")
const rows = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 33, 36, 45, 55]
for (const ri of rows) {
  const l = lines[ri]
  if (!l) continue
  console.log("Row " + (ri + 1))
  console.log("  cert[4-7]:      [" + l.substring(4, 7) + "]")
  console.log("  chars13-22:     [" + l.substring(13, 23) + "]")
  console.log("  chars22-48:     [" + l.substring(22, 48) + "]")
  console.log("  cat[48-58]:     [" + l.substring(48, 58) + "]")
  console.log("  est[59-68]:     [" + l.substring(59, 68) + "]")
  console.log("  date[68-83]:    [" + l.substring(68, 83) + "]")
  console.log("  contrat[83-90]: [" + l.substring(83, 90) + "]")
  console.log("  aporte[146-162]:[" + l.substring(146, 162) + "]")
  console.log("  refer[164-176]: [" + l.substring(164, 176) + "]")
  console.log("  vfinal[174-188]:[" + l.substring(174, 188) + "]")
  console.log("  alocker[186-196]:[" + l.substring(186, 196) + "]")
  console.log("  modal[139-147]: [" + l.substring(139, 147) + "]")
  console.log("")
}
