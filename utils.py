from datetime import datetime, timedelta

def seconds_to_time_string(seconds: int) -> str:
    h = seconds // 3600
    m = (seconds % 3600) // 60
    s = seconds % 60
    return f"{h:02d}:{m:02d}:{s:02d}"


def calcular_horas(hora_inicio: str, hora_termino: str) -> float:
    """Calcula diferencia en horas entre dos horarios HH:MM:SS."""

    formato = "%H:%M:%S"

    hi = datetime.strptime(hora_inicio, formato)
    ht = datetime.strptime(hora_termino, formato)

    # Si la hora de término es menor → cruza medianoche
    if ht < hi:
        ht += timedelta(days=1)

    diff = ht - hi
    return diff.total_seconds() / 3600