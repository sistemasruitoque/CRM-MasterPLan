-- Recaudo MP: actual payments collected Oct-25 to May-26
-- 119 partners, 111 with data
-- Total recaudo: $6,603,440,280

BEGIN;

-- Clear any previously imported recaudo records (idempotent)
DELETE FROM pagos WHERE concepto LIKE 'Recaudo%';

INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 259), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 259), 4500000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 259), 9000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 259), 4500000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 773), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 773), 38000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 773), 38000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 80), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 80), 10000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 92), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 92), 27500000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 40), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 40), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 40), 5000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 40), 5000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 40), 10000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 245), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 245), 40000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 245), 40000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 245), 10937500, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 245), 48832500, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 245), 5855000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 777), 38000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 777), 42000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 302), 30000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 302), 10000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 302), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 302), 10000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 302), 20000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 112), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 112), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 112), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 112), 20000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 112), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 112), 20000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 112), 20000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 112), 20000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 159), 30000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 159), 8250000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 159), 9142500, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 159), 8250000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 159), 8250000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 159), 16500000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 159), 8250000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 365), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 365), 20000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 365), 7000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 45), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 143), 20005000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 143), 10000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 143), 10000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 143), 10000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 143), 10000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 143), 10000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 37), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 37), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 192), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 192), 5000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 192), 5000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 192), 10000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 192), 8320000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 192), 11000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 192), 3830000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 32), 15000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 32), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 70), 10000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 70), 10000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 70), 10000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 70), 20000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 70), 10000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 249), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 249), 10800000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 249), 10800000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 249), 10800000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 249), 10800000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 249), 10800000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 249), 10800000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 249), 10800000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 56), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 56), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 56), 10000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 56), 10000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 56), 70000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 56), 10000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 47), 40000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 47), 40000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 47), 40000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 83), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 83), 4500000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 83), 13500000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 203), 10000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 321), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 202), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 202), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 202), 20000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 202), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 202), 20000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 202), 20000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 723), 10000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 723), 10000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 723), 4000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 723), 16000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 723), 1000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 61), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 689), 25000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 689), 30000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 575), 45000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 610), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 610), 24000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 610), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 610), 40000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 610), 20000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 610), 15000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 163), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 163), 35000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 306), 34031250, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 306), 9281250, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 306), 9281250, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 306), 9281250, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 306), 9281250, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 306), 9281250, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 297), 24750000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 297), 11000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 297), 5500000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 297), 5500000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 297), 5500000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 297), 5500000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 309), 42000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 309), 16500000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 309), 8250000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 309), 8250000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 309), 8250000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 309), 8250000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 142), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 142), 20000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 142), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 142), 20000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 142), 20000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 142), 10000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 71), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 71), 21000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 71), 9000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 71), 50000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 71), 30000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 242), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 242), 25000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 341), 10000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 341), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 341), 5625000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 341), 11250000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 341), 5625000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 621), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 621), 10000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 621), 7500000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 621), 7500000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 621), 7500000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 21), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 21), 10000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 21), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 21), 1000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 21), 1000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 21), 1000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 222), 45000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 167), 40000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 167), 40000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 167), 30000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 427), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 427), 25000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 427), 25000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 90), 10000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 366), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 366), 16000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 366), 16000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 366), 16000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 366), 16000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 366), 16000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 744), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 744), 9000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 744), 9000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 744), 9000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 103), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 103), 5000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 103), 10000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 103), 8000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 103), 8000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 168), 50000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 168), 50000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 127), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 127), 20000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 127), 20000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 73), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 73), 20000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 822), 32000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 822), 12000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 822), 12000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 822), 12000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 822), 12000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 822), 12000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 822), 12000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 169), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 216), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 216), 35000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 59), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 59), 42000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 59), 42000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 111), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 111), 55800000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 111), 18600000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 275), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 197), 30000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 197), 45000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 266), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 266), 10000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 98), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 95), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 95), 40000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 95), 10000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 95), 10000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 95), 10000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 779), 10000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 779), 2100000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 779), 2900000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 779), 5000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 172), 25000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 178), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 329), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 188), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 188), 25000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 188), 23000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 188), 5000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 129), 14425000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 129), 25000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 129), 10000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 129), 10000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 294), 10000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 294), 10000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 339), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 339), 30000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 339), 60000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 339), 25000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 324), 24750000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 323), 24750000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 34), 46000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 34), 26000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 34), 26000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 563), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 563), 10000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 563), 10000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 563), 10000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 563), 10000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 563), 18000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 57), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 57), 10000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 57), 10000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 57), 5000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 555), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 166), 10000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 166), 10000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 319), 50000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 319), 39000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 585), 30000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 125), 34031250, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 508), 25000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 508), 5000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 508), 5000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 145), 20000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 145), 32000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 145), 22000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 145), 32000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 145), 23500000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 145), 25701433, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 145), 16149283, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 612), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 612), 10000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 612), 7500000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 612), 7500000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 612), 7500000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 225), 33000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 225), 9000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 225), 9000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 225), 9000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 225), 9000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 225), 9000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 160), 30000000, '2025-10-31', 'cuota', 'Recaudo 2025-10');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 160), 8250000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 160), 9142500, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 160), 8250000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 160), 8250000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 160), 16500000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 160), 8250000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 184), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 184), 33333333, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 184), 54666667, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 288), 20000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 288), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 288), 20000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 120), 10000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 100), 21000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 100), 6000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 100), 9000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 562), 5614836, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 562), 5614836, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 562), 5614836, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 296), 24000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 296), 9000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 296), 9000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 296), 9000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 74), 38000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 74), 18000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 230), 24000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 230), 9000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 230), 9000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 273), 15000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 273), 15000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 273), 30000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 8), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 135), 24750000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 135), 18562500, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 258), 40000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 258), 21000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 823), 66000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 502), 50000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 161), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 161), 10000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 218), 34031250, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 218), 9281250, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 218), 9281250, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 240), 18750000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 240), 18750000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 240), 18750000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 285), 12500000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 285), 12450000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 285), 12500000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 33), 80000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 344), 20000000, '2025-11-30', 'cuota', 'Recaudo 2025-11');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 344), 10000000, '2025-12-31', 'cuota', 'Recaudo 2025-12');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 344), 20000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 344), 10000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 134), 20000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 134), 11000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 134), 11000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 134), 11000000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 267), 3260870, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 267), 3260870, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 267), 3260870, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 23), 3260870, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 23), 3260870, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 23), 3260870, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 276), 20000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 72), 24750000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 838), 30000000, '2026-03-31', 'cuota', 'Recaudo 2026-03');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 838), 30000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 399), 24750000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 399), 20250000, '2026-05-31', 'cuota', 'Recaudo 2026-05');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 62), 30000000, '2026-01-31', 'cuota', 'Recaudo 2026-01');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 62), 40000000, '2026-02-28', 'cuota', 'Recaudo 2026-02');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 62), 40000000, '2026-04-30', 'cuota', 'Recaudo 2026-04');
INSERT INTO pagos (socio_id, monto, fecha_pago, tipo, concepto) VALUES
  ((SELECT id FROM socios WHERE certificado_no = 311), 5614836, '2026-05-31', 'cuota', 'Recaudo 2026-05');
COMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS pagos, SUM(monto) AS total FROM pagos WHERE concepto LIKE 'Recaudo%';
