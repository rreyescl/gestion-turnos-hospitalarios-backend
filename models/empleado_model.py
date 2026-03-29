from pydantic import BaseModel
from typing import Optional

class Empleado(BaseModel):
    id_empleado: Optional[int] = None  # opcional, se autoincrementa
    nombre: str
    apellido: str
    rut: str
    id_cargo: Optional[int] = None
    id_unidad: Optional[int] = None
    id_estado: Optional[int] = None
