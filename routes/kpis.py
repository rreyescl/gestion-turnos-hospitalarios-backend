from fastapi import APIRouter
from database import get_connection

router = APIRouter(prefix="/kpi", tags=["Kpis"])

@router.get("/unidades")
def kpi_unidades():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("select * from vw_kpi_unidades")
    data = cursor.fetchall()
    conn.close()
    return data

@router.get("/tasa_de_reemplazos")
def kpi_tasa_de_reemplazos():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("select * from vw_kpi_tasa_de_reemplazos")
    data = cursor.fetchall()
    conn.close()
    return data

@router.get("/reemplazos_cruzados_entre_unidades")
def kpi_reemplazos_cruzados_entre_unidades():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("select * from vw_kpi_reemplazos_cruzados_entre_unidades")
    data = cursor.fetchall()
    conn.close()
    return data