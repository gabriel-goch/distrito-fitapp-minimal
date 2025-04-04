# health.py
from flask import Flask

health_app = Flask(__name__)

@health_app.route('/health')
def health():
    return "OK", 200

if __name__ == "__main__":
    health_app.run(host="0.0.0.0", port=5000)
