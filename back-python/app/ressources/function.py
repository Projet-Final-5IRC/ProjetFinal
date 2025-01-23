import os
import pandas as pd
import json
import random
import requests
from dotenv import load_dotenv



### Call api film #################
def CallApiMovieRandom():
    
    try:  
        load_dotenv()
        api_key = os.getenv("API_KEY")

        url = f"https://api.themoviedb.org/3/movie/changes?page=1&api_key={api_key}"
        headers = {"accept": "application/json"}  # En-tête approprié

        response = requests.get(url, headers=headers)

        print("Call Api Movie Ok")  
        return response
    
    except Exception as e:
        print("Call Api Movie Ko") 
        return jsonify({'error': str(e)}), 507 # En cas d'erreur, retourne un message d'erreur avec le statut 500

# Traitement des données
def mef_like_user(entry_data, search_id) :
    # ID que nous cherchons
    # search_id = "862"  # ID à chercher dans les éléments
    # Filtrer les données pour obtenir l'élément avec le bon ID
    result = [item for item in entry_data if item["id"] == search_id]
    # if result:
    #     print("Fonctionne mef")
    #     #print(json.dumps(result[0], indent=4)) 
    # else:
    #     print("Aucun élément trouvé avec l'ID", search_id)
    return result

# topic_list = [
#     "adult", "budget", "genres", "id", "original_language", "original_title",
#     "popularity", "production_companies", "production_countries", "release_date",
#     "revenue", "runtime", "status", "title", "vote_average", "vote_count"
#     ]

def traitement_seen(entry_data, entry_json, exitData):
    
    topic_list = [
        "adult", "id", "revenue", "runtime"
    ]
    resultLikes = []
    likes_str = entry_json.get("likes", "")
    likes_list = list(map(int, likes_str.split(',')))  # Conversion en liste d'entiers
    # print("Like liste : \n")
    # print(likes_list)
    # Vérification de 'likes_str'
    seen_str = entry_json.get("seen", "")
    if not seen_str:
        print("Pas de films vus pour cet utilisateur, choix aléatoire")
        # Choisir 3 ids au hasard et les ranger dans une liste
        ids = [item['id'] for item in entry_data]
        random_list = random.sample(ids, 3)
        # print("random list")
        # print(random_list)
        if random_list:  # Vérification que la liste n'est pas vide
            # print("On rentre dans la boucle random_list")
            for i in range(len(random_list)):
                numberSeen = random_list[i]
                # print(f"numberSeen : {numberSeen}")
                new_entry_data = {}
                
                # Ouvrir les données du film correspondant
                result = mef_like_user(entry_data, str(numberSeen))
                # print(f"Résultat pour le film {numberSeen}: {result}")
                
                if result:
                    # On suppose que result est une liste contenant un dictionnaire
                    film_data = result[0]  # Prendre le premier dictionnaire de la liste
                    # print(f"Données du film récupérées : {film_data}")
                    
                    # Récupérer les données pertinentes de l'image
                    for topic in topic_list:
                        if topic in film_data:
                            new_entry_data[topic] = film_data.get(topic)
                            # print(f"{topic} ajouté depuis film_data")
                        elif topic in entry_data:
                            new_entry_data[topic] = entry_data.get(topic)
                            # print(f"{topic} ajouté depuis entry_data")
                    
                    # Ajouter les données formatées à la liste des données
                    new_entry_data = {"year": str(row['Year'].values[i]), "make": str(row['Year'].values[i])}
                    exitData.append(new_entry_data)
                    #print(f"new_entry_data à la fin de la boucle: {new_entry_data}")
                    # print("-----------------------------------")
    
                else:
                    print(f"Le film {numberSeen} n'existe plus.")
        else:
            print("Pas de like de cet utilisateur, recommandation aléatoire.")
            # Mettre un résultat aléatoire
            movie_size_len = len(entry_data['idMovie'])
            random_float_range = random.uniform(0, movie_size_len)
            # Retourner les données d'un film au hasard qu'on proposera
        return exitData

    # print(f"likes_str : {likes_str}")
    seen_list = list(map(int, seen_str.split(',')))  # Conversion en liste d'entiers
    # print(f"likes_list : {likes_list}")
    
    if seen_list:  # Vérification si la liste n'est pas vide
        for i in range(len(seen_list)):
            new_entry_data = {}
            numberSeen = seen_list[i]
            
            # Ouvrir les données du film correspondant
            result = mef_like_user(entry_data, str(numberSeen))
            # print(f"Résultat pour le film {numberSeen}: {result}")
            
            if result:
                film_data = result[0]  # Prendre le premier dictionnaire de la liste
                # print(f"Données du film récupérées : {film_data}")
                
                # Récupérer les données pertinentes de l'image
                for topic in topic_list:
                    if topic in film_data:
                        new_entry_data[topic] = film_data.get(topic)
                        # print(f"{topic} ajouté depuis film_data")
                    elif topic in entry_data:
                        new_entry_data[topic] = entry_data.get(topic)
                        # print(f"{topic} ajouté depuis entry_data")
                
                # Ajouter les données formatées à la liste des données
                exitData.append(new_entry_data)
                #print(f"new_entry_data à la fin de la boucle: {new_entry_data}")
                # print("-----------------------------------")
                # print("entrée : "+str(numberSeen))
                
                # print("Tableau de resul likes : \n")
                # print(resultLikes)  
                like = 0
                for i in range (len(likes_list)):
                    # print("element actuelle de la like list")
                    # print(likes_list[i])
                    if likes_list[i] == numberSeen :
                        like = 1
                #     print("etat de like "+str(like))
                # print("etat final de like "+str(like))
                resultLikes.append(like)   
            else:
                print(f"Le film {numberSeen} n'existe plus.")
    else : 
        print("problème de traitement des likes en entrée")
    return exitData, resultLikes

