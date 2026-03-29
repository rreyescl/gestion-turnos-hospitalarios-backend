from fastapi import APIRouter, HTTPException
from database import get_connection
from models.permiso_model import Permiso

router = APIRouter(prefix="/permisos", tags=["Permisos"])

@router.get("/")
def listar_permisos():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("select * from permiso")
    data = cursor.fetchall()
    conn.close()
    return data

# 🔹 Crear permiso
@router.post("/")
def crear_permiso(permiso: Permiso):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""INSERT INTO permiso (tipo_permiso, descripcion, color_hex)
                   VALUES (%s, %s,%s)
                   """, (permiso.tipo_permiso,permiso.descripcion, permiso.color_hex)) #si es solo un elemento, se pone una coma al unico campo que se va a ingresar
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    return {"message": "Permiso creado", "id_permiso": new_id}

# 🔹 Obtener permiso por ID
@router.get("/{id_permiso}")
def obtener_permiso(id_permiso: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM permiso WHERE id_permiso = %s", (id_permiso,))
    #cursor.execute("select * from vw_empleados where id_empleado = %s",(id_empleado))
    emp = cursor.fetchone()
    conn.close()
    if not emp:
        raise HTTPException(status_code=404, detail="Permiso no encontrado")
    return emp

# 🔹 Actualizar permiso
@router.put("/{id_permiso}")
def actualizar_permiso(id_permiso: int, permiso: Permiso):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE permiso 
        SET tipo_permiso=%s, descripcion=%s, color_hex=%s
        WHERE id_permiso=%s
    """, (permiso.tipo_permiso,permiso.descripcion, permiso.color_hex,id_permiso))
    conn.commit()
    conn.close()
    return {"message": "Permiso actualizado correctamente"}

# 🔹 Eliminar permiso
@router.delete("/{id_permiso}")
def eliminar_permiso(id_permiso: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM permiso WHERE id_permiso = %s", (id_permiso,))
    conn.commit()
    conn.close()
    return {"message": "Permiso eliminado correctamente"}

