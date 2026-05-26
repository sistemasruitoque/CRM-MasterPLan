-- Planes de pago pactados desde pago_pactado.prn
-- 2026-05-26T21:06:42.968Z
-- 119 partners, 951 rows, total: 12,859,974,256

BEGIN;

DELETE FROM planes_pago;

-- 259: 11 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 4500000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-01', 4500000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-02', 4500000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-03', 4500000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-04', 4000000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-05', 55000000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-06', 4500000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-07', 4500000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-08', 4500000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-09', 4500000, (SELECT id FROM socios WHERE certificado_no = 259)),
  ('2026-10', 35000000, (SELECT id FROM socios WHERE certificado_no = 259));

-- 773: 5 cuotas, total 111,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 19000000, (SELECT id FROM socios WHERE certificado_no = 773)),
  ('2026-01', 19000000, (SELECT id FROM socios WHERE certificado_no = 773)),
  ('2026-02', 19000000, (SELECT id FROM socios WHERE certificado_no = 773)),
  ('2026-03', 19000000, (SELECT id FROM socios WHERE certificado_no = 773)),
  ('2026-04', 35000000, (SELECT id FROM socios WHERE certificado_no = 773));

-- 80: 3 cuotas, total 50,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 5000000, (SELECT id FROM socios WHERE certificado_no = 80)),
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 80)),
  ('2026-02', 25000000, (SELECT id FROM socios WHERE certificado_no = 80));

-- 92: 3 cuotas, total 41,250,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 13750000, (SELECT id FROM socios WHERE certificado_no = 92)),
  ('2026-01', 13750000, (SELECT id FROM socios WHERE certificado_no = 92)),
  ('2026-02', 13750000, (SELECT id FROM socios WHERE certificado_no = 92));

-- 40: 4 cuotas, total 110,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 5000000, (SELECT id FROM socios WHERE certificado_no = 40)),
  ('2026-02', 5000000, (SELECT id FROM socios WHERE certificado_no = 40)),
  ('2026-04', 30000000, (SELECT id FROM socios WHERE certificado_no = 40)),
  ('2026-06', 70000000, (SELECT id FROM socios WHERE certificado_no = 40));

-- 245: 9 cuotas, total 127,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 40000000, (SELECT id FROM socios WHERE certificado_no = 245)),
  ('2026-02', 10937500, (SELECT id FROM socios WHERE certificado_no = 245)),
  ('2026-03', 10937500, (SELECT id FROM socios WHERE certificado_no = 245)),
  ('2026-04', 10937500, (SELECT id FROM socios WHERE certificado_no = 245)),
  ('2026-05', 10937500, (SELECT id FROM socios WHERE certificado_no = 245)),
  ('2026-06', 10937500, (SELECT id FROM socios WHERE certificado_no = 245)),
  ('2026-07', 10937500, (SELECT id FROM socios WHERE certificado_no = 245)),
  ('2026-08', 10937500, (SELECT id FROM socios WHERE certificado_no = 245)),
  ('2026-09', 10937500, (SELECT id FROM socios WHERE certificado_no = 245));

-- 777: 9 cuotas, total 112,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 32000000, (SELECT id FROM socios WHERE certificado_no = 777)),
  ('2026-03', 10000000, (SELECT id FROM socios WHERE certificado_no = 777)),
  ('2026-04', 10000000, (SELECT id FROM socios WHERE certificado_no = 777)),
  ('2026-05', 10000000, (SELECT id FROM socios WHERE certificado_no = 777)),
  ('2026-06', 10000000, (SELECT id FROM socios WHERE certificado_no = 777)),
  ('2026-07', 10000000, (SELECT id FROM socios WHERE certificado_no = 777)),
  ('2026-08', 10000000, (SELECT id FROM socios WHERE certificado_no = 777)),
  ('2026-09', 10000000, (SELECT id FROM socios WHERE certificado_no = 777)),
  ('2026-10', 10000000, (SELECT id FROM socios WHERE certificado_no = 777));

-- 302: 11 cuotas, total 120,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-01', 10000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-02', 10000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-03', 10000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-04', 10000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-05', 10000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-06', 10000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-07', 10000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-08', 10000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-09', 15000000, (SELECT id FROM socios WHERE certificado_no = 302)),
  ('2026-10', 15000000, (SELECT id FROM socios WHERE certificado_no = 302));

-- 112: 7 cuotas, total 147,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 112)),
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 112)),
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 112)),
  ('2026-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 112)),
  ('2026-04', 20000000, (SELECT id FROM socios WHERE certificado_no = 112)),
  ('2026-05', 20000000, (SELECT id FROM socios WHERE certificado_no = 112)),
  ('2026-06', 27500000, (SELECT id FROM socios WHERE certificado_no = 112));

-- 159: 9 cuotas, total 74,250,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 8250000, (SELECT id FROM socios WHERE certificado_no = 159)),
  ('2026-01', 8250000, (SELECT id FROM socios WHERE certificado_no = 159)),
  ('2026-02', 8250000, (SELECT id FROM socios WHERE certificado_no = 159)),
  ('2026-03', 8250000, (SELECT id FROM socios WHERE certificado_no = 159)),
  ('2026-04', 8250000, (SELECT id FROM socios WHERE certificado_no = 159)),
  ('2026-05', 8250000, (SELECT id FROM socios WHERE certificado_no = 159)),
  ('2026-06', 8250000, (SELECT id FROM socios WHERE certificado_no = 159)),
  ('2026-07', 8250000, (SELECT id FROM socios WHERE certificado_no = 159)),
  ('2026-08', 8250000, (SELECT id FROM socios WHERE certificado_no = 159));