def traitement_movie(entry_data, exitData) :
    
    topic_list = [
        "adult", "id", "revenue", "runtime"
    ]
    
    # Filtrer les données pour ne garder que les clés dans topic_list
    exitData = [
        {key: item[key] for key in item if key in topic_list}
        for item in entry_data
    ]
    #print("Données filtrées ")

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

# def traitement_like(entry_data, entry_json, exitData):
    
#     topic_list = [
#         "adult", "budget", "genres", "id", "original_language", "original_title",
#         "popularity", "production_companies", "production_countries", "release_date",
#         "revenue", "runtime", "status", "title", "vote_average", "vote_count"
#     ]
   
#     # Vérification de 'likes_str'
#     likes_str = entry_json.get("likes", "")
#     if not likes_str:
#         print("Pas de likes pour cet utilisateur, choix aléatoire")
#         # Choisir 3 ids au hasard et les ranger dans une liste
#         ids = [item['id'] for item in entry_data]
#         random_list = random.sample(ids, 3)
#         # print("random list")
#         # print(random_list)
#         if random_list:  # Vérification que la liste n'est pas vide
#             # print("On rentre dans la boucle random_list")
#             for i in range(len(random_list)):
#                 numberLike = random_list[i]
#                 # print(f"numberLike : {numberLike}")
#                 new_entry_data = {}
                
#                 # Ouvrir les données du film correspondant
#                 result = mef_like_user(entry_data, str(numberLike))
#                 # print(f"Résultat pour le film {numberLike}: {result}")
                
#                 if result:
#                     # On suppose que result est une liste contenant un dictionnaire
#                     film_data = result[0]  # Prendre le premier dictionnaire de la liste
#                     # print(f"Données du film récupérées : {film_data}")
                    
#                     # Récupérer les données pertinentes de l'image
#                     for topic in topic_list:
#                         if topic in film_data:
#                             new_entry_data[topic] = film_data.get(topic)
#                             # print(f"{topic} ajouté depuis film_data")
#                         elif topic in entry_data:
#                             new_entry_data[topic] = entry_data.get(topic)
#                             # print(f"{topic} ajouté depuis entry_data")
                    
#                     # Ajouter les données formatées à la liste des données
#                     exitData.append(new_entry_data)
#                     print(f"new_entry_data à la fin de la boucle: {new_entry_data}")
#                     print("-----------------------------------")
#                 else:
#                     print(f"Le film {numberLike} n'existe plus.")
#         else:
#             print("ERREUR - La liste des numéros aléatoires est vide.")
#         return exitData

#     # print(f"likes_str : {likes_str}")
#     likes_list = list(map(int, likes_str.split(',')))  # Conversion en liste d'entiers
#     # print(f"likes_list : {likes_list}")
    
