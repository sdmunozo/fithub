class UsuarioActividadFisica:

  def __init__(self, tiempo_actividad_meses, frecuencia_semanal,
               duracion_sesiones, intensidad):
    self.tiempo_actividad_meses = tiempo_actividad_meses
    self.frecuencia_semanal = frecuencia_semanal
    self.duracion_sesiones = duracion_sesiones
    self.intensidad = intensidad


def definir_nivel_usuario(usuario):
  # Conversión de intensidad a un valor numérico para facilitar la comparación
  intensidad_valor = {'Baja': 1, 'Media': 2, 'Alta': 3}[usuario.intensidad]

  if usuario.tiempo_actividad_meses <= 3:
    return 'PRINCIPIANTE'
    
  elif 3 < usuario.tiempo_actividad_meses <= 6:
    
    if usuario.frecuencia_semanal < 4 or (
        usuario.frecuencia_semanal == 4 and usuario.duracion_sesiones
        <= 60) or (usuario.frecuencia_semanal > 4
                   and usuario.duracion_sesiones <= 45):
      return 'PRINCIPIANTE'

    if (usuario.frecuencia_semanal > 4
        and 60 <= usuario.duracion_sesiones <= 90):
      return 'INTERMEDIO X1'
      
  elif 6 < usuario.tiempo_actividad_meses <= 9:
    if usuario.frecuencia_semanal < 3 or (usuario.frecuencia_semanal == 3
                                          and usuario.duracion_sesiones <= 45
                                          and intensidad_valor <= 2):
      return 'PRINCIPIANTE'

  elif 9 < usuario.tiempo_actividad_meses <= 12:
    
    if usuario.frecuencia_semanal < 3 or (
        usuario.frecuencia_semanal == 3 and usuario.duracion_sesiones
        < 30) or (usuario.frecuencia_semanal > 4
                  and usuario.duracion_sesiones < 45
                  and intensidad_valor <= 2):
      return 'PRINCIPIANTE'
      
    elif (usuario.frecuencia_semanal == 5 and usuario.duracion_sesiones >= 60
          and intensidad_valor == 2):
      return 'INTERMEDIO X2'
      
    elif (usuario.frecuencia_semanal >= 6 and usuario.duracion_sesiones >= 60
          and intensidad_valor >= 2):
      return 'AVANZADO'
      
      #(9, 5, 90, 'Media'),  # Ejemplo #11 AQUI VOY
    elif (usuario.frecuencia_semanal == 5
          and 45 <= usuario.duracion_sesiones <= 60 and intensidad_valor >= 2):
      return 'INTERMEDIO X3'
    elif (usuario.frecuencia_semanal == 5 and usuario.duracion_sesiones <= 60
          and intensidad_valor >= 2):
      return 'AVANZADO'
    elif (usuario.frecuencia_semanal >= 6 and usuario.duracion_sesiones >= 45
          and intensidad_valor == 3):
      return 'AVANZADO'

  elif (12 <= usuario.tiempo_actividad_meses <= 18):
    if (intensidad_valor == 1):
      return 'PRINCIPIANTE'

    if usuario.frecuencia_semanal < 3 or (usuario.frecuencia_semanal <= 7
                                          and usuario.duracion_sesiones <= 30):
      return 'PRINCIPIANTE'

  elif usuario.tiempo_actividad_meses > 18:
    if (intensidad_valor == 1):
      return 'PRINCIPIANTE'
    if usuario.frecuencia_semanal < 3 or (usuario.frecuencia_semanal == 4
                                          and usuario.duracion_sesiones <= 30):
      return 'PRINCIPIANTE'
    if (intensidad_valor == 1):
      return 'AVANZADO'


  if usuario.tiempo_actividad_meses > 3:
    if (usuario.frecuencia_semanal == 3
        and 30 <= usuario.duracion_sesiones <= 45 and intensidad_valor == 3):
      return 'INTERMEDIO X4'
    elif (usuario.frecuencia_semanal == 3 and usuario.duracion_sesiones >= 45
          and intensidad_valor > 1):
      return 'INTERMEDIO X5'
    elif (3 <= usuario.frecuencia_semanal <= 4
          and usuario.duracion_sesiones >= 45 and intensidad_valor == 2):
      return 'INTERMEDIO X6'
    elif (usuario.frecuencia_semanal == 4 and usuario.duracion_sesiones > 60
          and intensidad_valor == 2):
      return 'INTERMEDIO X7'
    elif (usuario.frecuencia_semanal >= 5 and usuario.duracion_sesiones >= 60
          and intensidad_valor == 1):
      return 'INTERMEDIO X8'
    elif (usuario.frecuencia_semanal >= 5 and usuario.duracion_sesiones <= 60
          and intensidad_valor == 2):
      return 'INTERMEDIO X9'
    elif (usuario.frecuencia_semanal == 4 and usuario.duracion_sesiones <= 60
          and intensidad_valor >= 2):
      return 'INTERMEDIO X10'
    elif (usuario.frecuencia_semanal >= 4
          and 30 <= usuario.duracion_sesiones <= 45 and intensidad_valor >= 2):
      return 'INTERMEDIO X11'

  # Nivel Avanzado
  if (usuario.tiempo_actividad_meses >= 9 and usuario.frecuencia_semanal >= 5
      and usuario.duracion_sesiones >= 45
      and intensidad_valor > 1) or (usuario.tiempo_actividad_meses >= 12
                                    and usuario.frecuencia_semanal == 4
                                    and usuario.duracion_sesiones >= 45
                                    and intensidad_valor == 3):
    return 'AVANZADO'

  # Si no cumple con los criterios anteriores, asignar el nivel más bajo
  return '- NO CAYO EN NINGUN NIVEL'


