from fastapi import APIRouter, HTTPException
from database import get_connection
from models.unidad_hospitalaria_model import UnidadHospitalaria

router = APIRouter(prefix="/unidad_hospitalaria", tags=["Unidad Hospitalaria"])

@router.get("/")
def listar_unidad_hospitalaria():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("select * from unidad_hospitalaria")
    data = cursor.fetchall()
    conn.close()
    return data

# 🔹 Crear unidad hospitalaria
@router.post("/")
def crear_unidad_hospitalaria(unidad_hospitalaria: UnidadHospitalaria):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""INSERT INTO unidad_hospitalaria (nombre, descripcion)
                   VALUES (%s, %s)
                   """, (unidad_hospitalaria.nombre,unidad_hospitalaria.descripcion)) #si es solo un elemento, se pone una coma al unico campo que se va a ingresar
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    return {"message": "Unidad hospitalaria creado", "id_unidad": new_id}


# 🔹 Obtener permiso por ID
@router.get("/{id_unidad}")
def obtener_unidad_hospitalaria(id_unidad: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM unidad_hospitalaria WHERE id_unidad = %s", (id_unidad,))
    #cursor.execute("select * from vw_empleados where id_empleado = %s",(id_empleado))
    emp = cursor.fetchone()
    conn.close()
    if not emp:
        raise HTTPException(status_code=404, detail="Unidad hospitalaria no encontrada")
    return emp

# 🔹 Actualizar permiso
@router.put("/{id_permiso}")
def actualizar_unidad_hospitalaria(id_unidad: int, unidad_hospitalaria: UnidadHospitalaria):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE unidad_hospitalaria 
        SET nombre=%s,
        descripcion=%s
        WHERE id_unidad=%s
    """, (unidad_hospitalaria.nombre,unidad_hospitalaria.descripcion,id_unidad))
    conn.commit()
    conn.close()
    return {"message": "Unidad Hospitalaria actualizado correctamente"}

# 🔹 Eliminar permiso
@router.delete("/{id_unidad}")
def eliminar_unidad_hospitalaria(id_unidad: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM unidad_hospitalaria WHERE id_unidad = %s", (id_unidad,))
    conn.commit()
    conn.close()
    return {"message": "Unidad Hospitalaria eliminada correctamente"}