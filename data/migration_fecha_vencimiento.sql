ALTER TABLE planes_pago ADD COLUMN IF NOT EXISTS fecha_vencimiento DATE DEFAULT NULL;

UPDATE planes_pago
SET fecha_vencimiento = (DATE_TRUNC('MONTH', to_date(periodo || '-01', 'YYYY-MM-DD')) + INTERVAL '1 MONTH' - INTERVAL '1 DAY')::DATE
WHERE fecha_vencimiento IS NULL;
