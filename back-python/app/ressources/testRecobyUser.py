from ressources import loadJson

path = "../../data/userTest.json"
userData = lire_json_et_extraire_noms(path)

if userData:
    print("Liste des noms extraits :", userData)
else:
    print("La lecture du fichier JSON a rencontré des erreurs.")