-- 365: 1 cuotas, total 22,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 22500000, (SELECT id FROM socios WHERE certificado_no = 365));

-- 45: 1 cuotas, total 30,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 45));

-- 143: 3 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 15000000, (SELECT id FROM socios WHERE certificado_no = 143)),
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 143)),
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 143));

-- 37: 6 cuotas, total 167,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 40000000, (SELECT id FROM socios WHERE certificado_no = 37)),
  ('2026-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 37)),
  ('2026-04', 20000000, (SELECT id FROM socios WHERE certificado_no = 37)),
  ('2026-05', 20000000, (SELECT id FROM socios WHERE certificado_no = 37)),
  ('2026-06', 20000000, (SELECT id FROM socios WHERE certificado_no = 37)),
  ('2026-07', 47500000, (SELECT id FROM socios WHERE certificado_no = 37));

-- 192: 13 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 5000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-01', 5000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-02', 10000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-03', 11000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-04', 11000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-05', 11000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-06', 11000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-07', 11000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-08', 11000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-09', 11000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-10', 11000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-11', 11000000, (SELECT id FROM socios WHERE certificado_no = 192)),
  ('2026-12', 11000000, (SELECT id FROM socios WHERE certificado_no = 192));

-- 32: 2 cuotas, total 60,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 32)),
  ('2026-07', 40000000, (SELECT id FROM socios WHERE certificado_no = 32));

-- 70: 5 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 70)),
  ('2026-01', 10000000, (SELECT id FROM socios WHERE certificado_no = 70)),
  ('2026-02', 10000000, (SELECT id FROM socios WHERE certificado_no = 70)),
  ('2026-03', 10000000, (SELECT id FROM socios WHERE certificado_no = 70)),
  ('2026-04', 15000000, (SELECT id FROM socios WHERE certificado_no = 70));

-- 249: 11 cuotas, total 119,200,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-01', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-02', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-03', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-04', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-05', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-06', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-07', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-08', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-09', 10800000, (SELECT id FROM socios WHERE certificado_no = 249)),
  ('2026-10', 11200000, (SELECT id FROM socios WHERE certificado_no = 249));

-- 56: 4 cuotas, total 110,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 56)),
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 56)),
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 56)),
  ('2026-03', 50000000, (SELECT id FROM socios WHERE certificado_no = 56));

-- 47: 3 cuotas, total 100,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 47)),
  ('2026-01', 30000000, (SELECT id FROM socios WHERE certificado_no = 47)),
  ('2026-02', 40000000, (SELECT id FROM socios WHERE certificado_no = 47));

-- 83: 12 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-01', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-02', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-03', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-04', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-05', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-06', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-07', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-08', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-09', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-10', 4500000, (SELECT id FROM socios WHERE certificado_no = 83)),
  ('2026-11', 5500000, (SELECT id FROM socios WHERE certificado_no = 83));

-- 203: 5 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 203)),
  ('2026-01', 10000000, (SELECT id FROM socios WHERE certificado_no = 203)),
  ('2026-02', 10000000, (SELECT id FROM socios WHERE certificado_no = 203)),
  ('2026-03', 10000000, (SELECT id FROM socios WHERE certificado_no = 203)),
  ('2026-04', 15000000, (SELECT id FROM socios WHERE certificado_no = 203));

-- 321: 2 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 321)),
  ('2026-01', 35000000, (SELECT id FROM socios WHERE certificado_no = 321));

-- 202: 6 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 202)),
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 202)),
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 202)),
  ('2026-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 202)),
  ('2026-04', 20000000, (SELECT id FROM socios WHERE certificado_no = 202)),
  ('2026-05', 30000000, (SELECT id FROM socios WHERE certificado_no = 202));

-- 723: 1 cuotas, total 30,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 723));

-- 61: 10 cuotas, total 92,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 8000000, (SELECT id FROM socios WHERE certificado_no = 61)),
  ('2026-01', 8000000, (SELECT id FROM socios WHERE certificado_no = 61)),
  ('2026-02', 8000000, (SELECT id FROM socios WHERE certificado_no = 61)),
  ('2026-03', 8000000, (SELECT id FROM socios WHERE certificado_no = 61)),
  ('2026-04', 8000000, (SELECT id FROM socios WHERE certificado_no = 61)),
  ('2026-05', 8000000, (SELECT id FROM socios WHERE certificado_no = 61)),
  ('2026-06', 8000000, (SELECT id FROM socios WHERE certificado_no = 61)),
  ('2026-07', 8000000, (SELECT id FROM socios WHERE certificado_no = 61)),
  ('2026-08', 8000000, (SELECT id FROM socios WHERE certificado_no = 61)),
  ('2026-09', 20000000, (SELECT id FROM socios WHERE certificado_no = 61));

-- 689: 1 cuotas, total 50,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-03', 50000000, (SELECT id FROM socios WHERE certificado_no = 689));

-- 575: 1 cuotas, total 30,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 575));

-- 610: 5 cuotas, total 110,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 22000000, (SELECT id FROM socios WHERE certificado_no = 610)),
  ('2026-01', 22000000, (SELECT id FROM socios WHERE certificado_no = 610)),
  ('2026-02', 22000000, (SELECT id FROM socios WHERE certificado_no = 610)),
  ('2026-03', 22000000, (SELECT id FROM socios WHERE certificado_no = 610)),
  ('2026-04', 22000000, (SELECT id FROM socios WHERE certificado_no = 610));