#     if likes_list:  # Vérification si la liste n'est pas vide
#         for i in range(len(likes_list)):
#             numberLike = likes_list[i]
#             # print(f"numberLike : {numberLike}")
#             new_entry_data = {}
            
#             # Ouvrir les données du film correspondant
#             result = mef_like_user(entry_data, str(numberLike))
#             # print(f"Résultat pour le film {numberLike}: {result}")
            
#             if result:
#                 film_data = result[0]  # Prendre le premier dictionnaire de la liste
#                 # print(f"Données du film récupérées : {film_data}")
                
#                 # Récupérer les données pertinentes de l'image
#                 for topic in topic_list:
#                     if topic in film_data:
#                         new_entry_data[topic] = film_data.get(topic)
#                         # print(f"{topic} ajouté depuis film_data")
#                     elif topic in entry_data:
#                         new_entry_data[topic] = entry_data.get(topic)
#                         # print(f"{topic} ajouté depuis entry_data")
                
#                 # Ajouter les données formatées à la liste des données
#                 exitData.append(new_entry_data)
#                 print(f"new_entry_data à la fin de la boucle: {new_entry_data}")
#                 print("-----------------------------------")
#             else:
#                 print(f"Le film {numberLike} n'existe plus.")
#     else : 
#         print("ERREUR - problème de traitement des likes en entrée")
#     return exitData        

### Films que l'utilisateur à aimé, à modifier pour les films vus
# def traitement_like(entry_data, entry_json, exitData) :
    
#     topic_list = []  # 16 labels  pour les films
#     topic_list.append("adult")
#     topic_list.append("budget")
#     topic_list.append("genres")
#     topic_list.append("id")
#     topic_list.append("original_language")
#     topic_list.append("original_title")
#     topic_list.append("popularity")
#     topic_list.append("production_companies")
#     topic_list.append("production_countries")
#     topic_list.append("release_date")
#     topic_list.append("revenue")
#     topic_list.append("runtime")
#     topic_list.append("status")
#     topic_list.append("title")
#     topic_list.append("vote_average")
#     topic_list.append("vote_count")
   
#     likes_str = entry_json.get("likes")
#     print("like_str : "+likes_str)
#     likes_list = list(map(int, likes_str.split(',')))
#     print("1er élément de la liste : ")
#     print(likes_list[0])
    
#     if len(likes_list) != 0:
#         for i in range(len(likes_list)) :
            
#                 numberLike = likes_list[i]
#                 print("numberLike : "+str(numberLike))
#                 new_entry_data = {}
#                 # Ouvrir les données du film correspondant
#                 result = mef_like_user(entry_data, str(numberLike))
#                 result = result [0]
#                 print("result[0] :")
#                 print(result)
#                 if result :
#                     print("on est dans le if result")
#                     # Récupérer les données pertinentes de l'image
#                     label_existe = topic_list[0] in result
#                     if label_existe:
#                         print("Label adult existe")
#                         new_entry_data[topic_list[0]] = result.get("adult")
#                         print(f"{topic_list[0]} ajouté depuis film_data")
                        
#                     # label_existe = topic_list[1] in result
#                     # if label_existe:
#                     #     new_entry_data[topic_list[1]] = result.get("budget") 
                        
#                     # label_existe = topic_list[2] in result
#                     # if label_existe:
#                     #     new_entry_data[topic_list[2]] = result.get("genres")
                    
#                     # label_existe = topic_list[3] in result
#                     # if label_existe:
#                     #     new_entry_data[topic_list[3]] = result.get("id") 
                        
#                     # label_existe = topic_list[4] in result
#                     # if label_existe:
#                     #     new_entry_data[topic_list[4]] = result.get("original_language")
                            
#                     # label_existe = topic_list[5] in result
#                     # if label_existe:
#                     #     new_entry_data[topic_list[5]] = result.get("original_title") 
                        
#                     # label_existe = topic_list[6] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[6]] = entry_data.get("popularity")
                        
#                     # label_existe = topic_list[7] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[7]] = entry_data.get("production_companies")
                            
#                     # label_existe = topic_list[8] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[8]] = entry_data.get("production_countries") 
                        
#                     # label_existe = topic_list[9] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[9]] = entry_data.get("release_date") 
                        
