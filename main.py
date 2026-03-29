from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import empleados, kpis, cargos, unidad_hospitalaria, estado_empleados, permiso, turnos

app = FastAPI(title="API Gestión de Turnos Hospitalarios")

# 👇 Permitir solicitudes desde el front
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:4200"],  # 🔹 tu app Angular
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(empleados.router)
app.include_router(kpis.router)
app.include_router(cargos.router)
app.include_router(unidad_hospitalaria.router)
app.include_router(estado_empleados.router)
app.include_router(permiso.router)
app.include_router(turnos.router)