-- 163: 2 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-04', 35000000, (SELECT id FROM socios WHERE certificado_no = 163)),
  ('2026-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 163));

-- 306: 24 cuotas, total 222,750,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2026-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 306)),
  ('2027-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 306));

-- 297: 24 cuotas, total 222,750,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-01', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-02', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-03', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-04', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-05', 50000000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-06', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-07', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-08', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-09', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-10', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-11', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2026-12', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-01', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-02', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-03', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-04', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-05', 50000000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-06', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-07', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-08', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-09', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-10', 5500000, (SELECT id FROM socios WHERE certificado_no = 297)),
  ('2027-11', 7250000, (SELECT id FROM socios WHERE certificado_no = 297));

-- 309: 23 cuotas, total 198,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 16500000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-02', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-03', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-04', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-05', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-06', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-07', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-08', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-09', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-10', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-11', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2026-12', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-01', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-02', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-03', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-04', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-05', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-06', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-07', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-08', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-09', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-10', 8250000, (SELECT id FROM socios WHERE certificado_no = 309)),
  ('2027-11', 8250000, (SELECT id FROM socios WHERE certificado_no = 309));

-- 142: 6 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 142)),
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 142)),
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 142)),
  ('2026-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 142)),
  ('2026-04', 20000000, (SELECT id FROM socios WHERE certificado_no = 142)),
  ('2026-05', 30000000, (SELECT id FROM socios WHERE certificado_no = 142));

-- 71: 5 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 12000000, (SELECT id FROM socios WHERE certificado_no = 71)),
  ('2026-01', 9000000, (SELECT id FROM socios WHERE certificado_no = 71)),
  ('2026-02', 9000000, (SELECT id FROM socios WHERE certificado_no = 71)),
  ('2026-03', 50000000, (SELECT id FROM socios WHERE certificado_no = 71)),
  ('2026-04', 50000000, (SELECT id FROM socios WHERE certificado_no = 71));

-- 242: 1 cuotas, total 30,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 242));

-- 341: 8 cuotas, total 45,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 5625000, (SELECT id FROM socios WHERE certificado_no = 341)),
  ('2026-03', 5625000, (SELECT id FROM socios WHERE certificado_no = 341)),
  ('2026-04', 5625000, (SELECT id FROM socios WHERE certificado_no = 341)),
  ('2026-05', 5625000, (SELECT id FROM socios WHERE certificado_no = 341)),
  ('2026-06', 5625000, (SELECT id FROM socios WHERE certificado_no = 341)),
  ('2026-07', 5625000, (SELECT id FROM socios WHERE certificado_no = 341)),
  ('2026-08', 5625000, (SELECT id FROM socios WHERE certificado_no = 341)),
  ('2026-09', 5625000, (SELECT id FROM socios WHERE certificado_no = 341));

-- 621: 7 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 10000000, (SELECT id FROM socios WHERE certificado_no = 621)),
  ('2026-02', 7500000, (SELECT id FROM socios WHERE certificado_no = 621)),
  ('2026-03', 7500000, (SELECT id FROM socios WHERE certificado_no = 621)),
  ('2026-04', 7500000, (SELECT id FROM socios WHERE certificado_no = 621)),
  ('2026-05', 7500000, (SELECT id FROM socios WHERE certificado_no = 621)),
  ('2026-06', 7500000, (SELECT id FROM socios WHERE certificado_no = 621)),
  ('2026-07', 7500000, (SELECT id FROM socios WHERE certificado_no = 621));

-- 21: 24 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-03', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-04', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-05', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-06', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-07', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-08', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-09', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-10', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-11', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2026-12', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-01', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-02', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-03', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-04', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-05', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-06', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-07', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-08', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-09', 1000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-10', 2000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-11', 2000000, (SELECT id FROM socios WHERE certificado_no = 21)),
  ('2027-12', 2000000, (SELECT id FROM socios WHERE certificado_no = 21));

-- 222: 1 cuotas, total 30,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 222));

-- 167: 2 cuotas, total 110,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 60000000, (SELECT id FROM socios WHERE certificado_no = 167)),
  ('2026-06', 50000000, (SELECT id FROM socios WHERE certificado_no = 167));

-- 427: 3 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 25000000, (SELECT id FROM socios WHERE certificado_no = 427)),
  ('2026-01', 25000000, (SELECT id FROM socios WHERE certificado_no = 427)),
  ('2026-02', 25000000, (SELECT id FROM socios WHERE certificado_no = 427));

-- 90: 3 cuotas, total 65,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 90)),
  ('2026-07', 20000000, (SELECT id FROM socios WHERE certificado_no = 90)),
  ('2026-11', 25000000, (SELECT id FROM socios WHERE certificado_no = 90));

-- 366: 6 cuotas, total 92,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 16000000, (SELECT id FROM socios WHERE certificado_no = 366)),
  ('2026-02', 16000000, (SELECT id FROM socios WHERE certificado_no = 366)),
  ('2026-03', 16000000, (SELECT id FROM socios WHERE certificado_no = 366)),
  ('2026-04', 16000000, (SELECT id FROM socios WHERE certificado_no = 366)),
  ('2026-05', 16000000, (SELECT id FROM socios WHERE certificado_no = 366)),
  ('2026-06', 12500000, (SELECT id FROM socios WHERE certificado_no = 366));

-- 744: 11 cuotas, total 122,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 9000000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-01', 9000000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-02', 9000000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-03', 9000000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-04', 9000000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-05', 9000000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-06', 9000000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-07', 9000000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-08', 19300000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-09', 19300000, (SELECT id FROM socios WHERE certificado_no = 744)),
  ('2026-10', 11900000, (SELECT id FROM socios WHERE certificado_no = 744));

