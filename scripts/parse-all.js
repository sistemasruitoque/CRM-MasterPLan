const fs = require("fs")
const path = require("path")

const PRN_PATH = process.argv[2] || "C:\\Users\\Usuario\\Downloads\\2026 02 18 Base de Datos Master Plan.prn"
const OUTPUT_DIR = path.join(__dirname, "..", "data")

function parseCop(s) { return Number.parseInt((s||"").trim().replace(/[,.]/g,""),10)||0 }
function allMatches(line, re) { const o=[];let m;while((m=re.exec(line))!==null)o.push(m[0]);return o }

const MONTHS={Jan:"01",Feb:"02",Mar:"03",Apr:"04",May:"05",Jun:"06",Jul:"07",Aug:"08",Sep:"09",Oct:"10",Nov:"11",Dec:"12"}
function findDate(s){const m=s.match(/(\d{1,2})-([A-Za-z]{3})-(\d{2,4})/);if(!m)return null;const d=m[1].padStart(2,"0"),mo=MONTHS[m[2]]||m[2],y=m[3].length===2?"20"+m[3]:m[3];return d+"/"+mo+"/"+y}
function extractCedula(l){let s="";for(let i=13;i<Math.min(35,l.length);i++){if(/\d/.test(l[i]))s+=l[i];else if(s.length>0)break}return s}
function extractName(l){let e=13;for(let i=13;i<Math.min(35,l.length);i++){if(!/\d/.test(l[i])){if(i>13){e=i;break}e=i+1}else e=i+1}return l.substring(e,48).trim()}

