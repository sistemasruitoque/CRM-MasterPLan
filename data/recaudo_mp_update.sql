-- Update planes_pago with recaudo amounts

BEGIN;

UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 259)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 4500000,
    estado = CASE WHEN 4500000 >= monto_proyectado THEN 'pagado' WHEN 4500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 259)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 259)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 4500000,
    estado = CASE WHEN 4500000 >= monto_proyectado THEN 'pagado' WHEN 4500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 259)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 773)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 38000000,
    estado = CASE WHEN 38000000 >= monto_proyectado THEN 'pagado' WHEN 38000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 773)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 38000000,
    estado = CASE WHEN 38000000 >= monto_proyectado THEN 'pagado' WHEN 38000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 773)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 80)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 80)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 92)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 27500000,
    estado = CASE WHEN 27500000 >= monto_proyectado THEN 'pagado' WHEN 27500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 92)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 40)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 40)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 40)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 40)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 40)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 245)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 245)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 245)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10937500,
    estado = CASE WHEN 10937500 >= monto_proyectado THEN 'pagado' WHEN 10937500 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 245)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 48832500,
    estado = CASE WHEN 48832500 >= monto_proyectado THEN 'pagado' WHEN 48832500 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 245)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 5855000,
    estado = CASE WHEN 5855000 >= monto_proyectado THEN 'pagado' WHEN 5855000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 245)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 38000000,
    estado = CASE WHEN 38000000 >= monto_proyectado THEN 'pagado' WHEN 38000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 777)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 42000000,
    estado = CASE WHEN 42000000 >= monto_proyectado THEN 'pagado' WHEN 42000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 777)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 302)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 302)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 302)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 302)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 302)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 112)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 112)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 112)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 112)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 112)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 112)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 112)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 112)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 159)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 159)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 9142500,
    estado = CASE WHEN 9142500 >= monto_proyectado THEN 'pagado' WHEN 9142500 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 159)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 159)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 159)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 16500000,
    estado = CASE WHEN 16500000 >= monto_proyectado THEN 'pagado' WHEN 16500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 159)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 159)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 365)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 365)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 7000000,
    estado = CASE WHEN 7000000 >= monto_proyectado THEN 'pagado' WHEN 7000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 365)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 45)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20005000,
    estado = CASE WHEN 20005000 >= monto_proyectado THEN 'pagado' WHEN 20005000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 143)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 143)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 143)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 143)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 143)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 143)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 37)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 37)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 192)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 192)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 192)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 192)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 8320000,
    estado = CASE WHEN 8320000 >= monto_proyectado THEN 'pagado' WHEN 8320000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 192)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 11000000,
    estado = CASE WHEN 11000000 >= monto_proyectado THEN 'pagado' WHEN 11000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 192)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 3830000,
    estado = CASE WHEN 3830000 >= monto_proyectado THEN 'pagado' WHEN 3830000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 192)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 15000000,
    estado = CASE WHEN 15000000 >= monto_proyectado THEN 'pagado' WHEN 15000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 32)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 32)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 70)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 70)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 70)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 70)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 70)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 249)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 10800000,
    estado = CASE WHEN 10800000 >= monto_proyectado THEN 'pagado' WHEN 10800000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 249)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 10800000,
    estado = CASE WHEN 10800000 >= monto_proyectado THEN 'pagado' WHEN 10800000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 249)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10800000,
    estado = CASE WHEN 10800000 >= monto_proyectado THEN 'pagado' WHEN 10800000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 249)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 10800000,
    estado = CASE WHEN 10800000 >= monto_proyectado THEN 'pagado' WHEN 10800000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 249)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 10800000,
    estado = CASE WHEN 10800000 >= monto_proyectado THEN 'pagado' WHEN 10800000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 249)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 10800000,
    estado = CASE WHEN 10800000 >= monto_proyectado THEN 'pagado' WHEN 10800000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 249)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 10800000,
    estado = CASE WHEN 10800000 >= monto_proyectado THEN 'pagado' WHEN 10800000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 249)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 56)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 56)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 56)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 56)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 70000000,
    estado = CASE WHEN 70000000 >= monto_proyectado THEN 'pagado' WHEN 70000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 56)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 56)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 47)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 47)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 47)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 83)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 4500000,
    estado = CASE WHEN 4500000 >= monto_proyectado THEN 'pagado' WHEN 4500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 83)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 13500000,
    estado = CASE WHEN 13500000 >= monto_proyectado THEN 'pagado' WHEN 13500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 83)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 203)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 321)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 202)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 202)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 202)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 202)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 202)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 202)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 723)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 723)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 4000000,
    estado = CASE WHEN 4000000 >= monto_proyectado THEN 'pagado' WHEN 4000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 723)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 16000000,
    estado = CASE WHEN 16000000 >= monto_proyectado THEN 'pagado' WHEN 16000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 723)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 1000000,
    estado = CASE WHEN 1000000 >= monto_proyectado THEN 'pagado' WHEN 1000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 723)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 61)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 25000000,
    estado = CASE WHEN 25000000 >= monto_proyectado THEN 'pagado' WHEN 25000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 689)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 689)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 45000000,
    estado = CASE WHEN 45000000 >= monto_proyectado THEN 'pagado' WHEN 45000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 575)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 610)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 24000000,
    estado = CASE WHEN 24000000 >= monto_proyectado THEN 'pagado' WHEN 24000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 610)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 610)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 610)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 610)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 15000000,
    estado = CASE WHEN 15000000 >= monto_proyectado THEN 'pagado' WHEN 15000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 610)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 163)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 35000000,
    estado = CASE WHEN 35000000 >= monto_proyectado THEN 'pagado' WHEN 35000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 163)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 34031250,
    estado = CASE WHEN 34031250 >= monto_proyectado THEN 'pagado' WHEN 34031250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 306)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 9281250,
    estado = CASE WHEN 9281250 >= monto_proyectado THEN 'pagado' WHEN 9281250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 306)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 9281250,
    estado = CASE WHEN 9281250 >= monto_proyectado THEN 'pagado' WHEN 9281250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 306)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 9281250,
    estado = CASE WHEN 9281250 >= monto_proyectado THEN 'pagado' WHEN 9281250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 306)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 9281250,
    estado = CASE WHEN 9281250 >= monto_proyectado THEN 'pagado' WHEN 9281250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 306)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 9281250,
    estado = CASE WHEN 9281250 >= monto_proyectado THEN 'pagado' WHEN 9281250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 306)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 24750000,
    estado = CASE WHEN 24750000 >= monto_proyectado THEN 'pagado' WHEN 24750000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 297)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 11000000,
    estado = CASE WHEN 11000000 >= monto_proyectado THEN 'pagado' WHEN 11000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 297)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 5500000,
    estado = CASE WHEN 5500000 >= monto_proyectado THEN 'pagado' WHEN 5500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 297)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 5500000,
    estado = CASE WHEN 5500000 >= monto_proyectado THEN 'pagado' WHEN 5500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 297)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 5500000,
    estado = CASE WHEN 5500000 >= monto_proyectado THEN 'pagado' WHEN 5500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 297)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 5500000,
    estado = CASE WHEN 5500000 >= monto_proyectado THEN 'pagado' WHEN 5500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 297)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 42000000,
    estado = CASE WHEN 42000000 >= monto_proyectado THEN 'pagado' WHEN 42000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 309)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 16500000,
    estado = CASE WHEN 16500000 >= monto_proyectado THEN 'pagado' WHEN 16500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 309)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 309)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 309)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 309)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 309)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 142)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 142)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 142)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 142)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 142)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 142)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 71)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 21000000,
    estado = CASE WHEN 21000000 >= monto_proyectado THEN 'pagado' WHEN 21000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 71)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 71)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 50000000,
    estado = CASE WHEN 50000000 >= monto_proyectado THEN 'pagado' WHEN 50000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 71)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 71)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 242)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 25000000,
    estado = CASE WHEN 25000000 >= monto_proyectado THEN 'pagado' WHEN 25000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 242)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 341)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 341)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 5625000,
    estado = CASE WHEN 5625000 >= monto_proyectado THEN 'pagado' WHEN 5625000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 341)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 11250000,
    estado = CASE WHEN 11250000 >= monto_proyectado THEN 'pagado' WHEN 11250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 341)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 5625000,
    estado = CASE WHEN 5625000 >= monto_proyectado THEN 'pagado' WHEN 5625000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 341)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 621)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 621)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 7500000,
    estado = CASE WHEN 7500000 >= monto_proyectado THEN 'pagado' WHEN 7500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 621)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 7500000,
    estado = CASE WHEN 7500000 >= monto_proyectado THEN 'pagado' WHEN 7500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 621)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 7500000,
    estado = CASE WHEN 7500000 >= monto_proyectado THEN 'pagado' WHEN 7500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 621)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 21)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 21)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 21)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 1000000,
    estado = CASE WHEN 1000000 >= monto_proyectado THEN 'pagado' WHEN 1000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 21)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 1000000,
    estado = CASE WHEN 1000000 >= monto_proyectado THEN 'pagado' WHEN 1000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 21)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 1000000,
    estado = CASE WHEN 1000000 >= monto_proyectado THEN 'pagado' WHEN 1000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 21)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 45000000,
    estado = CASE WHEN 45000000 >= monto_proyectado THEN 'pagado' WHEN 45000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 222)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 167)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 167)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 167)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 427)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 25000000,
    estado = CASE WHEN 25000000 >= monto_proyectado THEN 'pagado' WHEN 25000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 427)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 25000000,
    estado = CASE WHEN 25000000 >= monto_proyectado THEN 'pagado' WHEN 25000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 427)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 90)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 366)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 16000000,
    estado = CASE WHEN 16000000 >= monto_proyectado THEN 'pagado' WHEN 16000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 366)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 16000000,
    estado = CASE WHEN 16000000 >= monto_proyectado THEN 'pagado' WHEN 16000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 366)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 16000000,
    estado = CASE WHEN 16000000 >= monto_proyectado THEN 'pagado' WHEN 16000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 366)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 16000000,
    estado = CASE WHEN 16000000 >= monto_proyectado THEN 'pagado' WHEN 16000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 366)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 16000000,
    estado = CASE WHEN 16000000 >= monto_proyectado THEN 'pagado' WHEN 16000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 366)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 744)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 744)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 744)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 744)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 103)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 103)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 103)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 8000000,
    estado = CASE WHEN 8000000 >= monto_proyectado THEN 'pagado' WHEN 8000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 103)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 8000000,
    estado = CASE WHEN 8000000 >= monto_proyectado THEN 'pagado' WHEN 8000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 103)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 50000000,
    estado = CASE WHEN 50000000 >= monto_proyectado THEN 'pagado' WHEN 50000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 168)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 50000000,
    estado = CASE WHEN 50000000 >= monto_proyectado THEN 'pagado' WHEN 50000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 168)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 127)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 127)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 127)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 73)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 73)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 32000000,
    estado = CASE WHEN 32000000 >= monto_proyectado THEN 'pagado' WHEN 32000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 822)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 12000000,
    estado = CASE WHEN 12000000 >= monto_proyectado THEN 'pagado' WHEN 12000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 822)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 12000000,
    estado = CASE WHEN 12000000 >= monto_proyectado THEN 'pagado' WHEN 12000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 822)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 12000000,
    estado = CASE WHEN 12000000 >= monto_proyectado THEN 'pagado' WHEN 12000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 822)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 12000000,
    estado = CASE WHEN 12000000 >= monto_proyectado THEN 'pagado' WHEN 12000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 822)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 12000000,
    estado = CASE WHEN 12000000 >= monto_proyectado THEN 'pagado' WHEN 12000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 822)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 12000000,
    estado = CASE WHEN 12000000 >= monto_proyectado THEN 'pagado' WHEN 12000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 822)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 169)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 216)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 35000000,
    estado = CASE WHEN 35000000 >= monto_proyectado THEN 'pagado' WHEN 35000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 216)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 59)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 42000000,
    estado = CASE WHEN 42000000 >= monto_proyectado THEN 'pagado' WHEN 42000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 59)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 42000000,
    estado = CASE WHEN 42000000 >= monto_proyectado THEN 'pagado' WHEN 42000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 59)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 111)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 55800000,
    estado = CASE WHEN 55800000 >= monto_proyectado THEN 'pagado' WHEN 55800000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 111)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 18600000,
    estado = CASE WHEN 18600000 >= monto_proyectado THEN 'pagado' WHEN 18600000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 111)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 275)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 197)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 45000000,
    estado = CASE WHEN 45000000 >= monto_proyectado THEN 'pagado' WHEN 45000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 197)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 266)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 266)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 98)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 95)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 95)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 95)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 95)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 95)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 779)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 2100000,
    estado = CASE WHEN 2100000 >= monto_proyectado THEN 'pagado' WHEN 2100000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 779)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 2900000,
    estado = CASE WHEN 2900000 >= monto_proyectado THEN 'pagado' WHEN 2900000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 779)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 779)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 25000000,
    estado = CASE WHEN 25000000 >= monto_proyectado THEN 'pagado' WHEN 25000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 172)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 178)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 329)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 188)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 25000000,
    estado = CASE WHEN 25000000 >= monto_proyectado THEN 'pagado' WHEN 25000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 188)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 23000000,
    estado = CASE WHEN 23000000 >= monto_proyectado THEN 'pagado' WHEN 23000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 188)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 188)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 14425000,
    estado = CASE WHEN 14425000 >= monto_proyectado THEN 'pagado' WHEN 14425000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 129)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 25000000,
    estado = CASE WHEN 25000000 >= monto_proyectado THEN 'pagado' WHEN 25000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 129)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 129)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 129)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 294)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 294)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 339)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 339)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 60000000,
    estado = CASE WHEN 60000000 >= monto_proyectado THEN 'pagado' WHEN 60000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 339)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 25000000,
    estado = CASE WHEN 25000000 >= monto_proyectado THEN 'pagado' WHEN 25000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 339)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 24750000,
    estado = CASE WHEN 24750000 >= monto_proyectado THEN 'pagado' WHEN 24750000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 324)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 24750000,
    estado = CASE WHEN 24750000 >= monto_proyectado THEN 'pagado' WHEN 24750000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 323)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 46000000,
    estado = CASE WHEN 46000000 >= monto_proyectado THEN 'pagado' WHEN 46000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 34)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 26000000,
    estado = CASE WHEN 26000000 >= monto_proyectado THEN 'pagado' WHEN 26000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 34)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 26000000,
    estado = CASE WHEN 26000000 >= monto_proyectado THEN 'pagado' WHEN 26000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 34)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 563)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 563)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 563)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 563)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 563)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 18000000,
    estado = CASE WHEN 18000000 >= monto_proyectado THEN 'pagado' WHEN 18000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 563)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 57)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 57)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 57)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 57)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 555)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 166)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 166)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 50000000,
    estado = CASE WHEN 50000000 >= monto_proyectado THEN 'pagado' WHEN 50000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 319)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 39000000,
    estado = CASE WHEN 39000000 >= monto_proyectado THEN 'pagado' WHEN 39000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 319)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 585)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 34031250,
    estado = CASE WHEN 34031250 >= monto_proyectado THEN 'pagado' WHEN 34031250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 125)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 25000000,
    estado = CASE WHEN 25000000 >= monto_proyectado THEN 'pagado' WHEN 25000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 508)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 508)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 5000000,
    estado = CASE WHEN 5000000 >= monto_proyectado THEN 'pagado' WHEN 5000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 508)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 145)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 32000000,
    estado = CASE WHEN 32000000 >= monto_proyectado THEN 'pagado' WHEN 32000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 145)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 22000000,
    estado = CASE WHEN 22000000 >= monto_proyectado THEN 'pagado' WHEN 22000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 145)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 32000000,
    estado = CASE WHEN 32000000 >= monto_proyectado THEN 'pagado' WHEN 32000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 145)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 23500000,
    estado = CASE WHEN 23500000 >= monto_proyectado THEN 'pagado' WHEN 23500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 145)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 25701433,
    estado = CASE WHEN 25701433 >= monto_proyectado THEN 'pagado' WHEN 25701433 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 145)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 16149283,
    estado = CASE WHEN 16149283 >= monto_proyectado THEN 'pagado' WHEN 16149283 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 145)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 612)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 612)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 7500000,
    estado = CASE WHEN 7500000 >= monto_proyectado THEN 'pagado' WHEN 7500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 612)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 7500000,
    estado = CASE WHEN 7500000 >= monto_proyectado THEN 'pagado' WHEN 7500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 612)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 7500000,
    estado = CASE WHEN 7500000 >= monto_proyectado THEN 'pagado' WHEN 7500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 612)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 33000000,
    estado = CASE WHEN 33000000 >= monto_proyectado THEN 'pagado' WHEN 33000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 225)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 225)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 225)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 225)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 225)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 225)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 160)
  AND periodo = '2025-10';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 160)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 9142500,
    estado = CASE WHEN 9142500 >= monto_proyectado THEN 'pagado' WHEN 9142500 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 160)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 160)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 160)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 16500000,
    estado = CASE WHEN 16500000 >= monto_proyectado THEN 'pagado' WHEN 16500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 160)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 8250000,
    estado = CASE WHEN 8250000 >= monto_proyectado THEN 'pagado' WHEN 8250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 160)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 184)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 33333333,
    estado = CASE WHEN 33333333 >= monto_proyectado THEN 'pagado' WHEN 33333333 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 184)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 54666667,
    estado = CASE WHEN 54666667 >= monto_proyectado THEN 'pagado' WHEN 54666667 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 184)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 288)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 288)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 288)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 120)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 21000000,
    estado = CASE WHEN 21000000 >= monto_proyectado THEN 'pagado' WHEN 21000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 100)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 6000000,
    estado = CASE WHEN 6000000 >= monto_proyectado THEN 'pagado' WHEN 6000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 100)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 100)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 5614836,
    estado = CASE WHEN 5614836 >= monto_proyectado THEN 'pagado' WHEN 5614836 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 562)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 5614836,
    estado = CASE WHEN 5614836 >= monto_proyectado THEN 'pagado' WHEN 5614836 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 562)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 5614836,
    estado = CASE WHEN 5614836 >= monto_proyectado THEN 'pagado' WHEN 5614836 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 562)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 24000000,
    estado = CASE WHEN 24000000 >= monto_proyectado THEN 'pagado' WHEN 24000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 296)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 296)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 296)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 296)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 38000000,
    estado = CASE WHEN 38000000 >= monto_proyectado THEN 'pagado' WHEN 38000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 74)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 18000000,
    estado = CASE WHEN 18000000 >= monto_proyectado THEN 'pagado' WHEN 18000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 74)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 24000000,
    estado = CASE WHEN 24000000 >= monto_proyectado THEN 'pagado' WHEN 24000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 230)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 230)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 9000000,
    estado = CASE WHEN 9000000 >= monto_proyectado THEN 'pagado' WHEN 9000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 230)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 15000000,
    estado = CASE WHEN 15000000 >= monto_proyectado THEN 'pagado' WHEN 15000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 273)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 15000000,
    estado = CASE WHEN 15000000 >= monto_proyectado THEN 'pagado' WHEN 15000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 273)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 273)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 8)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 24750000,
    estado = CASE WHEN 24750000 >= monto_proyectado THEN 'pagado' WHEN 24750000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 135)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 18562500,
    estado = CASE WHEN 18562500 >= monto_proyectado THEN 'pagado' WHEN 18562500 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 135)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 258)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 21000000,
    estado = CASE WHEN 21000000 >= monto_proyectado THEN 'pagado' WHEN 21000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 258)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 66000000,
    estado = CASE WHEN 66000000 >= monto_proyectado THEN 'pagado' WHEN 66000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 823)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 50000000,
    estado = CASE WHEN 50000000 >= monto_proyectado THEN 'pagado' WHEN 50000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 502)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 161)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 161)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 34031250,
    estado = CASE WHEN 34031250 >= monto_proyectado THEN 'pagado' WHEN 34031250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 218)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 9281250,
    estado = CASE WHEN 9281250 >= monto_proyectado THEN 'pagado' WHEN 9281250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 218)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 9281250,
    estado = CASE WHEN 9281250 >= monto_proyectado THEN 'pagado' WHEN 9281250 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 218)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 18750000,
    estado = CASE WHEN 18750000 >= monto_proyectado THEN 'pagado' WHEN 18750000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 240)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 18750000,
    estado = CASE WHEN 18750000 >= monto_proyectado THEN 'pagado' WHEN 18750000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 240)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 18750000,
    estado = CASE WHEN 18750000 >= monto_proyectado THEN 'pagado' WHEN 18750000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 240)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 12500000,
    estado = CASE WHEN 12500000 >= monto_proyectado THEN 'pagado' WHEN 12500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 285)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 12450000,
    estado = CASE WHEN 12450000 >= monto_proyectado THEN 'pagado' WHEN 12450000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 285)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 12500000,
    estado = CASE WHEN 12500000 >= monto_proyectado THEN 'pagado' WHEN 12500000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 285)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 80000000,
    estado = CASE WHEN 80000000 >= monto_proyectado THEN 'pagado' WHEN 80000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 33)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 344)
  AND periodo = '2025-11';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 344)
  AND periodo = '2025-12';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 344)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 10000000,
    estado = CASE WHEN 10000000 >= monto_proyectado THEN 'pagado' WHEN 10000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 344)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 134)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 11000000,
    estado = CASE WHEN 11000000 >= monto_proyectado THEN 'pagado' WHEN 11000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 134)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 11000000,
    estado = CASE WHEN 11000000 >= monto_proyectado THEN 'pagado' WHEN 11000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 134)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 11000000,
    estado = CASE WHEN 11000000 >= monto_proyectado THEN 'pagado' WHEN 11000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 134)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 3260870,
    estado = CASE WHEN 3260870 >= monto_proyectado THEN 'pagado' WHEN 3260870 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 267)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 3260870,
    estado = CASE WHEN 3260870 >= monto_proyectado THEN 'pagado' WHEN 3260870 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 267)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 3260870,
    estado = CASE WHEN 3260870 >= monto_proyectado THEN 'pagado' WHEN 3260870 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 267)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 3260870,
    estado = CASE WHEN 3260870 >= monto_proyectado THEN 'pagado' WHEN 3260870 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 23)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 3260870,
    estado = CASE WHEN 3260870 >= monto_proyectado THEN 'pagado' WHEN 3260870 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 23)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 3260870,
    estado = CASE WHEN 3260870 >= monto_proyectado THEN 'pagado' WHEN 3260870 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 23)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20000000,
    estado = CASE WHEN 20000000 >= monto_proyectado THEN 'pagado' WHEN 20000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 276)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 24750000,
    estado = CASE WHEN 24750000 >= monto_proyectado THEN 'pagado' WHEN 24750000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 72)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 838)
  AND periodo = '2026-03';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 838)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 24750000,
    estado = CASE WHEN 24750000 >= monto_proyectado THEN 'pagado' WHEN 24750000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 399)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 20250000,
    estado = CASE WHEN 20250000 >= monto_proyectado THEN 'pagado' WHEN 20250000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 399)
  AND periodo = '2026-05';
UPDATE planes_pago
SET monto_pagado = 30000000,
    estado = CASE WHEN 30000000 >= monto_proyectado THEN 'pagado' WHEN 30000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 62)
  AND periodo = '2026-01';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 62)
  AND periodo = '2026-02';
UPDATE planes_pago
SET monto_pagado = 40000000,
    estado = CASE WHEN 40000000 >= monto_proyectado THEN 'pagado' WHEN 40000000 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 62)
  AND periodo = '2026-04';
UPDATE planes_pago
SET monto_pagado = 5614836,
    estado = CASE WHEN 5614836 >= monto_proyectado THEN 'pagado' WHEN 5614836 > 0 THEN 'parcial' ELSE estado END
WHERE socio_id = (SELECT id FROM socios WHERE certificado_no = 311)
  AND periodo = '2026-05';
COMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS actualizados FROM planes_pago WHERE monto_pagado > 0;
