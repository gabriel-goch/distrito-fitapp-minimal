FROM python:3.9-slim

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements.txt
COPY requirements.txt .

# Instalar dependencias Python
RUN pip install --no-cache-dir -r requirements.txt

# Crear el archivo health.py
RUN echo 'from flask import Flask\n\nhealth_app = Flask(__name__)\n\n@health_app.route("/health")\ndef health():\n    return "OK", 200\n\nif __name__ == "__main__":\n    health_app.run(host="0.0.0.0", port=5000)' > health.py

# Copiar todos los demás archivos
COPY . .

# Variables de entorno
ENV PORT=5000
ENV PYTHONUNBUFFERED=1

# Exponer puerto
EXPOSE 5000

# Comando de inicio
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "--timeout", "300", "--workers", "1", "health:health_app"]
