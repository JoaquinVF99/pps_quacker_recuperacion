# Primera fase: instalar dependencias
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .
COPY service/ .
COPY model/ .
COPY dao/ .
COPY static/ .
COPY templates/ .
COPY app.py .
COPY mongo.py .
RUN pip install --no-cache-dir -r requirements.txt

# Segunda fase: ejecutar la aplicación
FROM python:3.11-slim

WORKDIR /app

# Copiar archivos de la aplicación desde la primera fase
COPY --from=builder /app .

# Instalar Flask y pymongo
RUN pip install --no-cache-dir flask pymongo

# Establecer las variables de entorno necesarias
ENV MONGO_IP=mongo
ENV MONGO_PORT=27017

# Exponer el puerto 5000
EXPOSE 5000

# Ejecutar la aplicación
CMD ["python3", "app.py"]
