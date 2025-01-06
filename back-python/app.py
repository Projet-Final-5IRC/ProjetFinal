from flask import Flask
from app.routes import api

app = Flask(__name__)

# Enregistrement du blueprint API
app.register_blueprint(api)

# Lancement de l'application
if __name__ == '__main__':
    app.run(debug=True)