#                     # label_existe = topic_list[10] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[10]] = entry_data.get("revenue") 
                        
#                     # label_existe = topic_list[11] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[11]] = entry_data.get("runtime") 
                        
#                     # label_existe = topic_list[12] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[12]] = entry_data.get("status") 
                        
#                     # label_existe = topic_list[13] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[13]] = entry_data.get("title")
                        
#                     # label_existe = topic_list[14] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[14]] = entry_data.get("vote_average")
                    
#                     # label_existe = topic_list[15] in entry_data
#                     # if label_existe:
#                     #     new_entry_data[topic_list[15]] = entry_data.get("vote_count") 
                            
#                     # Ajouter les données formatées à la liste des données
#                     # new_entry_data = {"adult": str(adult), 
#                     #                     "budget": str(budget),
#                     #                     "genres": str(genres),
#                     #                     "id": str(id),
#                     #                     "original_language": str(original_language),
#                     #                     "original_title": str(original_title),
#                     #                     "popularity": str(popularity),
#                     #                     "production_companies": str(production_companies),
#                     #                     "production_countries": str(production_countries),
#                     #                     "release_date": str(release_date),
#                     #                     "revenue": str(revenue),
#                     #                     "runtime": str(runtime),
#                     #                     "status": str(status),
#                     #                     "title": str(title),
#                     #                     "vote_average": str(vote_average),
#                     #                     "vote_count": str(vote_count)                                        
#                     #                 }
#                     exitData.append(new_entry_data)
#                     print("exitData data à la fin de la boucle")
#                     print(exitData)
#                     print("-----------------------------------")
#                 else:
#                     print("Le film"+str(numberLike)+"n'existe plus.")
#         return exitData
    
#     else:
#         print("Pas de like de cet utilisateur, recommandation aléatoire.")
#          # Retourner les données de 3 films au hasard qu'on proposera
#         movie_size_len = len(entry_data['id'])
#         random_number1 = random.randint(1, movie_size_len)
#         random_number2 = random.randint(1, movie_size_len)
#         random_number3 = random.randint(1, movie_size_len)
#         random_list = [random_number1, random_number2, random_number3]
        
#         for i in range(len(random_list)) :
#                 numberList = random_list[i]
#                 # Ouvrir les données du film correspondant
#                 if entry_data.get('id') == numberList:
                    
#                     # Récupérer les données pertinentes
#                     label_existe = topic_list[0] in entry_data
#                     if label_existe:
#                         adult = entry_data.get("adult")
                        
#                     label_existe = topic_list[1] in entry_data
#                     if label_existe:
#                         budget = entry_data.get("budget") 
                        
#                     label_existe = topic_list[2] in entry_data
#                     if label_existe:
#                         genres = entry_data.get("genres")
                    
#                     label_existe = topic_list[3] in entry_data
#                     if label_existe:
#                         id = entry_data.get("id") 
                        
#                     label_existe = topic_list[4] in entry_data
#                     if label_existe:
#                         original_language = entry_data.get("original_language")
                            
#                     label_existe = topic_list[5] in entry_data
#                     if label_existe:
#                         original_title = entry_data.get("original_title") 
                        
#                     label_existe = topic_list[6] in entry_data
#                     if label_existe:
#                         popularity = entry_data.get("popularity")
                        
#                     label_existe = topic_list[7] in entry_data
#                     if label_existe:
#                         production_companies = entry_data.get("production_companies")
                            
#                     label_existe = topic_list[8] in entry_data
#                     if label_existe:
#                         production_countries = entry_data.get("production_countries") 
                        
#                     label_existe = topic_list[9] in entry_data
#                     if label_existe:
#                         release_date = entry_data.get("release_date") 
                        
#                     label_existe = topic_list[10] in entry_data
#                     if label_existe:
#                         revenue = entry_data.get("revenue") 
                        
#                     label_existe = topic_list[11] in entry_data
#                     if label_existe:
#                         runtime = entry_data.get("runtime") 
                        
#                     label_existe = topic_list[12] in entry_data
#                     if label_existe:
#                         status = entry_data.get("status") 
                        
#                     label_existe = topic_list[13] in entry_data
#                     if label_existe:
#                         title = entry_data.get("title")
                        
