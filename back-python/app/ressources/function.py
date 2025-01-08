import os
import pandas as pd
import json
import random


# Traitement des données
### Films que l'utilisateur à aimé, à modifier pour les films vus
def traitement_like(entry_data, entry_json, exitData) :
    
    topic_list = []  # 16 labels  pour les films
    topic_list.append("adult")
    topic_list.append("budget")
    topic_list.append("genres")
    topic_list.append("id")
    topic_list.append("original_language")
    topic_list.append("original_title")
    topic_list.append("popularity")
    topic_list.append("production_companies")
    topic_list.append("production_countries")
    topic_list.append("release_date")
    topic_list.append("revenue")
    topic_list.append("runtime")
    topic_list.append("status")
    topic_list.append("title")
    topic_list.append("vote_average")
    topic_list.append("vote_count")
   
    likes_str = entry_json["user"]["likes"]
    likes_list = list(map(int, likes_str.split(',')))
    
    if len(likes_list) != 0:
        for i in range(len(likes_list)) :
                
                numberLike = likes_list[i]
                # Ouvrir les données du film correspondant
                if entry_data.get('id') == numberLike:
                    
                    # Récupérer les données pertinentes de l'image
                    label_existe = topic_list[0] in entry_data
                    if label_existe:
                        adult = entry_data.get("adult")
                        
                    label_existe = topic_list[1] in entry_data
                    if label_existe:
                        budget = entry_data.get("budget") 
                        
                    label_existe = topic_list[2] in entry_data
                    if label_existe:
                        genres = entry_data.get("genres")
                    
                    label_existe = topic_list[3] in entry_data
                    if label_existe:
                        id = entry_data.get("id") 
                        
                    label_existe = topic_list[4] in entry_data
                    if label_existe:
                        original_language = entry_data.get("original_language")
                            
                    label_existe = topic_list[5] in entry_data
                    if label_existe:
                        original_title = entry_data.get("original_title") 
                        
                    label_existe = topic_list[6] in entry_data
                    if label_existe:
                        popularity = entry_data.get("popularity")
                        
                    label_existe = topic_list[7] in entry_data
                    if label_existe:
                        production_companies = entry_data.get("production_companies")
                            
                    label_existe = topic_list[8] in entry_data
                    if label_existe:
                        production_countries = entry_data.get("production_countries") 
                        
                    label_existe = topic_list[9] in entry_data
                    if label_existe:
                        release_date = entry_data.get("release_date") 
                        
                    label_existe = topic_list[10] in entry_data
                    if label_existe:
                        revenue = entry_data.get("revenue") 
                        
                    label_existe = topic_list[11] in entry_data
                    if label_existe:
                        runtime = entry_data.get("runtime") 
                        
                    label_existe = topic_list[12] in entry_data
                    if label_existe:
                        status = entry_data.get("status") 
                        
                    label_existe = topic_list[13] in entry_data
                    if label_existe:
                        title = entry_data.get("title")
                        
                    label_existe = topic_list[14] in entry_data
                    if label_existe:
                        vote_average = entry_data.get("vote_average")
                    
                    label_existe = topic_list[15] in entry_data
                    if label_existe:
                        vote_count = entry_data.get("vote_count") 
                            
                    # Ajouter les données formatées à la liste des données
                    new_entry_data = {"adult": str(adult), 
                                        "budget": str(budget),
                                        "genres": str(genres),
                                        "id": str(id),
                                        "original_language": str(original_language),
                                        "original_title": str(original_title),
                                        "popularity": str(popularity),
                                        "production_companies": str(production_companies),
                                        "production_countries": str(production_countries),
                                        "release_date": str(release_date),
                                        "revenue": str(revenue),
                                        "runtime": str(runtime),
                                        "status": str(status),
                                        "title": str(title),
                                        "vote_average": str(vote_average),
                                        "vote_count": str(vote_count)                                        
                                    }
                    exitData.append(new_entry_data)
                else:
                    print("Le film"+numberLike+"n'existe plus.")
        return exitData
    
    else:
        print("Pas de like de cet utilisateur, recommandation aléatoire.")
         # Retourner les données de 3 films au hasard qu'on proposera
        movie_size_len = len(entry_data['id'])
        random_number1 = random.randint(1, movie_size_len)
        random_number2 = random.randint(1, movie_size_len)
        random_number3 = random.randint(1, movie_size_len)
        random_list = [random_number1, random_number2, random_number3]
        
        for i in range(len(random_list)) :
                numberList = random_list[i]
                # Ouvrir les données du film correspondant
                if entry_data.get('id') == numberList:
                    
                    # Récupérer les données pertinentes
                    label_existe = topic_list[0] in entry_data
                    if label_existe:
                        adult = entry_data.get("adult")
                        
                    label_existe = topic_list[1] in entry_data
                    if label_existe:
                        budget = entry_data.get("budget") 
                        
                    label_existe = topic_list[2] in entry_data
                    if label_existe:
                        genres = entry_data.get("genres")
                    
                    label_existe = topic_list[3] in entry_data
                    if label_existe:
                        id = entry_data.get("id") 
                        
                    label_existe = topic_list[4] in entry_data
                    if label_existe:
                        original_language = entry_data.get("original_language")
                            
                    label_existe = topic_list[5] in entry_data
                    if label_existe:
                        original_title = entry_data.get("original_title") 
                        
                    label_existe = topic_list[6] in entry_data
                    if label_existe:
                        popularity = entry_data.get("popularity")
                        
                    label_existe = topic_list[7] in entry_data
                    if label_existe:
                        production_companies = entry_data.get("production_companies")
                            
                    label_existe = topic_list[8] in entry_data
                    if label_existe:
                        production_countries = entry_data.get("production_countries") 
                        
                    label_existe = topic_list[9] in entry_data
                    if label_existe:
                        release_date = entry_data.get("release_date") 
                        
                    label_existe = topic_list[10] in entry_data
                    if label_existe:
                        revenue = entry_data.get("revenue") 
                        
                    label_existe = topic_list[11] in entry_data
                    if label_existe:
                        runtime = entry_data.get("runtime") 
                        
                    label_existe = topic_list[12] in entry_data
                    if label_existe:
                        status = entry_data.get("status") 
                        
                    label_existe = topic_list[13] in entry_data
                    if label_existe:
                        title = entry_data.get("title")
                        
                    label_existe = topic_list[14] in entry_data
                    if label_existe:
                        vote_average = entry_data.get("vote_average")
                    
                    label_existe = topic_list[15] in entry_data
                    if label_existe:
                        vote_count = entry_data.get("vote_count") 
                            
                    # Ajouter les données formatées à la liste des données
                    new_entry_data = {"adult": str(adult), 
                                        "budget": str(budget),
                                        "genres": str(genres),
                                        "id": str(id),
                                        "original_language": str(original_language),
                                        "original_title": str(original_title),
                                        "popularity": str(popularity),
                                        "production_companies": str(production_companies),
                                        "production_countries": str(production_countries),
                                        "release_date": str(release_date),
                                        "revenue": str(revenue),
                                        "runtime": str(runtime),
                                        "status": str(status),
                                        "title": str(title),
                                        "vote_average": str(vote_average),
                                        "vote_count": str(vote_count)                                        
                                    }
                    exitData.append(new_entry_data)
                else:
                    print("Le film"+numberLike+"n'existe plus.")
        return exitData
    
