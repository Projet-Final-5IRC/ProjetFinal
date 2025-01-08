import os
import pandas as pd
import json
import random

# Traitement des données
def traitement_like(entry_data, entry_json, exitData) :
    
    label_existe = ["user"]["likes"] in entry_json    
    if label_existe:
        # Extraire la valeur de la clé "likes"
        likes_str = entry_json["user"]["likes"]
        likes_list = list(map(int, likes_str.split(',')))
        if len(likes_list) != 0:
            for i in range(len(likes_list)) :
                    
                    numberLike = likes_list[i]
                    # print(numberLike)
                    # Ouvrir les données du film correspondant
                    row = entry_data.iloc[numberLike]

                    # Ajouter les données formatées à la liste des données
                    new_entry_data = {"year": str(row['Year'].values[i]), "make": str(row['Year'].values[i])}
                    exitData.append(new_entry_data)
        else:
            print("Pas de like de cet utilisateur, recommandation aléatoire.")
            # Mettre un résultat aléatoire
            movie_size_len = len(entry_data['idMovie'])
            random_float_range = random.uniform(0, movie_size_len)
            # Retourner les données d'un film au hasard qu'on proposera
        return exitData
    else:
        print("Pas de like de cet utilisateur, recommandation aléatoire.")
        # Mettre un résultat aléatoire
        movie_size_len = len(entry_data['idMovie'])
        random_float_range = random.uniform(0, movie_size_len)
        # Retourner les données d'un film au hasard qu'on proposera
    return exitData

def traitement_movie(entry_data, exitData) :
    for i in range(len(entry_data)) :

            row = entry_data.iloc[i]

            # Ajouter les données formatées à la liste des données
            new_entry_data = {"year": str(row['Year'].values[i]), "make": str(row['Year'].values[i])}
            exitData.append(new_entry_data)
    return exitData

### Lire un json###
def lire_json(chemin_fichier):
    try:
        with open(chemin_fichier, "r", encoding="utf-8") as fichier:
            data = json.load(fichier)
            print("--> Fichier d'entrée correcte \n")
            return data
        
    except Exception as e:
        print(f"Une erreur inattendue s'est produite, lors de la lecture du fichier json:\n {e}")
        return None
    
### Lire plusieurs csv ###
def lire_dossier_csv(dossier):
    # Liste pour stocker les DataFrames
    dataframes = []

    # Parcourir tous les fichiers dans le dossier
    for fichier in os.listdir(dossier):
        if fichier.endswith('.csv'):
            chemin_fichier = os.path.join(dossier, fichier)
            df = pd.read_csv(chemin_fichier)
            dataframes.append(df)

    return dataframes

# # Exemple d'utilisation
# dossier = '../../data/Movies'
# dataframes = lire_fichiers_csv(dossier)

# # Afficher les DataFrames lus
# for i, df in enumerate(dataframes):
#     print(f"DataFrame {i+1}:")
#     print(df.head())
#     print("\n")

# Ne lire que 1 fichier
def lire_fichier_csv(chemin_fichier):
    # Lire le fichier CSV
    df = pd.read_csv(chemin_fichier)
    return df