-- 103: 12 cuotas, total 100,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 5000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-02', 10000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-03', 8000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-04', 8000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-05', 8000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-06', 8000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-07', 8000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-08', 8000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-09', 8000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-10', 8000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-11', 8000000, (SELECT id FROM socios WHERE certificado_no = 103)),
  ('2026-12', 13000000, (SELECT id FROM socios WHERE certificado_no = 103));

-- 168: 5 cuotas, total 150,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 50000000, (SELECT id FROM socios WHERE certificado_no = 168)),
  ('2026-03', 25000000, (SELECT id FROM socios WHERE certificado_no = 168)),
  ('2026-04', 25000000, (SELECT id FROM socios WHERE certificado_no = 168)),
  ('2026-05', 25000000, (SELECT id FROM socios WHERE certificado_no = 168)),
  ('2026-06', 25000000, (SELECT id FROM socios WHERE certificado_no = 168));

-- 127: 3 cuotas, total 167,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 127)),
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 127)),
  ('2026-02', 127500000, (SELECT id FROM socios WHERE certificado_no = 127));

-- 73: 2 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 73)),
  ('2026-03', 35000000, (SELECT id FROM socios WHERE certificado_no = 73));

-- 822: 10 cuotas, total 118,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 12000000, (SELECT id FROM socios WHERE certificado_no = 822)),
  ('2026-01', 12000000, (SELECT id FROM socios WHERE certificado_no = 822)),
  ('2026-02', 12000000, (SELECT id FROM socios WHERE certificado_no = 822)),
  ('2026-03', 12000000, (SELECT id FROM socios WHERE certificado_no = 822)),
  ('2026-04', 12000000, (SELECT id FROM socios WHERE certificado_no = 822)),
  ('2026-05', 12000000, (SELECT id FROM socios WHERE certificado_no = 822)),
  ('2026-06', 12000000, (SELECT id FROM socios WHERE certificado_no = 822)),
  ('2026-07', 12000000, (SELECT id FROM socios WHERE certificado_no = 822)),
  ('2026-08', 11000000, (SELECT id FROM socios WHERE certificado_no = 822)),
  ('2026-09', 11000000, (SELECT id FROM socios WHERE certificado_no = 822));

-- 169: 7 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 169)),
  ('2026-01', 27000000, (SELECT id FROM socios WHERE certificado_no = 169)),
  ('2026-02', 18500000, (SELECT id FROM socios WHERE certificado_no = 169)),
  ('2026-03', 18500000, (SELECT id FROM socios WHERE certificado_no = 169)),
  ('2026-04', 18500000, (SELECT id FROM socios WHERE certificado_no = 169)),
  ('2026-05', 18500000, (SELECT id FROM socios WHERE certificado_no = 169)),
  ('2026-06', 19000000, (SELECT id FROM socios WHERE certificado_no = 169));

-- 216: 1 cuotas, total 30,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 216));

-- 59: 3 cuotas, total 103,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 42000000, (SELECT id FROM socios WHERE certificado_no = 59)),
  ('2026-01', 42000000, (SELECT id FROM socios WHERE certificado_no = 59)),
  ('2026-02', 19000000, (SELECT id FROM socios WHERE certificado_no = 59));

-- 111: 7 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 18600000, (SELECT id FROM socios WHERE certificado_no = 111)),
  ('2026-01', 18600000, (SELECT id FROM socios WHERE certificado_no = 111)),
  ('2026-02', 18600000, (SELECT id FROM socios WHERE certificado_no = 111)),
  ('2026-03', 18600000, (SELECT id FROM socios WHERE certificado_no = 111)),
  ('2026-04', 18600000, (SELECT id FROM socios WHERE certificado_no = 111)),
  ('2026-05', 18600000, (SELECT id FROM socios WHERE certificado_no = 111)),
  ('2026-06', 18400000, (SELECT id FROM socios WHERE certificado_no = 111));

-- 275: 5 cuotas, total 167,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 33000000, (SELECT id FROM socios WHERE certificado_no = 275)),
  ('2026-01', 10000000, (SELECT id FROM socios WHERE certificado_no = 275)),
  ('2026-02', 41500000, (SELECT id FROM socios WHERE certificado_no = 275)),
  ('2026-03', 41500000, (SELECT id FROM socios WHERE certificado_no = 275)),
  ('2026-04', 41500000, (SELECT id FROM socios WHERE certificado_no = 275));

-- 197: 3 cuotas, total 100,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 197)),
  ('2026-01', 30000000, (SELECT id FROM socios WHERE certificado_no = 197)),
  ('2026-02', 40000000, (SELECT id FROM socios WHERE certificado_no = 197));

-- 266: 11 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-01', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-02', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-03', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-04', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-05', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-06', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-07', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-08', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-09', 5000000, (SELECT id FROM socios WHERE certificado_no = 266)),
  ('2026-10', 5000000, (SELECT id FROM socios WHERE certificado_no = 266));

-- 98: 3 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 18000000, (SELECT id FROM socios WHERE certificado_no = 98)),
  ('2026-01', 18000000, (SELECT id FROM socios WHERE certificado_no = 98)),
  ('2026-02', 19000000, (SELECT id FROM socios WHERE certificado_no = 98));

-- 95: 2 cuotas, total 167,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 120000000, (SELECT id FROM socios WHERE certificado_no = 95)),
  ('2026-02', 47500000, (SELECT id FROM socios WHERE certificado_no = 95));

-- 779: 14 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-01', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-02', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-03', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-04', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-05', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-06', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-07', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-08', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-09', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-10', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-11', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2026-12', 5000000, (SELECT id FROM socios WHERE certificado_no = 779)),
  ('2027-01', 5000000, (SELECT id FROM socios WHERE certificado_no = 779));

