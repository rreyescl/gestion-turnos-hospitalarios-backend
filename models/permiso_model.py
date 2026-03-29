from pydantic import BaseModel
from typing import Optional

class Permiso(BaseModel):
    id_permiso: Optional[int] = None
    tipo_permiso: str
    descripcion: str
    color_hex: str
