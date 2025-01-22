import requests
import json

chemin_genre_names = '../../data/Movies/MovieGender.json'
# Lire le deuxième fichier JSON contenant uniquement les noms des genres
with open(chemin_genre_names, 'r') as fichier:
    genre_names_data = json.load(fichier)
# Input 
#############################################
# Chemin des fichiers JSON
chemin_genres = '../../data/Movies/gender.json'
# Lire le premier fichier JSON contenant les genres avec leurs IDs
with open(chemin_genres, 'r') as fichier:
    genres_data = json.load(fichier)

# Extraire les listes de genres et de noms de genres
genres_list = genres_data['gender']
genre_names_list = genre_names_data['gender']

# Créer un dictionnaire pour mapper les noms de genres aux IDs
genre_id_map = {genre['name']: genre['id'] for genre in genres_list}

# Fonction pour nettoyer les noms de genres
def clean_genre_name(name):
    return name.replace(" Movies", "").replace(" Comedies", "")

# Créer une liste des IDs correspondant aux noms des genres du deuxième fichier
ids_list = [genre_id_map[clean_genre_name(name)] for name in genre_names_list if clean_genre_name(name) in genre_id_map]

# Afficher la liste des IDs
print(ids_list)