-- 172: 3 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 172)),
  ('2026-01', 25000000, (SELECT id FROM socios WHERE certificado_no = 172)),
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 172));

-- 178: 3 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 178)),
  ('2026-06', 27500000, (SELECT id FROM socios WHERE certificado_no = 178)),
  ('2026-12', 27500000, (SELECT id FROM socios WHERE certificado_no = 178));

-- 329: 1 cuotas, total 167,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-07', 167500000, (SELECT id FROM socios WHERE certificado_no = 329));

-- 188: 2 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 25000000, (SELECT id FROM socios WHERE certificado_no = 188)),
  ('2026-01', 30000000, (SELECT id FROM socios WHERE certificado_no = 188));

-- 129: 4 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 18750000, (SELECT id FROM socios WHERE certificado_no = 129)),
  ('2026-02', 18750000, (SELECT id FROM socios WHERE certificado_no = 129)),
  ('2026-03', 18750000, (SELECT id FROM socios WHERE certificado_no = 129)),
  ('2026-04', 18750000, (SELECT id FROM socios WHERE certificado_no = 129));

-- 294: 5 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 294)),
  ('2026-01', 13750000, (SELECT id FROM socios WHERE certificado_no = 294)),
  ('2026-02', 13750000, (SELECT id FROM socios WHERE certificado_no = 294)),
  ('2026-03', 13750000, (SELECT id FROM socios WHERE certificado_no = 294)),
  ('2026-04', 13750000, (SELECT id FROM socios WHERE certificado_no = 294));

-- 339: 4 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 339)),
  ('2026-02', 60000000, (SELECT id FROM socios WHERE certificado_no = 339)),
  ('2026-04', 25000000, (SELECT id FROM socios WHERE certificado_no = 339)),
  ('2026-05', 15000000, (SELECT id FROM socios WHERE certificado_no = 339));

-- 324: 5 cuotas, total 162,750,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 35000000, (SELECT id FROM socios WHERE certificado_no = 324)),
  ('2026-02', 35000000, (SELECT id FROM socios WHERE certificado_no = 324)),
  ('2026-03', 35000000, (SELECT id FROM socios WHERE certificado_no = 324)),
  ('2026-04', 35000000, (SELECT id FROM socios WHERE certificado_no = 324)),
  ('2026-05', 22750000, (SELECT id FROM socios WHERE certificado_no = 324));

-- 323: 5 cuotas, total 162,750,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 35000000, (SELECT id FROM socios WHERE certificado_no = 323)),
  ('2026-02', 35000000, (SELECT id FROM socios WHERE certificado_no = 323)),
  ('2026-03', 35000000, (SELECT id FROM socios WHERE certificado_no = 323)),
  ('2026-04', 35000000, (SELECT id FROM socios WHERE certificado_no = 323)),
  ('2026-05', 22750000, (SELECT id FROM socios WHERE certificado_no = 323));

-- 34: 5 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 26000000, (SELECT id FROM socios WHERE certificado_no = 34)),
  ('2026-01', 26000000, (SELECT id FROM socios WHERE certificado_no = 34)),
  ('2026-02', 26000000, (SELECT id FROM socios WHERE certificado_no = 34)),
  ('2026-03', 26000000, (SELECT id FROM socios WHERE certificado_no = 34)),
  ('2026-04', 26000000, (SELECT id FROM socios WHERE certificado_no = 34));

-- 563: 13 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-01', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-02', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-03', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-04', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-05', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-06', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-07', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-08', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-09', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-10', 10000000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-11', 12500000, (SELECT id FROM socios WHERE certificado_no = 563)),
  ('2026-12', 7500000, (SELECT id FROM socios WHERE certificado_no = 563));

-- 57: 3 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 57)),
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 57)),
  ('2026-02', 25000000, (SELECT id FROM socios WHERE certificado_no = 57));

-- 555: 4 cuotas, total 130,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 32500000, (SELECT id FROM socios WHERE certificado_no = 555)),
  ('2026-03', 32500000, (SELECT id FROM socios WHERE certificado_no = 555)),
  ('2026-04', 32500000, (SELECT id FROM socios WHERE certificado_no = 555)),
  ('2026-05', 32500000, (SELECT id FROM socios WHERE certificado_no = 555));

-- 166: 2 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 166)),
  ('2026-01', 35000000, (SELECT id FROM socios WHERE certificado_no = 166));

-- 319: 2 cuotas, total 100,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 50000000, (SELECT id FROM socios WHERE certificado_no = 319)),
  ('2026-02', 50000000, (SELECT id FROM socios WHERE certificado_no = 319));

-- 585: 2 cuotas, total 45,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 25000000, (SELECT id FROM socios WHERE certificado_no = 585)),
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 585));

-- 125: 24 cuotas, total 222,750,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2026-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 125)),
  ('2027-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 125));

-- 508: 12 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-02', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-03', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-04', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-05', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-06', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-07', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-08', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-09', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-10', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-11', 5000000, (SELECT id FROM socios WHERE certificado_no = 508)),
  ('2026-12', 5000000, (SELECT id FROM socios WHERE certificado_no = 508));

-- 145: 7 cuotas, total 167,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 145)),
  ('2026-01', 22000000, (SELECT id FROM socios WHERE certificado_no = 145)),
  ('2026-02', 32000000, (SELECT id FROM socios WHERE certificado_no = 145)),
  ('2026-03', 23500000, (SELECT id FROM socios WHERE certificado_no = 145)),
  ('2026-04', 20000000, (SELECT id FROM socios WHERE certificado_no = 145)),
  ('2026-05', 20000000, (SELECT id FROM socios WHERE certificado_no = 145)),
  ('2026-06', 20000000, (SELECT id FROM socios WHERE certificado_no = 145));