function parsePartners(lines,s=5,e=124){
  const out=[]
  for(let i=s;i<=e&&i<lines.length;i++){
    const l=lines[i];if(!l||l.length<180)continue
    const cn=Number.parseInt(l.substring(4,8).trim(),10)
    if(!cn||cn<=0)continue;const n=extractName(l);if(!n)continue
    const c=extractCedula(l);const cr=l.substring(48,58).trim()
    let cat=""
    if(/^fundador$/i.test(cr))cat="Fundador"
    else if(/^fase\s*i$/i.test(cr))cat="Fase I"
    else if(/^fase\s*ii$/i.test(cr))cat="Fase II"
    else if(/^fase\s*iii$/i.test(cr))cat="Fase III"
    if(!cat)continue
    const sa=l.substring(58,90)
    let es="Pendiente"
    if(/por\s*firmar/i.test(sa))es="Por Firmar"
    else if(/firmado/i.test(sa))es="Firmado"
    const fc=findDate(l.substring(68,90));const mr=l.substring(139,147)
    const md=/avalf/i.test(mr)?"AvalFiduciari":"Corporaci\u00f3n"
    const amts=allMatches(l.substring(147),/\d{1,3}(?:,\d{3})+/g).map(parseCop)
    const lg=amts.filter(a=>a>10000000);const sm=amts.filter(a=>a>0&&a<=10000000)
    let ap=0,ref=0,vf=0,al=0
    if(lg.length>=1){ap=lg[0]
      if(lg.length>=2){const c2=[]
        for(let j=1;j<lg.length;j++){const cr=ap-lg[j];if(cr>0&&cr<ap&&(amts.indexOf(cr)!==-1||sm.indexOf(cr)!==-1))c2.push({ref:cr,vf:lg[j]})}
        const v=c2.filter(x=>x.ref<=x.vf).sort((a,b)=>a.ref-b.ref)
        if(v.length>0){ref=v[0].ref;vf=v[0].vf}else if(c2.length>0){ref=c2[0].ref;vf=c2[0].vf}else vf=ap
      }else vf=ap
      al=(sm.filter(a=>a!==ref).pop())||0
    }
    const ob=l.substring(83,139).replace(/#{2,}/g,"").replace(/\s+/g," ").trim().replace(/^(2|4),0\s*/,"").replace(/Activo\s*\d+\s*de\s*\d+/gi,"").trim()
    out.push({certificado_no:cn,cedula:c,nombre:n,categoria:cat,estatus:es,fecha_contrato:fc,modalidad:md,aporte:ap,referido:ref,valor_final:vf,ap_locker:al,observaciones:ob||""})
  }
  return out
}

function parsePreventa(lines,s=366,e=382){
  const out=[]
  for(let i=s;i<=e&&i<lines.length;i++){const l=lines[i];if(!l||l.trim().length<20)continue;const m=l.match(/^\s*(\d+)\s+Preventa\s+(.+)/);if(m)out.push({certificado_no:parseInt(m[1]),nombre:"Preventa "+m[2].trim(),categoria:"Preventa"})}
  return out
}

// Parse "Total Recaudo A" section (lines 1533-1644 approximately)
// Data rows have comma-formatted values; last value is Total Recaudo A
// We skip: header rows, summary rows, far-future projection rows
function parseRecaudo(lines,start=1532,end=1900){
  const rows=[]
  for(let i=start;i<=end&&i<lines.length;i++){
    const l=lines[i];if(!l||l.trim().length<10)continue
    const t=l.trim()
    if(/^[A-Za-z]/.test(t)||/\$/.test(l))continue
    const commaVals=allMatches(l,/\d{1,3}(?:,\d{3})+/g).map(parseCop)
    if(commaVals.length<2)continue
    // Skip far-future projection totals (6+ comma values in first 100 chars)
    if(allMatches(l.substring(0,100),/\d{1,3}(?:,\d{3})+/g).length>=6)continue
    // Skip repeated-value rows (same amount repeating for projections)
    const unique=new Set(commaVals)
    if(commaVals.length>=4&&unique.size<=2&&commaVals[0]===commaVals[commaVals.length-1])continue
    rows.push({values:commaVals,total:commaVals[commaVals.length-1]})
  }
  return rows
}

function main(){
  const content=fs.readFileSync(PRN_PATH,"utf8")
  const lines=content.split("\n").map(l=>l.replace(/\r$/,""))
  if(!fs.existsSync(OUTPUT_DIR))fs.mkdirSync(OUTPUT_DIR,{recursive:true})

  const socios=parsePartners(lines);console.log("Partners: "+socios.length)
  const preventa=parsePreventa(lines);console.log("Preventa: "+preventa.length)
  const recaudo=parseRecaudo(lines);console.log("Recaudo rows: "+recaudo.length)

  // Show first 5
  console.log("\nFirst 5 recaudo:")
  for(let i=0;i<5&&i<recaudo.length;i++){
    const r=recaudo[i];const s=socios[i]
    console.log("  #"+s.certificado_no+" "+s.nombre+": vals=["+r.values.join("|")+"] total="+r.total.toLocaleString("en-US"))
  }

  // Generate payment SQL (one total payment per partner)
  const paymentSQL=[]
  let payCount=0,totalAmount=0
  for(let i=0;i<Math.min(recaudo.length,socios.length);i++){
    const r=recaudo[i];const s=socios[i];const total=r.total
    if(total>0){
      paymentSQL.push("INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) SELECT id, "+total+", '2026-05-26', 'cuota', 'Total recaudado a May-2026' FROM socios WHERE certificado_no = "+s.certificado_no+";")
      payCount++;totalAmount+=total
    }
  }
  console.log("\nPayments: "+payCount+", total: "+totalAmount.toLocaleString("en-US"))

  // Preventa SQL
  const prevSQL=preventa.map(p=>"INSERT INTO socios (certificado_no, cedula, nombre, categoria, estatus, modalidad, aporte, valor_final) VALUES ("+p.certificado_no+", 'PREVENTA', '"+p.nombre.replace(/'/g,"''")+"', 'Preventa', 'Pendiente', 'Corporaci\u00f3n', 0, 0) ON CONFLICT (certificado_no) DO NOTHING;")

  // Write
  fs.writeFileSync(path.join(OUTPUT_DIR,"pagos_recaudo.sql"),["-- Delete existing payment records","DELETE FROM pagos;","","-- Insert "+payCount+" payment records","",paymentSQL.join("\n")].join("\n"),"utf8")
  console.log("Written: pagos_recaudo.sql")
  fs.writeFileSync(path.join(OUTPUT_DIR,"preventa.sql"),prevSQL.join("\n"),"utf8")
  console.log("Written: preventa.sql")

  // Mapped JSON for verification
  const mapped=recaudo.slice(0,socios.length).map((r,i)=>({index:i,certificado_no:socios[i].certificado_no,nombre:socios[i].nombre,totalRecaudoA:r.total}))
  fs.writeFileSync(path.join(OUTPUT_DIR,"recaudo_mapped.json"),JSON.stringify(mapped,null,2),"utf8")

  const recSum=recaudo.slice(0,socios.length).reduce((s,r)=>s+r.total,0)
  console.log("\n=== VERIFICATION ===")
  console.log("Recaudo sum (main): "+recSum.toLocaleString("en-US"))
  console.log("Missing (no recaudo): "+(socios.length-recaudo.length)+" partners")
  // Find which partner is missing
  if(socios.length>recaudo.length){
    for(let i=recaudo.length;i<socios.length;i++){
      console.log("  Missing: #"+socios[i].certificado_no+" "+socios[i].nombre+" (VF: "+socios[i].valor_final.toLocaleString("en-US")+")")
    }
  }
}

main()
