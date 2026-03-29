from fastapi import APIRouter, HTTPException
from database import get_connection
from models.empleado_model import Empleado

router = APIRouter(prefix="/empleados", tags=["Empleados"])

@router.get("/")
def listar_empleados():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("select * from vw_empleados")
    data = cursor.fetchall()
    conn.close()
    return data

# 🔹 Crear empleado
@router.post("/")
def crear_empleado(emp: Empleado):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO empleado (nombre, apellido, rut, id_cargo, id_unidad,id_estado)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (emp.nombre, emp.apellido, emp.rut, emp.id_cargo, emp.id_unidad, emp.id_estado))
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    return {"message": "Empleado creado", "id_empleado": new_id}

# 🔹 Obtener empleado por ID
@router.get("/{id_empleado}")
def obtener_empleado(id_empleado: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM empleado WHERE id_empleado = %s", (id_empleado,))
    #cursor.execute("select * from vw_empleados where id_empleado = %s",(id_empleado))
    emp = cursor.fetchone()
    conn.close()
    if not emp:
        raise HTTPException(status_code=404, detail="Empleado no encontrado")
    return emp

# 🔹 Actualizar empleado
@router.put("/{id_empleado}")
def actualizar_empleado(id_empleado: int, emp: Empleado):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE empleado 
        SET nombre=%s, apellido=%s, rut=%s, id_cargo=%s, id_unidad=%s, id_estado=%s
        WHERE id_empleado=%s
    """, (emp.nombre, emp.apellido, emp.rut, emp.id_cargo, emp.id_unidad,emp.id_estado, id_empleado))
    conn.commit()
    conn.close()
    return {"message": "Empleado actualizado correctamente"}

# 🔹 Eliminar empleado
@router.delete("/{id_empleado}")
def eliminar_empleado(id_empleado: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM empleado WHERE id_empleado = %s", (id_empleado,))
    conn.commit()
    conn.close()
    return {"message": "Empleado eliminado correctamente"}
