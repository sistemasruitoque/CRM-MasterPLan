-- Esquema de Base de Datos para Club CRM
-- Ejecutar en Supabase SQL Editor

-- Tabla de Socios
CREATE TABLE socios (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  certificado_no INTEGER UNIQUE NOT NULL,
  cedula VARCHAR(20) NOT NULL,
  nombre VARCHAR(255) NOT NULL,
  categoria VARCHAR(20) NOT NULL CHECK (categoria IN ('Fundador', 'Fase I', 'Fase II', 'Fase III')),
  estatus VARCHAR(50) DEFAULT 'Pendiente',
  fecha_contrato DATE,
  admin_fee NUMERIC(14,0) DEFAULT 0,
  cuota_especial_nota TEXT DEFAULT '',
  modalidad VARCHAR(100) DEFAULT 'Corporación',
  aporte NUMERIC(14,0) DEFAULT 0,
  referido NUMERIC(14,0) DEFAULT 0,
  valor_final NUMERIC(14,0) DEFAULT 0,
  ap_locker NUMERIC(14,0) DEFAULT 0,
  cabal_cant INTEGER DEFAULT 0,
  cab_locker INTEGER DEFAULT 0,
  dama_cant INTEGER DEFAULT 0,
  responsable VARCHAR(100) DEFAULT '',
  observaciones TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla de Planes de Pago
CREATE TABLE planes_pago (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  socio_id UUID NOT NULL REFERENCES socios(id) ON DELETE CASCADE,
  periodo VARCHAR(10) NOT NULL,
  monto_proyectado NUMERIC(14,0) DEFAULT 0,
  monto_pagado NUMERIC(14,0) DEFAULT 0,
  saldo NUMERIC(14,0) DEFAULT 0,
  estado VARCHAR(20) DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'pagado', 'parcial', 'exonerado')),
  fecha_pago DATE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(socio_id, periodo)
);

-- Tabla de Pagos (transacciones)
CREATE TABLE pagos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  socio_id UUID NOT NULL REFERENCES socios(id) ON DELETE CASCADE,
  plan_pago_id UUID REFERENCES planes_pago(id) ON DELETE SET NULL,
  monto NUMERIC(14,0) NOT NULL,
  fecha_pago DATE NOT NULL DEFAULT CURRENT_DATE,
  tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('cuota', 'separacion', 'locker', 'ajuste')),
  concepto TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla de Configuración
CREATE TABLE configuracion (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  clave VARCHAR(100) UNIQUE NOT NULL,
  valor TEXT NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insertar configuración por defecto
INSERT INTO configuracion (clave, valor) VALUES
  ('tasa_interes_mensual', '1.0'),
  ('tasa_interes_mora', '2.0'),
  ('cuota_admin_mensual', '2000000'),
  ('nombre_club', 'Club CRM');

-- Índices
CREATE INDEX idx_socios_categoria ON socios(categoria);
CREATE INDEX idx_socios_estatus ON socios(estatus);
CREATE INDEX idx_planes_pago_socio ON planes_pago(socio_id);
CREATE INDEX idx_planes_pago_estado ON planes_pago(estado);
CREATE INDEX idx_pagos_socio ON pagos(socio_id);
CREATE INDEX idx_pagos_fecha ON pagos(fecha_pago);

-- Función para actualizar updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER socios_updated_at
  BEFORE UPDATE ON socios FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER planes_pago_updated_at
  BEFORE UPDATE ON planes_pago FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Función para calcular plan de pagos automáticamente
CREATE OR REPLACE FUNCTION generar_plan_pagos(
  p_socio_id UUID,
  p_tasa_interes NUMERIC DEFAULT 1.0
) RETURNS SETOF planes_pago AS $$
DECLARE
  v_socio socios%ROWTYPE;
  v_saldo NUMERIC(14,0);
  v_cuota_base NUMERIC(14,0);
  v_interes NUMERIC(14,0);
  v_cuota NUMERIC(14,0);
  v_periodo VARCHAR(10);
  v_mes INTEGER := 0;
  v_year INTEGER := 2025;
  v_month_names VARCHAR(3)[] := ARRAY['Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct'];
BEGIN
  SELECT * INTO v_socio FROM socios WHERE id = p_socio_id;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Socio no encontrado';
  END IF;

  v_saldo := v_socio.valor_final;
  v_cuota_base := ROUND(v_socio.valor_final * 0.0363);
  v_year := 2025;
  v_mes := 1;

  WHILE v_saldo > 0 AND v_mes <= 60 LOOP
    v_periodo := v_month_names[((v_mes - 1) % 12) + 1] || '-' || RIGHT(CAST(v_year + ((v_mes - 1) / 12) AS VARCHAR), 2);
    v_interes := ROUND(v_saldo * p_tasa_interes / 100);
    v_cuota := LEAST(v_cuota_base + v_interes, v_saldo + v_interes);

    INSERT INTO planes_pago (socio_id, periodo, monto_proyectado, monto_pagado, saldo, estado)
    VALUES (p_socio_id, v_periodo, v_cuota, 0, v_saldo, 'pendiente')
    ON CONFLICT (socio_id, periodo) DO NOTHING;

    v_saldo := v_saldo - v_cuota;
    v_mes := v_mes + 1;
  END LOOP;

  RETURN QUERY SELECT * FROM planes_pago WHERE socio_id = p_socio_id ORDER BY periodo;
END;
$$ LANGUAGE plpgsql;

-- Políticas de seguridad (Row Level Security)
ALTER TABLE socios ENABLE ROW LEVEL SECURITY;
ALTER TABLE planes_pago ENABLE ROW LEVEL SECURITY;
ALTER TABLE pagos ENABLE ROW LEVEL SECURITY;
ALTER TABLE configuracion ENABLE ROW LEVEL SECURITY;

-- Políticas públicas para desarrollo (ajustar en producción)
CREATE POLICY "Permitir todo desarrollo" ON socios FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Permitir todo desarrollo" ON planes_pago FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Permitir todo desarrollo" ON pagos FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Permitir todo desarrollo" ON configuracion FOR ALL USING (true) WITH CHECK (true);