# Lista de objetos de ejemplo
NVP = [
    UsuarioActividadFisica(10, 5, 70, 'Alta'),  # Ejemplo NVP #1
    UsuarioActividadFisica(4, 5, 30, 'Media'),  # Ejemplo NVP #1
    UsuarioActividadFisica(7, 3, 37.5, 'Media'),  # Ejemplo NVP #2
    UsuarioActividadFisica(19, 2, 52.5, 'Media'),  # Ejemplo NVP #3
    UsuarioActividadFisica(2, 6, 75, 'Alta'),  # Ejemplo NVP #4
    UsuarioActividadFisica(10.5, 2, 91, 'Alta'),  # Ejemplo NVP #5
    UsuarioActividadFisica(15, 5, 30, 'Alta'),  # Ejemplo NVP #6
    UsuarioActividadFisica(4.5, 4, 52.5, 'Alta'),  # Ejemplo NVP #7
    UsuarioActividadFisica(2, 7, 91, 'Alta'),  # Ejemplo NVP #8
    UsuarioActividadFisica(20, 4, 25, 'Alta'),  # Ejemplo NVP #9
    UsuarioActividadFisica(4.5, 4, 52.5, 'Alta'),  # Ejemplo NVI #10
]

NVI = [
    UsuarioActividadFisica(4.5, 5, 52.5, 'Media'),  # Ejemplo NVI #1
    UsuarioActividadFisica(15, 3, 52.5, 'Media'),  # Ejemplo NVI #2
    UsuarioActividadFisica(19, 3, 91, 'Alta'),  # Ejemplo NVI #3
    UsuarioActividadFisica(7.5, 3, 52.5, 'Media'),  # Ejemplo NVI #4
    UsuarioActividadFisica(10.5, 5, 75, 'Media'),  # Ejemplo NVI #5
    UsuarioActividadFisica(10.5, 7, 52.5, 'Media'),  # Ejemplo NVI #6
    UsuarioActividadFisica(10.5, 5, 52.5, 'Alta'),  # Ejemplo NVI #7
    UsuarioActividadFisica(7.5, 3, 52.5, 'Media'),  # Ejemplo NVI #8
    UsuarioActividadFisica(15, 4, 52.5, 'Alta'),  # Ejemplo NVI #9
    UsuarioActividadFisica(19, 3, 52.5, 'Alta'),  # Ejemplo NVI #10
    UsuarioActividadFisica(19, 3, 91, 'Media'),  # Ejemplo NVI #11
    UsuarioActividadFisica(7.5, 3, 37.5, 'Alta'),  # Ejemplo NVP #12
]

