-- Insertar plan de pagos para William Jovanny Cardozo (cert 73)
-- Se salta si ya existe (ON CONFLICT DO NOTHING)

INSERT INTO planes_pago (periodo, monto_proyectado, socio_id)
SELECT periodo, monto, (SELECT id FROM socios WHERE certificado_no = 73)
FROM (VALUES
  ('2025-11', 20000000),
  ('2026-02', 20000000),
  ('2026-03', 35000000)
) AS data(periodo, monto)
WHERE NOT EXISTS (
  SELECT 1 FROM planes_pago pp
  WHERE pp.socio_id = (SELECT id FROM socios WHERE certificado_no = 73)
  AND pp.periodo = data.periodo
);

-- Verificar resultado
SELECT pp.periodo, pp.monto_proyectado, pp.monto_pagado, pp.estado
FROM planes_pago pp
JOIN socios s ON s.id = pp.socio_id
WHERE s.certificado_no = 73
ORDER BY pp.periodo;
