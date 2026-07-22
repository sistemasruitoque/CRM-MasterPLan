CREATE TABLE IF NOT EXISTS auditoria (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tabla TEXT NOT NULL,
  registro_id TEXT,
  accion TEXT NOT NULL,
  usuario TEXT,
  datos_anteriores JSONB,
  datos_nuevos JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_auditoria_tabla ON auditoria(tabla);
CREATE INDEX IF NOT EXISTS idx_auditoria_registro_id ON auditoria(registro_id);
CREATE INDEX IF NOT EXISTS idx_auditoria_created_at ON auditoria(created_at DESC);