#                     label_existe = topic_list[14] in entry_data
#                     if label_existe:
#                         vote_average = entry_data.get("vote_average")
                    
#                     label_existe = topic_list[15] in entry_data
#                     if label_existe:
#                         vote_count = entry_data.get("vote_count") 
                            
#                     # Ajouter les données formatées à la liste des données
#                     new_entry_data = {"adult": str(adult), 
#                                         "budget": str(budget),
#                                         "genres": str(genres),
#                                         "id": str(id),
#                                         "original_language": str(original_language),
#                                         "original_title": str(original_title),
#                                         "popularity": str(popularity),
#                                         "production_companies": str(production_companies),
#                                         "production_countries": str(production_countries),
#                                         "release_date": str(release_date),
#                                         "revenue": str(revenue),
#                                         "runtime": str(runtime),
#                                         "status": str(status),
#                                         "title": str(title),
#                                         "vote_average": str(vote_average),
#                                         "vote_count": str(vote_count)                                        
#                                     }
#                     exitData.append(new_entry_data)
#                 else:
#                     print("Le film "+str(numberLike)+" n'existe plus.")
#         return exitData
    
#######################################################
# def traitement_seen(entry_data, entry_json, exitData) :
    
#     topic_list = []  # 16 labels  pour les films
#     topic_list.append("adult")
#     topic_list.append("budget")
#     topic_list.append("genres")
#     topic_list.append("id")
#     topic_list.append("original_language")
#     topic_list.append("original_title")
#     topic_list.append("popularity")
#     topic_list.append("production_companies")
#     topic_list.append("production_countries")
#     topic_list.append("release_date")
#     topic_list.append("revenue")
#     topic_list.append("runtime")
#     topic_list.append("status")
#     topic_list.append("title")
#     topic_list.append("vote_average")
#     topic_list.append("vote_count")
   
#     seen_str = entry_json["user"]["likes"]
#     seen_list = list(map(int, seen_str.split(',')))
    
#     if len(seen_list) != 0:
#         for i in range(len(seen_list)) :
                
#                 numberSeen = seen_list[i]
#                 # Ouvrir les données du film correspondant
#                 if entry_data.get('id') == numberSeen:
                    
#                     # Récupérer les données pertinentes de l'image
#                     label_existe = topic_list[0] in entry_data
#                     if label_existe:
#                         adult = entry_data.get("adult")
                        
#                     label_existe = topic_list[1] in entry_data
#                     if label_existe:
#                         budget = entry_data.get("budget") 
                        
#                     label_existe = topic_list[2] in entry_data
#                     if label_existe:
#                         genres = entry_data.get("genres")
                    
#                     label_existe = topic_list[3] in entry_data
#                     if label_existe:
#                         id = entry_data.get("id") 
                        
#                     label_existe = topic_list[4] in entry_data
#                     if label_existe:
#                         original_language = entry_data.get("original_language")
                            
#                     label_existe = topic_list[5] in entry_data
#                     if label_existe:
#                         original_title = entry_data.get("original_title") 
                        
#                     label_existe = topic_list[6] in entry_data
#                     if label_existe:
#                         popularity = entry_data.get("popularity")
                        
#                     label_existe = topic_list[7] in entry_data
#                     if label_existe:
#                         production_companies = entry_data.get("production_companies")
                            
#                     label_existe = topic_list[8] in entry_data
#                     if label_existe:
#                         production_countries = entry_data.get("production_countries") 
                        
#                     label_existe = topic_list[9] in entry_data
#                     if label_existe:
#                         release_date = entry_data.get("release_date") 
                        
#                     label_existe = topic_list[10] in entry_data
#                     if label_existe:
#                         revenue = entry_data.get("revenue") 
                        
#                     label_existe = topic_list[11] in entry_data
#                     if label_existe:
#                         runtime = entry_data.get("runtime") 
                        
#                     label_existe = topic_list[12] in entry_data
#                     if label_existe:
#                         status = entry_data.get("status") 
                        
#                     label_existe = topic_list[13] in entry_data
#                     if label_existe:
#                         title = entry_data.get("title")
                        
#                     label_existe = topic_list[14] in entry_data
#                     if label_existe:
#                         vote_average = entry_data.get("vote_average")
                    
