-- Update planes_pago with actual payments received
-- Matching payments to plan periods by year-month

BEGIN;

UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 159)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 159)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 192)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 192)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 4000000,
    estado = CASE
      WHEN monto_pagado + 4000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 4000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 339)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 4000000,
    estado = CASE
      WHEN monto_pagado + 4000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 4000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 339)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 34)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 34)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 319)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 319)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 160)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 160)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 8000000,
    estado = CASE
      WHEN monto_pagado + 8000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 8000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 161)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 344)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 2000000,
    estado = CASE
      WHEN monto_pagado + 2000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 2000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 344)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 4000000,
    estado = CASE
      WHEN monto_pagado + 4000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 4000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 399)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = monto_pagado + 4000000,
    estado = CASE
      WHEN monto_pagado + 4000000 >= monto_proyectado THEN 'pagado'
      WHEN monto_pagado + 4000000 > 0 THEN 'parcial'
      ELSE estado
    END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 399)
  AND periodo = '2026-05';

COMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS actualizados FROM planes_pago WHERE monto_pagado > 0;