-- 612: 7 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 10000000, (SELECT id FROM socios WHERE certificado_no = 612)),
  ('2026-02', 7500000, (SELECT id FROM socios WHERE certificado_no = 612)),
  ('2026-03', 7500000, (SELECT id FROM socios WHERE certificado_no = 612)),
  ('2026-04', 7500000, (SELECT id FROM socios WHERE certificado_no = 612)),
  ('2026-05', 7500000, (SELECT id FROM socios WHERE certificado_no = 612)),
  ('2026-06', 7500000, (SELECT id FROM socios WHERE certificado_no = 612)),
  ('2026-07', 7500000, (SELECT id FROM socios WHERE certificado_no = 612));

-- 225: 24 cuotas, total 215,250,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2026-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 225)),
  ('2027-11', 1781250, (SELECT id FROM socios WHERE certificado_no = 225));

-- 160: 9 cuotas, total 74,250,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 8250000, (SELECT id FROM socios WHERE certificado_no = 160)),
  ('2026-01', 8250000, (SELECT id FROM socios WHERE certificado_no = 160)),
  ('2026-02', 8250000, (SELECT id FROM socios WHERE certificado_no = 160)),
  ('2026-03', 8250000, (SELECT id FROM socios WHERE certificado_no = 160)),
  ('2026-04', 8250000, (SELECT id FROM socios WHERE certificado_no = 160)),
  ('2026-05', 8250000, (SELECT id FROM socios WHERE certificado_no = 160)),
  ('2026-06', 8250000, (SELECT id FROM socios WHERE certificado_no = 160)),
  ('2026-07', 8250000, (SELECT id FROM socios WHERE certificado_no = 160)),
  ('2026-08', 8250000, (SELECT id FROM socios WHERE certificado_no = 160));

-- 184: 3 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 25000000, (SELECT id FROM socios WHERE certificado_no = 184)),
  ('2026-01', 25000000, (SELECT id FROM socios WHERE certificado_no = 184)),
  ('2026-02', 25000000, (SELECT id FROM socios WHERE certificado_no = 184));

-- 288: 4 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 288)),
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 288)),
  ('2026-04', 20000000, (SELECT id FROM socios WHERE certificado_no = 288)),
  ('2026-06', 15000000, (SELECT id FROM socios WHERE certificado_no = 288));

-- 120: 3 cuotas, total 50,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 120)),
  ('2026-11', 20000000, (SELECT id FROM socios WHERE certificado_no = 120)),
  ('2027-11', 20000000, (SELECT id FROM socios WHERE certificado_no = 120));

-- 100: 18 cuotas, total 54,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-02', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-03', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-04', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-05', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-06', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-07', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-08', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-09', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-10', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-11', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2026-12', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2027-01', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2027-02', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2027-03', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2027-04', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2027-05', 3000000, (SELECT id FROM socios WHERE certificado_no = 100)),
  ('2027-06', 3000000, (SELECT id FROM socios WHERE certificado_no = 100));

-- 562: 48 cuotas, total 269,512,128
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-03', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-04', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-05', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-06', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-07', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-08', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-09', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-10', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-11', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2026-12', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-01', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-02', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-03', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-04', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-05', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-06', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-07', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-08', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-09', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-10', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-11', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2027-12', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-01', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-02', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-03', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-04', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-05', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-06', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-07', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-08', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-09', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-10', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-11', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2028-12', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-01', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-02', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-03', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-04', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-05', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-06', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-07', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-08', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-09', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-10', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-11', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2029-12', 5614836, (SELECT id FROM socios WHERE certificado_no = 562)),
  ('2030-01', 5614836, (SELECT id FROM socios WHERE certificado_no = 562));

-- 296: 25 cuotas, total 240,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 24000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-03', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-04', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-05', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-06', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-07', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-08', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-09', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-10', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-11', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2026-12', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-01', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-02', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-03', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-04', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-05', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-06', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-07', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-08', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-09', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-10', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-11', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2027-12', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2028-01', 9000000, (SELECT id FROM socios WHERE certificado_no = 296)),
  ('2028-02', 9000000, (SELECT id FROM socios WHERE certificado_no = 296));

-- 74: 3 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 38000000, (SELECT id FROM socios WHERE certificado_no = 74)),
  ('2026-01', 2000000, (SELECT id FROM socios WHERE certificado_no = 74)),
  ('2026-02', 35000000, (SELECT id FROM socios WHERE certificado_no = 74));

-- 230: 25 cuotas, total 240,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 24000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-03', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-04', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-05', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-06', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-07', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-08', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-09', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-10', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-11', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2026-12', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-01', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-02', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-03', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-04', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-05', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-06', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-07', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-08', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-09', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-10', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-11', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2027-12', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2028-01', 9000000, (SELECT id FROM socios WHERE certificado_no = 230)),
  ('2028-02', 9000000, (SELECT id FROM socios WHERE certificado_no = 230));

-- 273: 5 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 15000000, (SELECT id FROM socios WHERE certificado_no = 273)),
  ('2026-03', 15000000, (SELECT id FROM socios WHERE certificado_no = 273)),
  ('2026-04', 15000000, (SELECT id FROM socios WHERE certificado_no = 273)),
  ('2026-05', 15000000, (SELECT id FROM socios WHERE certificado_no = 273)),
  ('2026-06', 15000000, (SELECT id FROM socios WHERE certificado_no = 273));

