import function as fct
import pandas as pd
import json
from unittest import result
import random
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

pathUser = "../../data/User/userTest1.json"
pathMovie = "../../data/Movies/movies.json"

exitDataUserSeen = []
exitDataMovie = []
userLike = []
dataUserLike = []

#### Data ####
# User
entry_json = {}  # Dictionnaire pour stocker les données JSON de l'utilisateur
with open(pathUser, 'r') as json_file:
    entry_json = json.load(json_file)               
# Movies
entry_data = {}
with open(pathMovie, 'r') as file:
    entry_data = json.load(file)           
      
# mise en forme data pour RFC
## User Training
print("-----------------------------------")
print("-----------Fonction traitment------")
# exitDataUser = fct.traitement_like(entry_data, entry_json, exitDataUserLike) 
# print(f"exitDataUser à la fin de la boucle: {exitDataUser}")
# print("-----------------------------------")
# print("-----------------------------------")
exitDataUserSeen = fct.traitement_seen(entry_data, entry_json, exitDataUserSeen)
dataUserLike= exitDataUserSeen[0]
userLike = exitDataUserSeen[1]
# print(f"exitDataUser data à la fin de la boucle: {exitDataUserSeen[0]}")
# print("-----------------------------------")
# print(f"exitDataUser likes à la fin de la boucle: {exitDataUserSeen[1]}")
# print("-----------------------------------")
## Movie Data for prediction (total database)
exitDataMovie = fct.traitement_movie(entry_data, exitDataMovie)
print("---------Fin traitement------------")
print("-----------------------------------")
print("------Création Dataframe-----------")

# Création des DataFrames
dataframeUserLike = pd.DataFrame(userLike, columns=["like"])
dataframeUserLike = dataframeUserLike.astype(str)  # Tout convertir en chaînes
print("dataframeUserLike")
print(dataframeUserLike)
print("-----------------------------------")
dataframeUserLikeData = pd.DataFrame(dataUserLike)
dataframeUserLikeData = dataframeUserLikeData.astype(str)  # Tout convertir en chaînes
dataframeMovie = pd.DataFrame(exitDataMovie)
dataframeMovie = dataframeMovie.astype(str)  # Tout convertir en chaînes
dataframeMovieReturn = dataframeMovie
print("-----------------------------------")
print("dataframeUserLikeData")
print(dataframeUserLikeData)
print("-----------Fin Dataframe-----------")
print("-----------------------------------")
print("--------Encodage-------------------")
# Transformer les colonnes de dataframeUserLikeData
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

print("----------Fin Encodage-------------")
print("-----------------------------------")
print("-----Entrainement du modèle--------")
rfc = RandomForestClassifier(
    n_estimators=10,
    max_depth=3,
    random_state=0,
)
rfc = rfc.fit(dataframeUserLikeData, dataframeUserLike)  
print("-----------------------------------")
# Prédiction sur les données d'entraînement
print("--------Model prevision------------")
predicted_values = rfc.predict(dataframeMovie)
print("-----------------------------------")
print("Valeurs prédites :", predicted_values)
print("-----------------------------------")
## Si on veux tester la précision du modèle
## Il faut alors les mêmes données en entrainement et en test
#print("Précision :", accuracy_score(dataframeMovie, predicted_values))
print("-------traitement data return------")
df_return = pd.DataFrame(predicted_values, columns=['like'])
df_return = pd.concat([df_return, dataframeMovieReturn], axis=1)
print("df_return : \n")
print(df_return.head())
print("----------Fin traitement-----------")


