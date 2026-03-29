from pydantic import BaseModel
from typing import Optional

class Cargo(BaseModel):
    id_cargo: Optional[int] = None  # opcional, se autoincrementa
    nombre: str