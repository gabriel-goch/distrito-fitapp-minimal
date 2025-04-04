import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase

class Base(DeclarativeBase):
    pass

db = SQLAlchemy(model_class=Base)
app = Flask(__name__)

# Configuración básica
app.secret_key = os.environ.get("SESSION_SECRET", "desarrollo-secreto")
app.config["SQLALCHEMY_DATABASE_URI"] = os.environ.get("DATABASE_URL")
app.config["SQLALCHEMY_ENGINE_OPTIONS"] = {
    "pool_recycle": 300,
    "pool_pre_ping": True,
}

# Endpoint de health check
@app.route('/health')
def health():
    return "OK", 200

# Inicializar DB
db.init_app(app)

with app.app_context():
    try:
        # Intentar importar modelos
        import models
        db.create_all()
    except Exception as e:
        print(f"Error al inicializar la base de datos: {e}")
        # Aún así, el endpoint de health funcionará

# Registrar rutas
try:
    from routes import register_routes
    register_routes(app)
except ImportError as e:
    print(f"Error al registrar rutas: {e}")
