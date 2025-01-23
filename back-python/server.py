from flask import Flask, request, jsonify
import config  # Assurez-vous que config est importé correctement
from app import main
from app import mainGender as mg
from app import mainFouine as mf
from datetime import datetime, timedelta


app = Flask(__name__)
last_access = None
last_movie = None

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

@app.route('/recoUser', methods=['POST'])
def recoUser():
    
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided"}), 400

    try:
        # Appeler la fonction principale (à adapter selon la structure de ton code)
        resultat = main.MainFunction(data)  # Assurez-vous que MainFunction prend les bons paramètres si nécessaire
        print("résultat renvoyé")
        print(resultat)
        return jsonify({'resultat renvoyé': resultat})
    except Exception as e:
        return jsonify({'error': str(e)}), 506 # En cas d'erreur, retourne un message d'erreur avec le statut 500
       
# Routes en GET
@app.route('/recoFouineDay', methods=['GET'])
def reco_fouine():
    global last_access
    global last_movie
    current_time = datetime.now()

    # Vérifier si l'endpoint a été utilisé dans les dernières 24 heures
    if last_access and current_time - last_access < timedelta(hours=24):
        result = {
        "resultat renvoyé": [last_movie]
        }
        return result
    
    else : 
        random_genre = mf.mainFouine()
        result = {
        "resultat renvoyé": [random_genre]
        }
        last_movie = random_genre
        last_access = current_time
        return result

@app.route('/recoFouineGenre', methods=['GET'])
def reco_fouine_genre():
    
    random_genre = mf.MainFouineGenre()
    result = {
    "resultat renvoyé": [random_genre]
    }
    
    return result


# Routes de test
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
    app.run(debug=False, ssl_context=ssl_context)
