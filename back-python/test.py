from app.ressources import CallApi as ca

# import os
# from dotenv import load_dotenv
# import requests
# import pandas as pd
# import json
# from unittest import result
# import random
# import numpy as np
# from sklearn.preprocessing import LabelEncoder
# from sklearn.ensemble import RandomForestClassifier
# from sklearn.metrics import accuracy_score

# def JsonInput(input):
#     #User
#     entry_json = {}  
#     entry_json = input
    
#     #Data Movie
#     entry_data = {}
#     load_dotenv()
#     api_key = os.getenv("API_KEY")
    
#     listId = ca.CallFounIdPerGender(input_json)
    
#     # Convertir chaque élément de la liste en chaîne de caractères
#     listId_str = [str(id) for id in listId]
#     # Joindre les éléments avec une virgule comme séparateur
#     listId_str = ','.join(listId_str)
    
#     url = f"https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres={listId_str}&api_key={api_key}"
#     headers = {"accept": "application/json"}  # En-tête approprié
#     response = requests.get(url, headers=headers)
#     entry_data = response.json()
    
#     return entry_data

result = ca.CallMovieFouine()

print("La requête : \n") 
print(result)


