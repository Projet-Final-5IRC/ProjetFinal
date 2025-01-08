import function as fct
import pandas as pd
import json
from unittest import result
import random
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier

pathUser = "../../data/User/userTest1.json"
pathMovie = "../../data/Movies/movies.json"

exitDataUser = []
exitDataUserSeen = []
exitDataMovie = []

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
exitDataUser = fct.traitement_like(entry_data, entry_json, exitDataUser)
exitDataUserSeen = fct.traitement_seen(entry_data, entry_json, exitDataUserSeen)
## Movie Data for prediction
exitDataMovie = fct.traitement_movie(entry_data, exitDataMovie)

print("-----------------------------------")
print(exitDataUser.head())
print("-----------------------------------")
print(exitDataUserSeen.head())
print("-----------------------------------")
print(exitDataMovie.head())
print("-----------------------------------")

###########################à faire ###########################
# # Formater les données pour les adapter au DataFrame
# df_user = [[d[key] for key in d.keys()] for d in exitDataUser] 
# print("Le tableau user :")
# print(df_user)
# print("\n")

# df_data = [[d[key] for key in d.keys()] for d in exitDataMovie] 
# print("Le tableau des data:")
# print(df_data)
# print("\n")

# # Création des DataFrames
# dataframeUser = pd.DataFrame(df_data, columns=["year", "make", "orientation", "width", "height"])
# dataframeData = pd.DataFrame(result, columns=["favorite"])

# # Génération des étiquettes numériques
# le1 = LabelEncoder()
# dataframe["year"] = le1.fit_transform(dataframe["year"])

# le2 = LabelEncoder()
# dataframe["make"] = le2.fit_transform(dataframe["make"])

# le3 = LabelEncoder()
# dataframe["orientation"] = le3.fit_transform(dataframe["orientation"])

# # Utilisation des classificateurs d'arbres de décision
# rfc = RandomForestClassifier(
#     n_estimators=10,
#     max_depth=3,
#     random_state=0,
# )

# # Entraînement du classificateur RFC sur les données
# rfc = rfc.fit(dataframeData.values, dataframeUser.values.ravel())

# # Prédiction sur les données d'entraînement
# predicted_values = rfc.predict(dataframeData.values)

# # Affichage des valeurs prédites
# print("Valeurs prédites :")
# print(predicted_values)

