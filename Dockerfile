FROM python:3.9-slim

WORKDIR /app

# Copiar solo lo esencial
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY main.py .

# Configurar variables y puerto
ENV PORT=5000
EXPOSE 5000

# Iniciar directamente con gunicorn (no script intermedio)
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 main:app
