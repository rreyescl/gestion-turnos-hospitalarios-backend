from pydantic import BaseModel
from typing import Optional

class EstadoEmpleado(BaseModel):
    id_estado: Optional[int] = None  # opcional, se autoincrementa
    nombre: str