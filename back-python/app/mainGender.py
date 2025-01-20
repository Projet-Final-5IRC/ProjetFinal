from app.CallApiTest import CallApiTest as cap

import os
from dotenv import load_dotenv
import requests
import pandas as pd
import json
from unittest import result
import random
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score


def mainGender(): 
    
    #### TEST ####
    chemin_genre_names = 'data/Movies/MovieGender.json'
    # Lire le deuxième fichier JSON contenant uniquement les noms des genres
    with open(chemin_genre_names, 'r') as fichier:
        input_json = json.load(fichier)
    
    result = cap.CallApiMoviePerGender(input_json)
    
    return result


#### TEST ####
# chemin_genre_names = '../data/Movies/MovieGender.json'
# # Lire le deuxième fichier JSON contenant uniquement les noms des genres
# with open(chemin_genre_names, 'r') as fichier:
#     input_json = json.load(fichier)

# result = mainGender(input_json)

# print("Résultat de la fonction mainGender : \n")
# print(result)
