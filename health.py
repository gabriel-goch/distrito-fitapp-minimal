from flask import Blueprint

health_bp = Blueprint('health', __name__)

@health_bp.route('/health')
def health_check():
    return "OK", 200

def register_health_routes(app):
    app.register_blueprint(health_bp)
