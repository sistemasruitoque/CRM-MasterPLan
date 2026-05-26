const fs = require("fs");
const buf = fs.readFileSync(
  "C:\\Users\\Usuario\\OneDrive - RUITOQUE GOLF COUNTRY CLUB S.A.S\\Documentos\\pago_pactado.prn"
);
const lines = buf.toString("latin1").split(/\r?\n/);

// Show partner data line 4
console.log("=== PARTNER LINE 4 (first partner) ===");
const l4 = lines[3];
console.log("Length:", l4.length);
console.log("Raw:", JSON.stringify(l4.substring(0, 100)));
console.log("Chars 0-4:", JSON.stringify(l4.substring(0, 5)));
console.log("Chars 5-14:", JSON.stringify(l4.substring(5, 15)));
console.log("Chars 15-24:", JSON.stringify(l4.substring(15, 25)));
console.log("Chars 25-39:", JSON.stringify(l4.substring(25, 39)));
console.log("Chars 39-49:", JSON.stringify(l4.substring(39, 49)));
console.log("Chars 49-59:", JSON.stringify(l4.substring(49, 59)));

// Show header row (line 123)
console.log("\n=== HEADER LINE 123 (Dec-25...) ===");
const h1 = lines[122];
console.log("Length:", h1.length);
console.log("Raw:", JSON.stringify(h1.substring(0, 288)));

// Examine field by field
console.log("\n=== HEADER FIELDS (12 chars each) ===");
for (let i = 0; i < 24; i++) {
  const field = h1.substring(i * 12, (i + 1) * 12);
  console.log("Field " + i + ": " + JSON.stringify(field));
}

// Show data row 1 (line 124)
console.log("\n=== DATA ROW 1 (cert 259) ===");
const r1 = lines[123];
console.log("Length:", r1.length);
console.log("Raw:", JSON.stringify(r1));

// Try extracting values with strict regex
const nums = r1.match(/\d{1,3}(?:,\d{3})*/g);
console.log("Extracted numbers:", nums);

// Parse with 12-char fixed width (with space padding)
const padded = r1.padEnd(288, " ");
console.log("\n12-char field extraction:");
for (let i = 0; i < 24; i++) {
  const field = padded.substring(i * 12, (i + 1) * 12).trim();
  if (field) {
    // Try extracting a valid number from start of field
    const m = field.match(/^\d{1,3}(?:,\d{3})*/);
    if (m) {
      console.log("Field " + i + ": " + field + " -> " + m[0] + " = " + parseInt(m[0].replace(/,/g, "")));
    } else {
      console.log("Field " + i + ": " + field + " (no match)");
    }
  } else {
    console.log("Field " + i + ": (empty)");
  }
}

// Show data row 2 (line 125)
console.log("\n=== DATA ROW 2 (cert 773) ===");
const r2 = lines[124];
console.log("Length:", r2.length);
console.log("Raw:", JSON.stringify(r2));

const padded2 = r2.padEnd(288, " ");
for (let i = 0; i < 24; i++) {
  const field = padded2.substring(i * 12, (i + 1) * 12).trim();
  if (field) {
    const m = field.match(/^\d{1,3}(?:,\d{3})*/);
    if (m) {
      console.log("Field " + i + ": " + field + " -> " + m[0] + " = " + parseInt(m[0].replace(/,/g, "")));
    }
  }
}
