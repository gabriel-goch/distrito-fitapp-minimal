FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
COPY health.py .

RUN pip install --no-cache-dir flask gunicorn

ENV PORT=5000
ENV PYTHONUNBUFFERED=1

EXPOSE 5000

# Comando más simple posible
CMD exec gunicorn --bind 0.0.0.0:$PORT --timeout 300 --workers 1 health:health_app
EXPOSE 5000

# Iniciar la aplicación
CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 120 main:app