-- 8: 3 cuotas, total 150,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 8)),
  ('2026-07', 65000000, (SELECT id FROM socios WHERE certificado_no = 8)),
  ('2026-12', 65000000, (SELECT id FROM socios WHERE certificado_no = 8));

-- 135: 25 cuotas, total 247,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 24750000, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2026-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2027-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 135)),
  ('2028-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 135));

-- 258: 6 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 40000000, (SELECT id FROM socios WHERE certificado_no = 258)),
  ('2026-02', 7000000, (SELECT id FROM socios WHERE certificado_no = 258)),
  ('2026-03', 7000000, (SELECT id FROM socios WHERE certificado_no = 258)),
  ('2026-04', 7000000, (SELECT id FROM socios WHERE certificado_no = 258)),
  ('2026-05', 7000000, (SELECT id FROM socios WHERE certificado_no = 258)),
  ('2026-06', 7000000, (SELECT id FROM socios WHERE certificado_no = 258));

-- 823: 3 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 823)),
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 823)),
  ('2026-02', 35000000, (SELECT id FROM socios WHERE certificado_no = 823));

-- 502: 3 cuotas, total 150,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 50000000, (SELECT id FROM socios WHERE certificado_no = 502)),
  ('2026-06', 50000000, (SELECT id FROM socios WHERE certificado_no = 502)),
  ('2026-10', 50000000, (SELECT id FROM socios WHERE certificado_no = 502));

-- 161: 4 cuotas, total 120,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 30000000, (SELECT id FROM socios WHERE certificado_no = 161)),
  ('2026-05', 30000000, (SELECT id FROM socios WHERE certificado_no = 161)),
  ('2026-08', 30000000, (SELECT id FROM socios WHERE certificado_no = 161)),
  ('2026-11', 30000000, (SELECT id FROM socios WHERE certificado_no = 161));

-- 218: 25 cuotas, total 247,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 24750000, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2026-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2027-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2028-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 218)),
  ('2028-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 218));

-- 240: 10 cuotas, total 187,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-03', 18750000, (SELECT id FROM socios WHERE certificado_no = 240)),
  ('2026-04', 18750000, (SELECT id FROM socios WHERE certificado_no = 240)),
  ('2026-05', 18750000, (SELECT id FROM socios WHERE certificado_no = 240)),
  ('2026-06', 18750000, (SELECT id FROM socios WHERE certificado_no = 240)),
  ('2026-07', 18750000, (SELECT id FROM socios WHERE certificado_no = 240)),
  ('2026-08', 18750000, (SELECT id FROM socios WHERE certificado_no = 240)),
  ('2026-09', 18750000, (SELECT id FROM socios WHERE certificado_no = 240)),
  ('2026-10', 18750000, (SELECT id FROM socios WHERE certificado_no = 240)),
  ('2026-11', 18750000, (SELECT id FROM socios WHERE certificado_no = 240)),
  ('2026-12', 18750000, (SELECT id FROM socios WHERE certificado_no = 240));

-- 285: 6 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 12500000, (SELECT id FROM socios WHERE certificado_no = 285)),
  ('2026-03', 12500000, (SELECT id FROM socios WHERE certificado_no = 285)),
  ('2026-04', 12500000, (SELECT id FROM socios WHERE certificado_no = 285)),
  ('2026-05', 12500000, (SELECT id FROM socios WHERE certificado_no = 285)),
  ('2026-06', 12500000, (SELECT id FROM socios WHERE certificado_no = 285)),
  ('2026-07', 12500000, (SELECT id FROM socios WHERE certificado_no = 285));

-- 33: 5 cuotas, total 187,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-03', 93750000, (SELECT id FROM socios WHERE certificado_no = 33)),
  ('2026-04', 23437500, (SELECT id FROM socios WHERE certificado_no = 33)),
  ('2026-05', 23437500, (SELECT id FROM socios WHERE certificado_no = 33)),
  ('2026-06', 23437500, (SELECT id FROM socios WHERE certificado_no = 33)),
  ('2026-07', 23437500, (SELECT id FROM socios WHERE certificado_no = 33));

-- 650: 5 cuotas, total 67,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 650)),
  ('2026-02', 7500000, (SELECT id FROM socios WHERE certificado_no = 650)),
  ('2026-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 650)),
  ('2026-05', 20000000, (SELECT id FROM socios WHERE certificado_no = 650)),
  ('2026-06', 10000000, (SELECT id FROM socios WHERE certificado_no = 650));

-- 344: 5 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 10000000, (SELECT id FROM socios WHERE certificado_no = 344)),
  ('2026-01', 10000000, (SELECT id FROM socios WHERE certificado_no = 344)),
  ('2026-02', 10000000, (SELECT id FROM socios WHERE certificado_no = 344)),
  ('2026-03', 10000000, (SELECT id FROM socios WHERE certificado_no = 344)),
  ('2026-04', 15000000, (SELECT id FROM socios WHERE certificado_no = 344));

-- 134: 6 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 20000000, (SELECT id FROM socios WHERE certificado_no = 134)),
  ('2026-02', 11000000, (SELECT id FROM socios WHERE certificado_no = 134)),
  ('2026-03', 11000000, (SELECT id FROM socios WHERE certificado_no = 134)),
  ('2026-04', 11000000, (SELECT id FROM socios WHERE certificado_no = 134)),
  ('2026-05', 11000000, (SELECT id FROM socios WHERE certificado_no = 134)),
  ('2026-06', 11000000, (SELECT id FROM socios WHERE certificado_no = 134));