#######################################################
def traitement_seen(entry_data, entry_json, exitData) :
    
    topic_list = []  # 16 labels  pour les films
    topic_list.append("adult")
    topic_list.append("budget")
    topic_list.append("genres")
    topic_list.append("id")
    topic_list.append("original_language")
    topic_list.append("original_title")
    topic_list.append("popularity")
    topic_list.append("production_companies")
    topic_list.append("production_countries")
    topic_list.append("release_date")
    topic_list.append("revenue")
    topic_list.append("runtime")
    topic_list.append("status")
    topic_list.append("title")
    topic_list.append("vote_average")
    topic_list.append("vote_count")
   
    seen_str = entry_json["user"]["likes"]
    seen_list = list(map(int, seen_str.split(',')))
    
    if len(seen_list) != 0:
        for i in range(len(seen_list)) :
                
                numberSeen = seen_list[i]
                # Ouvrir les données du film correspondant
                if entry_data.get('id') == numberSeen:
                    
                    # Récupérer les données pertinentes de l'image
                    label_existe = topic_list[0] in entry_data
                    if label_existe:
                        adult = entry_data.get("adult")
                        
                    label_existe = topic_list[1] in entry_data
                    if label_existe:
                        budget = entry_data.get("budget") 
                        
                    label_existe = topic_list[2] in entry_data
                    if label_existe:
                        genres = entry_data.get("genres")
                    
                    label_existe = topic_list[3] in entry_data
                    if label_existe:
                        id = entry_data.get("id") 
                        
                    label_existe = topic_list[4] in entry_data
                    if label_existe:
                        original_language = entry_data.get("original_language")
                            
                    label_existe = topic_list[5] in entry_data
                    if label_existe:
                        original_title = entry_data.get("original_title") 
                        
                    label_existe = topic_list[6] in entry_data
                    if label_existe:
                        popularity = entry_data.get("popularity")
                        
                    label_existe = topic_list[7] in entry_data
                    if label_existe:
                        production_companies = entry_data.get("production_companies")
                            
                    label_existe = topic_list[8] in entry_data
                    if label_existe:
                        production_countries = entry_data.get("production_countries") 
                        
                    label_existe = topic_list[9] in entry_data
                    if label_existe:
                        release_date = entry_data.get("release_date") 
                        
                    label_existe = topic_list[10] in entry_data
                    if label_existe:
                        revenue = entry_data.get("revenue") 
                        
                    label_existe = topic_list[11] in entry_data
                    if label_existe:
                        runtime = entry_data.get("runtime") 
                        
                    label_existe = topic_list[12] in entry_data
                    if label_existe:
                        status = entry_data.get("status") 
                        
                    label_existe = topic_list[13] in entry_data
                    if label_existe:
                        title = entry_data.get("title")
                        
                    label_existe = topic_list[14] in entry_data
                    if label_existe:
                        vote_average = entry_data.get("vote_average")
                    
                    label_existe = topic_list[15] in entry_data
                    if label_existe:
                        vote_count = entry_data.get("vote_count") 
                            
                    # Ajouter les données formatées à la liste des données
                    new_entry_data = {"adult": str(adult), 
                                        "budget": str(budget),
                                        "genres": str(genres),
                                        "id": str(id),
                                        "original_language": str(original_language),
                                        "original_title": str(original_title),
                                        "popularity": str(popularity),
                                        "production_companies": str(production_companies),
                                        "production_countries": str(production_countries),
                                        "release_date": str(release_date),
                                        "revenue": str(revenue),
                                        "runtime": str(runtime),
                                        "status": str(status),
                                        "title": str(title),
                                        "vote_average": str(vote_average),
                                        "vote_count": str(vote_count)                                        
                                    }
                    exitData.append(new_entry_data)
                else:
                    print("Le film"+numberSeen+"n'existe plus.")
        return exitData
    
    else:
        print("Pas de like de cet utilisateur, recommandation aléatoire.")
         # Retourner les données de 3 films au hasard qu'on proposera
        movie_size_len = len(entry_data['id'])
        random_number1 = random.randint(1, movie_size_len)
        random_number2 = random.randint(1, movie_size_len)
        random_number3 = random.randint(1, movie_size_len)
        random_list = [random_number1, random_number2, random_number3]
        
        for i in range(len(random_list)) :
                numberList = random_list[i]
                # Ouvrir les données du film correspondant
                if entry_data.get('id') == numberList:
                    
                    # Récupérer les données pertinentes
                    label_existe = topic_list[0] in entry_data
                    if label_existe:
                        adult = entry_data.get("adult")
                        
                    label_existe = topic_list[1] in entry_data
                    if label_existe:
                        budget = entry_data.get("budget") 
                        
                    label_existe = topic_list[2] in entry_data
                    if label_existe:
                        genres = entry_data.get("genres")
                    
                    label_existe = topic_list[3] in entry_data
                    if label_existe:
                        id = entry_data.get("id") 
                        
                    label_existe = topic_list[4] in entry_data
                    if label_existe:
                        original_language = entry_data.get("original_language")
                            
                    label_existe = topic_list[5] in entry_data
                    if label_existe:
                        original_title = entry_data.get("original_title") 
                        
                    label_existe = topic_list[6] in entry_data
                    if label_existe:
                        popularity = entry_data.get("popularity")
                        
                    label_existe = topic_list[7] in entry_data
                    if label_existe:
                        production_companies = entry_data.get("production_companies")
                            
                    label_existe = topic_list[8] in entry_data
                    if label_existe:
                        production_countries = entry_data.get("production_countries") 
                        
                    label_existe = topic_list[9] in entry_data
                    if label_existe:
                        release_date = entry_data.get("release_date") 
                        
                    label_existe = topic_list[10] in entry_data
                    if label_existe:
                        revenue = entry_data.get("revenue") 
                        
                    label_existe = topic_list[11] in entry_data
                    if label_existe:
                        runtime = entry_data.get("runtime") 
                        
                    label_existe = topic_list[12] in entry_data
                    if label_existe:
                        status = entry_data.get("status") 
                        
                    label_existe = topic_list[13] in entry_data
                    if label_existe:
                        title = entry_data.get("title")
                        
                    label_existe = topic_list[14] in entry_data
                    if label_existe:
                        vote_average = entry_data.get("vote_average")
                    
                    label_existe = topic_list[15] in entry_data
                    if label_existe:
                        vote_count = entry_data.get("vote_count") 
                            
                    # Ajouter les données formatées à la liste des données
                    new_entry_data = {"adult": str(adult), 
                                        "budget": str(budget),
                                        "genres": str(genres),
                                        "id": str(id),
                                        "original_language": str(original_language),
                                        "original_title": str(original_title),
                                        "popularity": str(popularity),
                                        "production_companies": str(production_companies),
                                        "production_countries": str(production_countries),
                                        "release_date": str(release_date),
                                        "revenue": str(revenue),
                                        "runtime": str(runtime),
                                        "status": str(status),
                                        "title": str(title),
                                        "vote_average": str(vote_average),
                                        "vote_count": str(vote_count)                                        
                                    }
                    exitData.append(new_entry_data)
                else:
                    print("Le film"+numberSeen+"n'existe plus.")
        return exitData
