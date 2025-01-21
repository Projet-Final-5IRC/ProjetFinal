from flask import Flask, request, jsonify
import config 
from app import main
from app import mainGender as mg
# packages
# import pandas as pd
# import json
# from unittest import result
# import random
# import numpy as np
# from sklearn.preprocessing import LabelEncoder
# from sklearn.ensemble import RandomForestClassifier
# from sklearn.metrics import accuracy_score

# import os
# import pandas as pd
# import json
# import random

app = Flask(__name__)

# Routes en POST
@app.route('/recoGender', methods=['POST'])
def recoGender():
    
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400

    try:
        # Appeler la fonction principale (à adapter selon la structure de ton code)
        resultat = mg.mainGender(data)  # Assurez-vous que MainFunction prend les bons paramètres si nécessaire
        print("résultat renvoyé")
        print(resultat)
        return jsonify({'resultat renvoyé': resultat})
    except Exception as e:
        return jsonify({'error': str(e)}), 506 # En cas d'erreur, retourne un message d'erreur avec le statut 500
    
# Routes en GET
@app.route('/recoUser', methods=['GET'])
def reco_user():

    try:
        # Appeler la fonction principale (à adapter selon la structure de ton code)
        resultat = main.MainFunction()  # Assurez-vous que MainFunction prend les bons paramètres si nécessaire
        print("résultat renvoyé")
        print(resultat)
        return jsonify({'resultat renvoyé': resultat})
    except Exception as e:
        return jsonify({'error': str(e)}), 506 # En cas d'erreur, retourne un message d'erreur avec le statut 500

@app.route('/recoGender', methods=['GET'])
def reco_gender():

    try:
        # Appeler la fonction principale (à adapter selon la structure de ton code)
        resultat = mg.mainGender()  # Assurez-vous que MainFunction prend les bons paramètres si nécessaire
        print("résultat renvoyé")
        print(resultat)
        return jsonify({'resultat renvoyé': resultat})
    except Exception as e:
        return jsonify({'error': str(e)}), 506 # En cas d'erreur, retourne un message d'erreur avec le statut 500

# Lancement de l'application
if __name__ == '__main__':
    ssl_context = ('cert.pem', 'key.pem')
    app.run(debug=True, port=5001, ssl_context=ssl_context)