import os
from flask import Flask

app = Flask(__name__)

@app.route('/health')
def health():
    return "OK", 200

# Importar las rutas de la aplicación después de crear la instancia de Flask
try:
    from routes import register_routes
    register_routes(app)
except ImportError:
    # Si falla, al menos tendremos el endpoint de health
    pass

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=False)
