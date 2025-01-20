from app.ressources import function as fct

import pandas as pd
import json
from unittest import result
import random
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score


def JsonInput(pathUser, pathMovie):
    #### Data ####
    # User
    entry_json = {}  
    with open(pathUser, 'r') as json_file:
        entry_json = json.load(json_file)
    # Movies
    entry_data = {}
    with open(pathMovie, 'r') as file:
        entry_data = json.load(file)
    return entry_json, entry_data

def TraitementMain(entry_json, entry_data):
    exitDataUserSeen = []
    exitDataMovie = []

    exitDataUserSeen = fct.traitement_seen(entry_data, entry_json, exitDataUserSeen)
    exitDataMovie = fct.traitement_movie(entry_data, exitDataMovie)
    
    return exitDataUserSeen, exitDataMovie

def CreationDataframe(userLike, dataUserLike, exitDataMovie):
    
    dataframeUserLike = pd.DataFrame(userLike, columns=["like"])
    dataframeUserLike = dataframeUserLike.astype(str)  # Tout convertir en chaînes
    
    dataframeUserLikeData = pd.DataFrame(dataUserLike)
    dataframeUserLikeData = dataframeUserLikeData.astype(str)  # Tout convertir en chaînes
    
    dataframeMovie = pd.DataFrame(exitDataMovie)
    dataframeMovie = dataframeMovie.astype(str)  # Tout convertir en chaînes
    dataframeMovieReturn = dataframeMovie

    return dataframeUserLike, dataframeUserLikeData, dataframeMovie, dataframeMovieReturn

def Encodage(dataframeUserLikeData, dataframeMovie): 
    le1 = LabelEncoder()
    dataframeUserLikeData["adult"] = le1.fit_transform(dataframeUserLikeData["adult"])

    le2 = LabelEncoder()
    dataframeUserLikeData["id"] = le2.fit_transform(dataframeUserLikeData["id"])

    le3 = LabelEncoder()
    dataframeUserLikeData["revenue"] = le3.fit_transform(dataframeUserLikeData["revenue"])

    le4 = LabelEncoder()
    dataframeUserLikeData["runtime"] = le4.fit_transform(dataframeUserLikeData["runtime"])

    # Transformer les colonnes de dataframeMovie
    le5 = LabelEncoder()
    dataframeMovie["adult"] = le5.fit_transform(dataframeMovie["adult"])

    le6 = LabelEncoder()
    dataframeMovie["id"] = le6.fit_transform(dataframeMovie["id"])

    le7 = LabelEncoder()
    dataframeMovie["revenue"] = le7.fit_transform(dataframeMovie["revenue"])

    le8 = LabelEncoder()
    dataframeMovie["runtime"] = le8.fit_transform(dataframeMovie["runtime"])
    
    return dataframeUserLikeData, dataframeMovie

def ModelPrediction(dataframeUserLikeData, dataframeUserLike, dataframeMovie, rfc):
    rfc = rfc.fit(dataframeUserLikeData, dataframeUserLike)
    predicted_values = rfc.predict(dataframeMovie)
    return predicted_values

def TraitementDataFinish(predicted_values, dataframeMovieReturn, entry_json):
    likes_str = entry_json.get("likes", "")
    likes_list = list(map(int, likes_str.split(',')))
    
    df_return = pd.DataFrame(predicted_values, columns=['like'])
    df_return = pd.concat([df_return, dataframeMovieReturn], axis=1)
    #Filtrer pour avoir uniquement les likes
    df_return = df_return.loc[df_return['like'] == '1']
    # Supprimer toutes les colonnes sauf l'id
    df_return = df_return.drop(columns=[col for col in df_return.columns if col != 'id'])
    # Supprimer si déjà vus
    for i in range(len(likes_list)):
        x = likes_list[i]
        print("x : "+str(x))
        # Trouver l'index de la ligne où 'id' est égal à 2
        # Supprimer la ligne
        df_return = df_return.drop(df_return[df_return['id'] == str(x)].index)
    # Choix aléatoire parmit la sélection
    df_return = df_return.sample(n=3)
    # Le passer en json et envoyer la valeur de retour
    json_result = df_return.to_json(orient='records') 
    
    return json_result

def MainFunction():
        
    pathUser = "./data/User/userTest1.json"
    pathMovie = "./data/Movies/movies.json"

    rfc = RandomForestClassifier(
        n_estimators=10,
        max_depth=3,
        random_state=0,
    )
    print("------------json-------------------")
    #Json issus du Prompt
    jsonInput = JsonInput(pathUser, pathMovie)
    entry_json = jsonInput[0]
    entry_data = jsonInput[1]
    print("---------traitementMain--------------")
    #1er traitement de données
    traitementMain = TraitementMain(entry_json, entry_data)
    exitDataUserSeen = traitementMain[0]
    dataUserLike= exitDataUserSeen[0]
    userLike = exitDataUserSeen[1]
    exitDataMovie = traitementMain[1]
    print("------------Dataframe----------------")
    # Creation des dataframes
    creationDataframe = CreationDataframe(userLike, dataUserLike, exitDataMovie)
    dataframeUserLike = creationDataframe[0]
    dataframeUserLikeData = creationDataframe[1]
    dataframeMovie = creationDataframe[2]
    dataframeMovieReturn = creationDataframe[3]
    print("---------Encodage--------------")
    # Encodage des dataframes
    encodage = Encodage(dataframeUserLikeData, dataframeMovie)
    dataframeUserLikeData = encodage[0]
    dataframeMovie = encodage[1]
    print("-------ModelPrediction---------")
    # Entrainement du modèle et prédictions
    predictedValues = ModelPrediction(dataframeUserLikeData, dataframeUserLike, dataframeMovie, rfc)
    print(predictedValues)
    print("-------TraitementFinish---------")
    # Traitement données retour : 
    df_return = TraitementDataFinish(predictedValues, dataframeMovieReturn, entry_json)
    print("df_return : \n")
    print(df_return)
    print("---------------------------------")
    
    return df_return
