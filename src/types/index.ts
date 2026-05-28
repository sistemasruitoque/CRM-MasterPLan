export interface Socio {
  id: string
  certificado_no: number
  cedula: string
  nombre: string
  categoria: 'Fundador' | 'Fase I' | 'Fase II' | 'Fase III'
  estatus: string
  fecha_contrato: string | null
  admin_fee: number
  cuota_especial_nota: string
  modalidad: string
  aporte: number
  referido: number
  valor_final: number
  ap_locker: number
  cabal_cant: number
  cab_locker: number
  dama_cant: number
  responsable: string
  observaciones: string
  created_at: string
}

export interface PlanPago {
  id: string
  socio_id: string
  periodo: string
  monto_proyectado: number
  monto_pagado: number
  saldo: number
  interes_mora: number
  estado: 'pendiente' | 'pagado' | 'parcial' | 'exonerado'
  fecha_pago: string | null
  created_at: string
}

export interface Pago {
  id: string
  socio_id: string
  plan_pago_id: string | null
  monto: number
  fecha_pago: string
  tipo: 'cuota' | 'separacion' | 'locker' | 'ajuste'
  concepto: string
  created_at: string
}

export interface DashboardStats {
  total_socios: number
  total_aportes: number
  total_recaudado: number
  saldo_pendiente: number
  socios_al_dia: number
  socios_en_mora: number
}
