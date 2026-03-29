Aquí tienes el **README.md** actualizado. He incluido una sección específica para configurar el entorno virtual de Python (`venv`), que es la buena práctica estándar para aislar las dependencias de tu proyecto de gestión de turnos.

Copia y pega este contenido en la raíz de tu proyecto:

-----

# 🏥 Sistema de Gestión de Turnos Hospitalarios

Este proyecto se divide en dos componentes principales: la infraestructura de servicios (Docker) y la lógica de negocio (Python Backend).

## 📋 Requisitos Previos

  * **Docker Desktop**: [Instalar aquí](https://www.docker.com/products/docker-desktop/). (Asegúrate de que esté abierto antes de empezar).
  * **Python 3.10+**: Instalado en tu sistema local.
  * **Terminal**: Terminal (Mac) o PowerShell (Windows).

-----

## 🚀 Guía de Inicio Rápido

### Paso 1: Levantar la Infraestructura (Docker)

Primero, debemos encender la base de datos y el servidor web.

1.  Abre la terminal y entra a la carpeta de Docker:
    ```bash
    cd gestion-turnos-hospitalarios-docker
    ```
2.  Levanta los contenedores:
    ```bash
    docker compose up -d
    ```
3.  Verifica que todo esté corriendo en [http://localhost:8080/phpmyadmin/](https://www.google.com/search?q=http://localhost:8080/phpmyadmin/).

-----

### Paso 2: Configurar el Backend (Python)

Ahora configuraremos el entorno para que el código Python pueda ejecutarse.

1.  Abre una **nueva pestaña** en tu terminal y ve a la carpeta del backend:

    ```bash
    cd ../gestion-turnos-hospitalarios-backend
    ```

2.  **Crear el entorno virtual (`venv`)**:

      * **En Mac:**
        ```bash
        python3 -m venv venv
        ```
      * **En Windows:**
        ```bash
        python -m venv venv
        ```

3.  **Activar el entorno virtual**:

      * **En Mac:**
        ```bash
        source venv/bin/activate
        ```
      * **En Windows:**
        ```bash
        .\venv\Scripts\activate
        ```

4.  **Instalar dependencias**:

    ```bash
    pip install --upgrade pip
    pip install -r requirements.txt
    ```

5.  **Ejecutar el servidor de desarrollo**:

    ```bash
    python main.py
    ```

-----

## ⚙️ Configuración de Conexión (Importante)

Para que tu código Python se conecte a la base de datos de Docker, utiliza estos parámetros en tu archivo de configuración o `.env`:

| Parámetro | Valor |
| :--- | :--- |
| **Host** | `127.0.0.1` o `localhost` |
| **Puerto** | `3306` |
| **Usuario** | `root` |
| **Contraseña** | `root_password` |
| **Base de Datos** | `gestion_turnos` |

-----

## 🛠 Comandos de Mantenimiento

### Docker

  * **Ver logs de la DB**: `docker compose logs -f db`
  * **Apagar todo**: `docker compose down`
  * **Reiniciar servicios**: `docker compose restart`

### Python

  * **Desactivar entorno virtual**: `deactivate`
  * **Congelar nuevas librerías**: `pip freeze > requirements.txt`

-----

## 🌐 Direcciones Útiles

  * **Servidor Apache**: [http://localhost](https://www.google.com/search?q=http://localhost)
  * **phpMyAdmin**: [http://localhost:8080/phpmyadmin/](https://www.google.com/search?q=http://localhost:8080/phpmyadmin/)

-----

Con esto, cualquier persona que reciba tu proyecto (incluyéndote en el futuro) podrá levantarlo en menos de 5 minutos. ¿Hay alguna librería específica de Python que estés usando para la conexión (como `mysql-connector` o `SQLAlchemy`) sobre la que tengas dudas?