### Fin fonction modèle d'entrainement ###
##########################################
### Modèle de recommandations ############
def traitement_movie(entry_data, exitData) :
    
    topic_list = []  # 16 labels  pour les films
    topic_list.append("adult")
    topic_list.append("budget")
    topic_list.append("genres")
    topic_list.append("id")
    topic_list.append("original_language")
    topic_list.append("original_title")
    topic_list.append("popularity")
    topic_list.append("production_companies")
    topic_list.append("production_countries")
    topic_list.append("release_date")
    topic_list.append("revenue")
    topic_list.append("runtime")
    topic_list.append("status")
    topic_list.append("title")
    topic_list.append("vote_average")
    topic_list.append("vote_count")
    
    for i in range(len(entry_data)) :
        # Récupérer les données pertinentes
            label_existe = topic_list[0] in entry_data
            if label_existe:
                adult = entry_data.get("adult")
                
            label_existe = topic_list[1] in entry_data
            if label_existe:
                budget = entry_data.get("budget") 
                
            label_existe = topic_list[2] in entry_data
            if label_existe:
                genres = entry_data.get("genres")
            
            label_existe = topic_list[3] in entry_data
            if label_existe:
                id = entry_data.get("id") 
                
            label_existe = topic_list[4] in entry_data
            if label_existe:
                original_language = entry_data.get("original_language")
                    
            label_existe = topic_list[5] in entry_data
            if label_existe:
                original_title = entry_data.get("original_title") 
                
            label_existe = topic_list[6] in entry_data
            if label_existe:
                popularity = entry_data.get("popularity")
                
            label_existe = topic_list[7] in entry_data
            if label_existe:
                production_companies = entry_data.get("production_companies")
                    
            label_existe = topic_list[8] in entry_data
            if label_existe:
                production_countries = entry_data.get("production_countries") 
                
            label_existe = topic_list[9] in entry_data
            if label_existe:
                release_date = entry_data.get("release_date") 
                
            label_existe = topic_list[10] in entry_data
            if label_existe:
                revenue = entry_data.get("revenue") 
                
            label_existe = topic_list[11] in entry_data
            if label_existe:
                runtime = entry_data.get("runtime") 
                
            label_existe = topic_list[12] in entry_data
            if label_existe:
                status = entry_data.get("status") 
                
            label_existe = topic_list[13] in entry_data
            if label_existe:
                title = entry_data.get("title")
                
            label_existe = topic_list[14] in entry_data
            if label_existe:
                vote_average = entry_data.get("vote_average")
            
            label_existe = topic_list[15] in entry_data
            if label_existe:
                vote_count = entry_data.get("vote_count") 

            # Ajouter les données formatées à la liste des données
            new_entry_data = {"adult": str(adult), 
                                        "budget": str(budget),
                                        "genres": str(genres),
                                        "id": str(id),
                                        "original_language": str(original_language),
                                        "original_title": str(original_title),
                                        "popularity": str(popularity),
                                        "production_companies": str(production_companies),
                                        "production_countries": str(production_countries),
                                        "release_date": str(release_date),
                                        "revenue": str(revenue),
                                        "runtime": str(runtime),
                                        "status": str(status),
                                        "title": str(title),
                                        "vote_average": str(vote_average),
                                        "vote_count": str(vote_count)                                        
                                    }
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