import requests
import os
from dotenv import load_dotenv
import json
import random


#### Fonction dla fouine ###
def CallMovieFouine():
    load_dotenv()
    api_key = os.getenv("API_KEY")
    # Liste des genre
    chemin_genres = 'data/Movies/gender.json'
    with open(chemin_genres, 'r') as fichier:
        genres_data = json.load(fichier)
        
    random_genre = int(random.choice(genres_data['Genre'])['id'])
    # requête
    url = f"https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&sort_by=original_title.asc&with_genres={random_genre}&api_key={api_key}"
    headers = {"accept": "application/json"} 

    response = requests.get(url, headers=headers)
    data = response.json()
    results_data = data['results']
    
    original_titles = [result['original_title'] for result in results_data if result.get('original_title')]
    random_titles = random.sample(original_titles, min(1, len(original_titles)))
    
    return random_titles

def CallMovieFouineGender():
    # Liste des genre
    chemin_genres = 'data/Movies/gender.json'
    with open(chemin_genres, 'r') as fichier:
        genres_data = json.load(fichier)
    # 1 genre au hasard
    # requête sur l'api
    # traitement du résultat et retour 
    random_genre = random.choice(genres_data['Genre'])['name']
    
    return random_genre

### Trouver les ids par genre après ca marchera
def CallFounIdPerGender(input_json):
    def clean_genre_name(name):
        return name.replace(" Movies", "").replace(" Comedies", "")

    chemin_genres = 'data/Movies/gender.json'
    with open(chemin_genres, 'r') as fichier:
        genres_data = json.load(fichier)

    genres_list = genres_data['Genre']
    genre_names_list = input_json['Genre']
    genre_id_map = {genre['name']: genre['id'] for genre in genres_list}
    ids_list = [genre_id_map[clean_genre_name(name)] for name in genre_names_list if clean_genre_name(name) in genre_id_map]

    print("Liste des Ids : \n")
    print(ids_list)
    print("-----------------------------------")
    return ids_list
    
# Deuxième call api qui va lui nous retourner une liste de film selon les genres
def CallApiMoviePerGender(input_json):
    # Faudra crypter la clé
    load_dotenv()
    api_key = os.getenv("API_KEY")
    
    listId = CallFounIdPerGender(input_json)
    
    # Convertir chaque élément de la liste en chaîne de caractères
    listId_str = [str(id) for id in listId]
    # Joindre les éléments avec une virgule comme séparateur
    listId_str = ','.join(listId_str)
    
    # Film ayant tous les critères
    url = f"https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&sort_by=original_title.asc&with_genres={listId_str}&api_key={api_key}"
    # url = f"https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&sort_by=original_title.asc&with_genres=28,878&api_key={api_key}"

    headers = {"accept": "application/json"}  # En-tête approprié

    response = requests.get(url, headers=headers)
    
     # Convertir la réponse en JSON
    data = response.json()
    results_data = data['results']
    

    original_titles = [result['original_title'] for result in results_data if result.get('original_title')]
    random_titles = random.sample(original_titles, min(3, len(original_titles)))
    
    return random_titles

#### TEST ####
# chemin_genre_names = '../../data/Movies/MovieGender.json'
# # Lire le deuxième fichier JSON contenant uniquement les noms des genres
# with open(chemin_genre_names, 'r') as fichier:
#     input_json = json.load(fichier)

# result = CallApiMoviePerGender(input_json)

# print("Retour de la fonction : \n")
# print(result)
# print("-----------------------------------")