#                     label_existe = topic_list[15] in entry_data
#                     if label_existe:
#                         vote_count = entry_data.get("vote_count") 
                            
#                     # Ajouter les données formatées à la liste des données
#                     new_entry_data = {"adult": str(adult), 
#                                         "budget": str(budget),
#                                         "genres": str(genres),
#                                         "id": str(id),
#                                         "original_language": str(original_language),
#                                         "original_title": str(original_title),
#                                         "popularity": str(popularity),
#                                         "production_companies": str(production_companies),
#                                         "production_countries": str(production_countries),
#                                         "release_date": str(release_date),
#                                         "revenue": str(revenue),
#                                         "runtime": str(runtime),
#                                         "status": str(status),
#                                         "title": str(title),
#                                         "vote_average": str(vote_average),
#                                         "vote_count": str(vote_count)                                        
#                                     }
#                     exitData.append(new_entry_data)
#                 else:
#                     print("Le film"+numberSeen+"n'existe plus.")
#         return exitData
    
#     else:
#         print("Pas de like de cet utilisateur, recommandation aléatoire.")
#          # Retourner les données de 3 films au hasard qu'on proposera
#         movie_size_len = len(entry_data['id'])
#         random_number1 = random.randint(1, movie_size_len)
#         random_number2 = random.randint(1, movie_size_len)
#         random_number3 = random.randint(1, movie_size_len)
#         random_list = [random_number1, random_number2, random_number3]
        
#         for i in range(len(random_list)) :
#                 numberList = random_list[i]
#                 # Ouvrir les données du film correspondant
#                 if entry_data.get('id') == numberList:
                    
#                     # Récupérer les données pertinentes
#                     label_existe = topic_list[0] in entry_data
#                     if label_existe:
#                         adult = entry_data.get("adult")
                        
#                     label_existe = topic_list[1] in entry_data
#                     if label_existe:
#                         budget = entry_data.get("budget") 
                        
#                     label_existe = topic_list[2] in entry_data
#                     if label_existe:
#                         genres = entry_data.get("genres")
                    
#                     label_existe = topic_list[3] in entry_data
#                     if label_existe:
#                         id = entry_data.get("id") 
                        
#                     label_existe = topic_list[4] in entry_data
#                     if label_existe:
#                         original_language = entry_data.get("original_language")
                            
#                     label_existe = topic_list[5] in entry_data
#                     if label_existe:
#                         original_title = entry_data.get("original_title") 
                        
#                     label_existe = topic_list[6] in entry_data
#                     if label_existe:
#                         popularity = entry_data.get("popularity")
                        
#                     label_existe = topic_list[7] in entry_data
#                     if label_existe:
#                         production_companies = entry_data.get("production_companies")
                            
#                     label_existe = topic_list[8] in entry_data
#                     if label_existe:
#                         production_countries = entry_data.get("production_countries") 
                        
#                     label_existe = topic_list[9] in entry_data
#                     if label_existe:
#                         release_date = entry_data.get("release_date") 
                        
#                     label_existe = topic_list[10] in entry_data
#                     if label_existe:
#                         revenue = entry_data.get("revenue") 
                        
#                     label_existe = topic_list[11] in entry_data
#                     if label_existe:
#                         runtime = entry_data.get("runtime") 
                        
#                     label_existe = topic_list[12] in entry_data
#                     if label_existe:
#                         status = entry_data.get("status") 
                        
#                     label_existe = topic_list[13] in entry_data
#                     if label_existe:
#                         title = entry_data.get("title")
                        
#                     label_existe = topic_list[14] in entry_data
#                     if label_existe:
#                         vote_average = entry_data.get("vote_average")
                    
#                     label_existe = topic_list[15] in entry_data
#                     if label_existe:
#                         vote_count = entry_data.get("vote_count") 
                            
#                     # Ajouter les données formatées à la liste des données
#                     new_entry_data = {"adult": str(adult), 
#                                         "budget": str(budget),
#                                         "genres": str(genres),
#                                         "id": str(id),
#                                         "original_language": str(original_language),
#                                         "original_title": str(original_title),
#                                         "popularity": str(popularity),
#                                         "production_companies": str(production_companies),
#                                         "production_countries": str(production_countries),
#                                         "release_date": str(release_date),
#                                         "revenue": str(revenue),
#                                         "runtime": str(runtime),
#                                         "status": str(status),
#                                         "title": str(title),
#                                         "vote_average": str(vote_average),
#                                         "vote_count": str(vote_count)                                        
#                                     }
#                     exitData.append(new_entry_data)
#                 else:
#                     print("Le film"+numberSeen+"n'existe plus.")
#         return exitData
### Fin fonction modèle d'entrainement ###
##########################################
### Modèle de recommandations ############
# def traitement_movie(entry_data, exitData) :
    