-- 164: 3 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 35000000, (SELECT id FROM socios WHERE certificado_no = 164)),
  ('2026-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 164)),
  ('2026-05', 20000000, (SELECT id FROM socios WHERE certificado_no = 164));

-- 267: 23 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-03', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-04', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-05', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-06', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-07', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-08', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-09', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-10', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-11', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2026-12', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-01', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-02', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-03', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-04', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-05', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-06', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-07', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-08', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-09', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-10', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-11', 3260870, (SELECT id FROM socios WHERE certificado_no = 267)),
  ('2027-12', 3260860, (SELECT id FROM socios WHERE certificado_no = 267));

-- 23: 23 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-03', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-04', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-05', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-06', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-07', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-08', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-09', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-10', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-11', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2026-12', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-01', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-02', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-03', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-04', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-05', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-06', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-07', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-08', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-09', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-10', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-11', 3260870, (SELECT id FROM socios WHERE certificado_no = 23)),
  ('2027-12', 3260860, (SELECT id FROM socios WHERE certificado_no = 23));

-- 276: 7 cuotas, total 150,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 276)),
  ('2026-06', 20000000, (SELECT id FROM socios WHERE certificado_no = 276)),
  ('2026-10', 20000000, (SELECT id FROM socios WHERE certificado_no = 276)),
  ('2026-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 276)),
  ('2027-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 276)),
  ('2027-06', 20000000, (SELECT id FROM socios WHERE certificado_no = 276)),
  ('2027-09', 30000000, (SELECT id FROM socios WHERE certificado_no = 276));

-- 72: 25 cuotas, total 247,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 24750000, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2026-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-03', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-04', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-05', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-06', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-07', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-08', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-09', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-10', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-11', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2027-12', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2028-01', 9281250, (SELECT id FROM socios WHERE certificado_no = 72)),
  ('2028-02', 9281250, (SELECT id FROM socios WHERE certificado_no = 72));

-- 838: 3 cuotas, total 150,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-03', 30000000, (SELECT id FROM socios WHERE certificado_no = 838)),
  ('2026-04', 30000000, (SELECT id FROM socios WHERE certificado_no = 838)),
  ('2026-05', 90000000, (SELECT id FROM socios WHERE certificado_no = 838));

-- 399: 12 cuotas, total 247,500,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-03', 24750000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2026-04', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2026-05', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2026-06', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2026-07', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2026-08', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2026-09', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2026-10', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2026-11', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2026-12', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2027-01', 20250000, (SELECT id FROM socios WHERE certificado_no = 399)),
  ('2027-02', 20250000, (SELECT id FROM socios WHERE certificado_no = 399));

-- 62: 4 cuotas, total 150,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-01', 30000000, (SELECT id FROM socios WHERE certificado_no = 62)),
  ('2026-02', 40000000, (SELECT id FROM socios WHERE certificado_no = 62)),
  ('2026-03', 40000000, (SELECT id FROM socios WHERE certificado_no = 62)),
  ('2026-04', 40000000, (SELECT id FROM socios WHERE certificado_no = 62));

-- 981: 5 cuotas, total 150,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-05', 30000000, (SELECT id FROM socios WHERE certificado_no = 981)),
  ('2026-07', 30000000, (SELECT id FROM socios WHERE certificado_no = 981)),
  ('2026-09', 30000000, (SELECT id FROM socios WHERE certificado_no = 981)),
  ('2026-11', 30000000, (SELECT id FROM socios WHERE certificado_no = 981)),
  ('2026-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 981));

-- 311: 48 cuotas, total 269,512,128
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-05', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2026-06', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2026-07', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2026-08', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2026-09', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2026-10', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2026-11', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2026-12', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-01', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-02', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-03', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-04', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-05', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-06', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-07', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-08', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-09', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-10', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-11', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2027-12', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-01', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-02', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-03', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-04', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-05', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-06', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-07', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-08', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-09', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-10', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-11', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2028-12', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-01', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-02', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-03', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-04', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-05', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-06', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-07', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-08', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-09', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-10', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-11', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2029-12', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2030-01', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2030-02', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2030-03', 5614836, (SELECT id FROM socios WHERE certificado_no = 311)),
  ('2030-04', 5614836, (SELECT id FROM socios WHERE certificado_no = 311));

-- 299: 4 cuotas, total 75,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2026-02', 20000000, (SELECT id FROM socios WHERE certificado_no = 299)),
  ('2026-03', 20000000, (SELECT id FROM socios WHERE certificado_no = 299)),
  ('2026-04', 20000000, (SELECT id FROM socios WHERE certificado_no = 299)),
  ('2026-05', 15000000, (SELECT id FROM socios WHERE certificado_no = 299));

-- 303: 1 cuotas, total 30,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 30000000, (SELECT id FROM socios WHERE certificado_no = 303));

-- 250: 2 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 250)),
  ('2026-01', 35000000, (SELECT id FROM socios WHERE certificado_no = 250));

-- 265: 2 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 265)),
  ('2026-01', 35000000, (SELECT id FROM socios WHERE certificado_no = 265));

-- 155: 2 cuotas, total 55,000,000
INSERT INTO planes_pago (periodo, monto_proyectado, socio_id) VALUES
  ('2025-12', 20000000, (SELECT id FROM socios WHERE certificado_no = 155)),
  ('2026-01', 35000000, (SELECT id FROM socios WHERE certificado_no = 155));

-- Update saldos
UPDATE planes_pago pp SET saldo = sub.remaining
FROM (
  SELECT id, SUM(monto_proyectado) OVER (PARTITION BY socio_id ORDER BY periodo DESC) AS remaining
  FROM planes_pago
) sub WHERE pp.id = sub.id;

COMMIT;

SELECT 'OK' AS resultado, COUNT(*) AS planes, SUM(monto_proyectado) AS total FROM planes_pago;
