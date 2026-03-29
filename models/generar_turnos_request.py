from datetime import date
from pydantic import BaseModel
from typing import Optional

class GenerarTurnosRequest(BaseModel):
    id_unidad: int
    mes: int
    anio: int

class TurnoBase(BaseModel):
    fecha: date
    hora_inicio: str
    hora_termino: str
    cantidad_horas: int
    id_tipo_turno: int
    id_unidad: int


class Turno(TurnoBase):
    id_turno: int