#     topic_list = []  # 16 labels  pour les films
#     topic_list.append("adult")
#     topic_list.append("budget")
#     topic_list.append("genres")
#     topic_list.append("id")
#     topic_list.append("original_language")
#     topic_list.append("original_title")
#     topic_list.append("popularity")
#     topic_list.append("production_companies")
#     topic_list.append("production_countries")
#     topic_list.append("release_date")
#     topic_list.append("revenue")
#     topic_list.append("runtime")
#     topic_list.append("status")
#     topic_list.append("title")
#     topic_list.append("vote_average")
#     topic_list.append("vote_count")
    
#     for i in range(len(entry_data)) :
#         # Récupérer les données pertinentes
#             label_existe = topic_list[0] in entry_data
#             if label_existe:
#                 adult = entry_data.get("adult")
                
#             label_existe = topic_list[1] in entry_data
#             if label_existe:
#                 budget = entry_data.get("budget") 
                
#             label_existe = topic_list[2] in entry_data
#             if label_existe:
#                 genres = entry_data.get("genres")
            
#             label_existe = topic_list[3] in entry_data
#             if label_existe:
#                 id = entry_data.get("id") 
                
#             label_existe = topic_list[4] in entry_data
#             if label_existe:
#                 original_language = entry_data.get("original_language")
                    
#             label_existe = topic_list[5] in entry_data
#             if label_existe:
#                 original_title = entry_data.get("original_title") 
                
#             label_existe = topic_list[6] in entry_data
#             if label_existe:
#                 popularity = entry_data.get("popularity")
                
#             label_existe = topic_list[7] in entry_data
#             if label_existe:
#                 production_companies = entry_data.get("production_companies")
                    
#             label_existe = topic_list[8] in entry_data
#             if label_existe:
#                 production_countries = entry_data.get("production_countries") 
                
#             label_existe = topic_list[9] in entry_data
#             if label_existe:
#                 release_date = entry_data.get("release_date") 
                
#             label_existe = topic_list[10] in entry_data
#             if label_existe:
#                 revenue = entry_data.get("revenue") 
                
#             label_existe = topic_list[11] in entry_data
#             if label_existe:
#                 runtime = entry_data.get("runtime") 
                
#             label_existe = topic_list[12] in entry_data
#             if label_existe:
#                 status = entry_data.get("status") 
                
#             label_existe = topic_list[13] in entry_data
#             if label_existe:
#                 title = entry_data.get("title")
                
#             label_existe = topic_list[14] in entry_data
#             if label_existe:
#                 vote_average = entry_data.get("vote_average")
            
#             label_existe = topic_list[15] in entry_data
#             if label_existe:
#                 vote_count = entry_data.get("vote_count") 

#             # Ajouter les données formatées à la liste des données
#             new_entry_data = {"adult": str(adult), 
#                                         "budget": str(budget),
#                                         "genres": str(genres),
#                                         "id": str(id),
#                                         "original_language": str(original_language),
#                                         "original_title": str(original_title),
#                                         "popularity": str(popularity),
#                                         "production_companies": str(production_companies),
#                                         "production_countries": str(production_countries),
#                                         "release_date": str(release_date),
#                                         "revenue": str(revenue),
#                                         "runtime": str(runtime),
#                                         "status": str(status),
#                                         "title": str(title),
#                                         "vote_average": str(vote_average),
#                                         "vote_count": str(vote_count)                                        
#                                     }
#             exitData.append(new_entry_data)
#     return exitData

# # # Exemple d'utilisation
# # dossier = '../../data/Movies'
# # dataframes = lire_fichiers_csv(dossier)

# # # Afficher les DataFrames lus
# # for i, df in enumerate(dataframes):
# #     print(f"DataFrame {i+1}:")
# #     print(df.head())
# #     print("\n")