NVA = [
    # NVA
    UsuarioActividadFisica(19, 6, 52.5, 'Alta'),  # Ejemplo NVA #1
    UsuarioActividadFisica(10.5, 6, 75, 'Media'),  # Ejemplo NVA #2
    UsuarioActividadFisica(15, 5, 52.5, 'Alta'),  # Ejemplo NVA #3
    UsuarioActividadFisica(10.5, 7, 91, 'Media'),  # Ejemplo NVA #4
    UsuarioActividadFisica(19, 4, 75, 'Alta'),  # Ejemplo NVA #5
    UsuarioActividadFisica(15, 6, 75, 'Media'),  # Ejemplo NVA #6
    UsuarioActividadFisica(10.5, 5, 75, 'Alta'),  # Ejemplo NVA #7
    UsuarioActividadFisica(19, 5, 52.5, 'Alta'),  # Ejemplo NVA #8 #####
    UsuarioActividadFisica(15, 4, 75, 'Alta'),  # Ejemplo NVA #9
]

EXTRAS = [
    UsuarioActividadFisica(15, 5, 75, 'Alta'),  # Ejemplo NVA
    UsuarioActividadFisica(19, 4, 75, 'Media'),  # Ejemplo NVI
    UsuarioActividadFisica(15, 4, 62.5, 'Alta'),  # Ejemplo NVA
]

EXTRAS_Principiante = [
    UsuarioActividadFisica(13, 3, 90, 'Baja'),  # Ejemplo #13
    UsuarioActividadFisica(18, 4, 30, 'Alta'),  # Ejemplo #14
    UsuarioActividadFisica(3, 7, 30, 'Alta'),  # Ejemplo #15
    UsuarioActividadFisica(6, 5, 45, 'Baja'),  # Ejemplo #16
    UsuarioActividadFisica(13, 7, 45, 'Baja'),  # Ejemplo #17
    UsuarioActividadFisica(19, 7, 90, 'Baja'),  # Ejemplo #18
    UsuarioActividadFisica(13, 4, 30, 'Alta'),  # Ejemplo #19
    UsuarioActividadFisica(3, 6, 37.5, 'Alta'),  # Ejemplo #20
    UsuarioActividadFisica(6, 3, 37.5, 'Media'),  # Ejemplo #21
]

EXTRAS_Intermedio = [
    UsuarioActividadFisica(4, 7, 75, 'Alta'),  # Ejemplo #12
    UsuarioActividadFisica(7, 5, 37.5, 'Media'),  # Ejemplo #13
    UsuarioActividadFisica(12, 6, 52.5, 'Media'),  # Ejemplo #14
    UsuarioActividadFisica(9, 4, 37.5, 'Media'),  # Ejemplo #15
    UsuarioActividadFisica(18, 7, 52.5, 'Media'),  # Ejemplo #16
    UsuarioActividadFisica(19, 5, 37.5, 'Alta'),  # Ejemplo #17 duplicado
    UsuarioActividadFisica(4, 6, 90, 'Alta'),  # Ejemplo #18
    UsuarioActividadFisica(7, 6, 37.5, 'Alta'),  # Ejemplo #19
    UsuarioActividadFisica(12, 7, 52.5, 'Media'),  # Ejemplo #20
    UsuarioActividadFisica(7, 3, 37.5, 'Alta'),  # Ejemplo #21
    UsuarioActividadFisica(10, 5, 75, 'Media'),  # Ejemplo #22
    UsuarioActividadFisica(10, 5, 90, 'Media'),  # Ejemplo #23
]

