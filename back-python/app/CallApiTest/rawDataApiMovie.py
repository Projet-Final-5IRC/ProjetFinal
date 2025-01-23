import json
import os
import requests
from dotenv import load_dotenv

# Charger les variables d'environnement depuis le fichier .env
load_dotenv()

# Récupérer la clé API depuis les variables d'environnement
api_key = os.getenv("API_KEY")

# Chemin complet du fichier JSON
chemin_complet = '../../data/Movies/gender.json'

# URL de l'API pour récupérer les genres de films
url = f"https://api.themoviedb.org/3/genre/movie/list?language=en&api_key={api_key}"
headers = {"accept": "application/json"}

# Faire la requête à l'API
response = requests.get(url, headers=headers)

# Vérifier si la requête a réussi
if response.status_code == 200:
    # Extraire les données JSON de la réponse
    genres = response.json()

    # Écrire le JSON dans le fichier
    with open(chemin_complet, 'w') as fichier:
        json.dump(genres, fichier, indent=4)

    print(f"Le fichier JSON a été créé à l'emplacement : {chemin_complet}")
else:
    print(f"Erreur lors de la requête à l'API : {response.status_code}")
    print(f"Message d'erreur : {response.text}")
