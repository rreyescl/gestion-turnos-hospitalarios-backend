from fastapi import APIRouter, HTTPException
from database import get_connection
from models.estado_empleado_model import EstadoEmpleado

router = APIRouter(prefix="/estado_empleados", tags=["Estado Empleados"])

@router.get("/")
def listar_estados_empleados():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("select * from estado_empleado")
    data = cursor.fetchall()
    conn.close()
    return data

# 🔹 Crear estado empleado
@router.post("/")
def crear_estado_empleado(estado_empleado: EstadoEmpleado):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""INSERT INTO estado_empleado (nombre)
                   VALUES (%s)
                   """, (estado_empleado.nombre,)) #si es solo un elemento, se pone una coma al unico campo que se va a ingresar
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    return {"message": "Estado empleado creado", "id_estado": new_id}

# 🔹 Obtener estado por ID
@router.get("/{id_estado}")
def obtener_estado_empleado(id_estado: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM estado_empleado WHERE id_Estado = %s", (id_estado,))
    #cursor.execute("select * from vw_empleados where id_empleado = %s",(id_empleado))
    emp = cursor.fetchone()
    conn.close()
    if not emp:
        raise HTTPException(status_code=404, detail="Estado empleado no encontrado")
    return emp

# 🔹 Actualizar estado empleado
@router.put("/{id_estado}")
def actualizar_estado_empleado(id_estado: int, estado_empleado: EstadoEmpleado):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE estado_empleado 
        SET nombre=%s
        WHERE id_estado=%s
    """, (estado_empleado.nombre,id_estado))
    conn.commit()
    conn.close()
    return {"message": "Estado empleado actualizado correctamente"}

# 🔹 Eliminar estado_empleado
@router.delete("/{id_estado}")
def eliminar_estado_empleado(id_estado: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM estado_empleado WHERE id_estado = %s", (id_estado,))
    conn.commit()
    conn.close()
    return {"message": "Estado empleado eliminado correctamente"}

