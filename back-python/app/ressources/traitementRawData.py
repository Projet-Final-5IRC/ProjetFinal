import function as fct
import pandas as pd

<<<<<<< HEAD
# Chemin vers le fichier CSV
dossier = '../../data/Rawdata/movies_metadata.csv'
json_file_path = '../../data/Movies/movies.json'

# Colonnes à garder
columns_to_keep = [
    'adult', 'budget', 'genres', 'id', 'original_language', 
    'original_title', 'popularity', 'production_companies', 
    'production_countries', 'release_date', 'revenue', 
    'runtime', 'status', 'title', 'vote_average', 'vote_count'
]

data = pd.read_csv(dossier, dtype={10: str})

filtered_data = data[columns_to_keep]

filtered_data.to_json(json_file_path, orient="records", indent=4)

||||||| 488ff29
# Chemin vers le fichier CSV
dossier = '../../data/Rawdata/movies_metadata.csv'
json_file_path = '../../data/Movies/movies.json'

# Colonnes à supprimer
columns_to_keep = [
    'adult', 'budget', 'genres', 'id', 'original_language', 
    'original_title', 'popularity', 'production_companies', 
    'production_countries', 'release_date', 'revenue', 
    'runtime', 'status', 'title', 'vote_average', 'vote_count'
]

data = pd.read_csv(dossier, dtype={10: str})

filtered_data = data[columns_to_keep]

filtered_data.to_json(json_file_path, orient="records", indent=4)

=======
>>>>>>> main
# Exemple d'utilisation
dossier = '../../data/Rawdata/movies_metadata.csv'
dataframe = fct.lire_fichier_csv(dossier)
columns_to_keep3 = [
    'adult', 'belongs_to_collection', 'budget', 'genres', 'id',
    'original_language', 'original_title', 'popularity',
    'production_companies', 'production_countries', 'release_date',
    'revenue', 'runtime', 'status', 'title', 'vote_average', 'vote_count'
]
print(dataframe.head())
print("-----------------------------------")
df = dataframe[columns_to_keep3]
print(df)

# Enregistrer le DataFrame au format JSON avec des options supplémentaires
json_file_path = '../../data/Movies/movies.json'
df.to_json(json_file_path, orient='records', lines=True, date_format='iso', double_precision=2, force_ascii=False)

print(f"DataFrame enregistré dans {json_file_path}")

# csv_file_path = '../../data/Movies/data.csv'
# df.to_csv(csv_file_path, sep=';', header=True, index=False)

# # Afficher les DataFrames lus
# for i, df in enumerate(dataframes):
#     print(f"DataFrame {i+1}:")
#     print(df.keys())
#     print("\n")

# d1 = dataframes[0]
# d2 = dataframes[1]
# d3 = dataframes[2]

# columns_to_keep3 = [
#     'adult', 'belongs_to_collection', 'budget', 'genres', 'id',
#     'original_language', 'original_title', 'popularity',
#     'production_companies', 'production_countries', 'release_date',
#     'revenue', 'runtime', 'status', 'title', 'vote_average', 'vote_count'
# ]

# d3 = df[columns_to_keep3]

# print(d1['id'])
# print("-----------------------------------")
# print(d2['id'])
# print("-----------------------------------")
# # print(d3['id'])
# # print("-----------------------------------")

# merged_df = pd.merge(d1, d2, on='id', how='inner')
# print(merged_df)
# # print(merged_df.head())
# print("-----------------------------------")
# # print(d3.iloc[0])
# # final_df = pd.merge(merged_df, d3, on='id', how='inner')