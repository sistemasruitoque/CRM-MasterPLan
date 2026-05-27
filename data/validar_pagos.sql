-- Validar que monto_pagado (planes_pago) coincida con pagos reales (pagos)
-- Ejecutar en Supabase SQL Editor

WITH pagos_agrupados AS (
  SELECT socio_id, SUM(monto) AS total_pagado_real
  FROM pagos
  GROUP BY socio_id
),
plan_agrupado AS (
  SELECT socio_id, SUM(monto_pagado) AS total_monto_pagado
  FROM planes_pago
  GROUP BY socio_id
)
SELECT
  s.certificado_no,
  s.nombre,
  s.valor_final,
  COALESCE(plan.total_monto_pagado, 0) AS monto_pagado_planes,
  COALESCE(pag.total_pagado_real, 0) AS pagado_real_pagos,
  COALESCE(plan.total_monto_pagado, 0) - COALESCE(pag.total_pagado_real, 0) AS diferencia,
  CASE
    WHEN COALESCE(plan.total_monto_pagado, 0) = COALESCE(pag.total_pagado_real, 0) THEN 'OK'
    ELSE 'DESCUADRADO'
  END AS estado
FROM socios s
LEFT JOIN plan_agrupado plan ON plan.socio_id = s.id
LEFT JOIN pagos_agrupados pag ON pag.socio_id = s.id
WHERE COALESCE(plan.total_monto_pagado, 0) != COALESCE(pag.total_pagado_real, 0)
   OR (plan.total_monto_pagado IS NULL AND pag.total_pagado_real IS NOT NULL)
   OR (plan.total_monto_pagado IS NOT NULL AND pag.total_pagado_real IS NULL)
ORDER BY ABS(COALESCE(plan.total_monto_pagado, 0) - COALESCE(pag.total_pagado_real, 0)) DESC;
