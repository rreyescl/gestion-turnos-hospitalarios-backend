from pydantic import BaseModel
from typing import Optional

class UnidadHospitalaria(BaseModel):
    id_unidad: Optional[int] = None  # opcional, se autoincrementa
    nombre: str
    descripcion: str
