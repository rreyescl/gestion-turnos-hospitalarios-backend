from typing import Optional
from database import get_connection
import calendar
from datetime import datetime, timedelta, date
from fastapi import APIRouter, HTTPException
from models.generar_turnos_request import GenerarTurnosRequest, Turno, TurnoBase
from utils import seconds_to_time_string, calcular_horas

router = APIRouter(prefix="/turnos", tags=["Turnos"])


@router.get("/")
def listar_turnos(id_unidad: Optional[int] = None,
                  mes: Optional[int] = None,
                  anio: Optional[int] = None):

    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
        SELECT
            id_turno,
            fecha,
            hora_inicio,
            hora_termino,
            cantidad_horas,
            tipo_turno,
            unidad
        FROM vw_turnos
        WHERE 1 = 1
    """

    params = []

    # 🔹 Filtrar por unidad si viene
    if id_unidad:
        query += " AND id_unidad = %s"
        params.append(id_unidad)

    # 🔹 Filtrar por mes y año si vienen
    if mes and anio:
        query += " AND MONTH(fecha) = %s AND YEAR(fecha) = %s"
        params.extend([mes, anio])
    
    cursor.execute(query, params)
    turnos = cursor.fetchall()

    conn.close()
    return turnos



# ----------------------------------------------------
# 📌 Función interna para generar turnos día y noche
# ----------------------------------------------------
def generar_turnos_mes(id_unidad: int, mes: int, anio: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    _, dias_en_mes = calendar.monthrange(anio, mes)
    turnos_generados = 0

    for dia in range(1, dias_en_mes + 1):
        fecha_turno = date(anio, mes, dia)

        # ===========================
        # 1) Verificar turno Día
        # ===========================
        cursor.execute("""
            SELECT id_turno FROM turno
            WHERE fecha = %s AND id_tipo_turno = 1 AND id_unidad = %s
        """, (fecha_turno, id_unidad))
        
        if not cursor.fetchone():
            cursor.execute("""
                INSERT INTO turno (fecha, hora_inicio, hora_termino, cantidad_horas, id_tipo_turno, id_unidad)
                VALUES (
                    %s,
                    '08:00:00',
                    '20:00:00',
                    CASE 
                        WHEN '20:00:00' >= '08:00:00'
                            THEN TIMESTAMPDIFF(HOUR, '08:00:00', '20:00:00')
                        ELSE 
                            TIMESTAMPDIFF(HOUR, '08:00:00', ADDTIME('20:00:00', '24:00:00'))
                    END,
                    1,
                    %s
                )
            """, (fecha_turno, id_unidad))
            turnos_generados += 1

        # ===========================
        # 2) Verificar turno Noche
        # ===========================
        cursor.execute("""
            SELECT id_turno FROM turno
            WHERE fecha = %s AND id_tipo_turno = 2 AND id_unidad = %s
        """, (fecha_turno, id_unidad))

        if not cursor.fetchone():
            cursor.execute("""
                INSERT INTO turno (fecha, hora_inicio, hora_termino, cantidad_horas, id_tipo_turno, id_unidad)
                VALUES (
                    %s,
                    '20:00:00',
                    '08:00:00',
                    CASE 
                        WHEN '08:00:00' >= '20:00:00'
                            THEN TIMESTAMPDIFF(HOUR, '20:00:00', '08:00:00')
                        ELSE 
                            TIMESTAMPDIFF(HOUR, '20:00:00', ADDTIME('08:00:00', '24:00:00'))
                    END,
                    2,
                    %s
                )
            """, (fecha_turno, id_unidad))
            turnos_generados += 1

    conn.commit()
    conn.close()
    return turnos_generados

@router.post("/")
def crear_turno(turno: Turno):
    conn = get_connection()
    cursor = conn.cursor()

    # 👉 calcular cantidad de horas desde Python
    cantidad_horas = calcular_horas(turno.hora_inicio, turno.hora_termino)

    print("DEBUG crear_turno → horas:", cantidad_horas)

    cursor.execute("""
        INSERT INTO turno (fecha, hora_inicio, hora_termino, cantidad_horas, id_tipo_turno, id_unidad)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (
        turno.fecha,
        turno.hora_inicio,
        turno.hora_termino,
        cantidad_horas,
        turno.id_tipo_turno,
        turno.id_unidad
    ))

    conn.commit()
    new_id = cursor.lastrowid
    conn.close()

    return {
        "message": "Turno creado correctamente",
        "id_turno": new_id
    }

# ---------------------------------------
# 🚀 ENDPOINT: Generar turnos del mes
# ---------------------------------------
@router.post("/generar")
def generar_turnos(req: GenerarTurnosRequest):
    # Validaciones básicas
    if req.mes < 1 or req.mes > 12:
        raise HTTPException(status_code=400, detail="Mes inválido. Debe ser entre 1 y 12.")

    if req.anio < 2000 or req.anio > 2100:
        raise HTTPException(status_code=400, detail="Año fuera de rango.")

    try:
        generados = generar_turnos_mes(req.id_unidad, req.mes, req.anio)

        return {
            "message": "Turnos generados correctamente",
            "turnos_insertados": generados,
            "unidad": req.id_unidad,
            "mes": req.mes,
            "anio": req.anio
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al generar turnos: {str(e)}")

        
@router.get("/tipo_turno")
def listar_permisos():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("select * from tipo_turno")
    data = cursor.fetchall()
    conn.close()
    return data        


@router.get("/{id_turno}")
def obtener_permiso(id_turno: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM turno WHERE id_turno = %s", (id_turno,))
    #cursor.execute("select * from vw_empleados where id_empleado = %s",(id_empleado))
    emp = cursor.fetchone()
    conn.close()
    if not emp:
        raise HTTPException(status_code=404, detail="Turno no encontrado")
    return emp  


@router.put("/{id_turno}")
def actualizar_turno(id_turno: int, turno: Turno):
    conn = get_connection()
    cursor = conn.cursor()

    # 👉 Calcular horas ANTES de actualizar
    cantidad_horas = calcular_horas(turno.hora_inicio, turno.hora_termino)

    print("DEBUG cantidad_horas:", cantidad_horas)

    cursor.execute("""
        UPDATE turno 
        SET 
            fecha = %s,
            hora_inicio = %s,
            hora_termino = %s,
            cantidad_horas = %s,
            id_tipo_turno = %s,
            id_unidad = %s
        WHERE id_turno = %s
    """, (
        turno.fecha,
        turno.hora_inicio,
        turno.hora_termino,
        cantidad_horas,
        turno.id_tipo_turno,
        turno.id_unidad,
        id_turno
    ))

    conn.commit()
    conn.close()

    return {"message": "Turno actualizado correctamente"}
