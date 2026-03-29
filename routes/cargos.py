from fastapi import APIRouter, HTTPException
from database import get_connection
from models.cargo_model import Cargo

router = APIRouter(prefix="/cargos", tags=["Cargos"])

@router.get("/")
def listar_cargos():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("select * from cargo")
    data = cursor.fetchall()
    conn.close()
    return data

# 🔹 Crear cargo
@router.post("/")
def crear_cargo(cargo: Cargo):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""INSERT INTO cargo (nombre)
                   VALUES (%s)
                   """, (cargo.nombre,)) #si es solo un elemento, se pone una coma al unico campo que se va a ingresar
    conn.commit()
    new_id = cursor.lastrowid
    conn.close()
    return {"message": "Cargo creado", "id_cargo": new_id}

# 🔹 Obtener cargo por ID
@router.get("/{id_cargo}")
def obtener_cargo(id_cargo: int):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM cargo WHERE id_cargo = %s", (id_cargo,))
    #cursor.execute("select * from vw_empleados where id_empleado = %s",(id_empleado))
    emp = cursor.fetchone()
    conn.close()
    if not emp:
        raise HTTPException(status_code=404, detail="Cargo no encontrado")
    return emp

# 🔹 Actualizar cargo
@router.put("/{id_cargo}")
def actualizar_cargo(id_cargo: int, cargo: Cargo):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE cargo 
        SET nombre=%s
        WHERE id_cargo=%s
    """, (cargo.nombre,id_cargo))
    conn.commit()
    conn.close()
    return {"message": "Cargo actualizado correctamente"}

# 🔹 Eliminar cargo
@router.delete("/{id_cargo}")
def eliminar_cargo(id_cargo: int):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM cargo WHERE id_cargo = %s", (id_cargo,))
    conn.commit()
    conn.close()
    return {"message": "Cargo eliminado correctamente"}