EXTRAS_Avanzados = [
    UsuarioActividadFisica(18, 7, 75, 'Media'),  # Ejemplo #10
  
    UsuarioActividadFisica(9, 5, 90, 'Media'),  # Ejemplo #11
    UsuarioActividadFisica(13, 7, 52.5, 'Media'),  # Ejemplo #12
    UsuarioActividadFisica(19, 4, 90, 'Media'),  # Ejemplo #13
  
    UsuarioActividadFisica(9, 6, 52.5, 'Alta'),  # Ejemplo #14
    UsuarioActividadFisica(12, 6, 52.5, 'Alta'),  # Ejemplo #15
    UsuarioActividadFisica(18, 7, 52.5, 'Alta'),  # Ejemplo #16
    UsuarioActividadFisica(9, 7, 52.5, 'Alta'),  # Ejemplo #17
    UsuarioActividadFisica(13, 5, 52.5, 'Alta'),  # Ejemplo #18
    UsuarioActividadFisica(19, 6, 52.5, 'Alta'),  # Ejemplo #19
    UsuarioActividadFisica(12, 7, 52.5, 'Alta'),  # Ejemplo #20
]

# Evaluación masiva
for usuario in NVP:
  nivel = definir_nivel_usuario(usuario)
  print(f"Resultado NVP: {nivel}")

print("- - - - - - - - - - - - - - - - - -")

# Evaluación masiva
for usuario in NVI:
  nivel = definir_nivel_usuario(usuario)
  print(f"Resultado NVI: {nivel}")

print("- - - - - - - - - - - - - - - - - -")

# Evaluación masiva
for usuario in NVA:
  nivel = definir_nivel_usuario(usuario)
  print(f"Resultado NVA: {nivel}")

print("- - - - - - - Extras - - - - - - - - - - -")

for usuario in EXTRAS:
  nivel = definir_nivel_usuario(usuario)
  print(f"Resultado: {nivel}")

print("- - - - - - - EXTRAS_Principiante - - - - - - - - - - -")

for usuario in EXTRAS_Principiante:
  nivel = definir_nivel_usuario(usuario)
  print(f"Resultado: {nivel}")

print("- - - - - - - EXTRAS_Intermedio - - - - - - - - - - -")

for usuario in EXTRAS_Intermedio:
  nivel = definir_nivel_usuario(usuario)
  print(f"Resultado: {nivel}")

print("- - - - - - - EXTRAS_Avanzados - - - - - - - - - - -")

for usuario in EXTRAS_Avanzados:
  nivel = definir_nivel_usuario(usuario)
  print(f"Resultado: {nivel}")
"""
#(19, 4, 90, 'Media'),  # Ejemplo #13
if usuario.tiempo_actividad_meses > 3:
  if (usuario.frecuencia_semanal == 3 and
      (30 <= usuario.duracion_sesiones <= 45) and intensidad_valor == 3) or (
          usuario.frecuencia_semanal == 3 and usuario.duracion_sesiones >= 45
          and intensidad_valor > 1) or (
              3 <= usuario.frecuencia_semanal <= 4
              and usuario.duracion_sesiones >= 45 and intensidad_valor == 2
          ) or (usuario.frecuencia_semanal == 4
                and usuario.duracion_sesiones > 60 and intensidad_valor
                == 2) or (usuario.frecuencia_semanal >= 5
                          and usuario.duracion_sesiones >= 60
                          and intensidad_valor == 1) or (
                              usuario.frecuencia_semanal >= 5
                              and usuario.duracion_sesiones <= 60
                              and intensidad_valor == 2
                          ) or (usuario.frecuencia_semanal == 4
                                and usuario.duracion_sesiones <= 60
                                and intensidad_valor >= 2) or (
                                    usuario.frecuencia_semanal >= 4
                                    and 30 <= usuario.duracion_sesiones <= 45
                                    and intensidad_valor >= 2):
    return 'INTERMEDIO'
"""
