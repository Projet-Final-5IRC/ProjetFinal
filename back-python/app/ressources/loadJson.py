import json

def lire_json_et_extraire_noms(chemin_fichier):
    try:
        with open(chemin_fichier, "r", encoding='utf-8') as fichier:
            data = json.load(fichier)
            
    except FileNotFoundError:
        print(f"Erreur : Fichier non trouvé à l'emplacement : {chemin_fichier}")
        return None
    except json.JSONDecodeError:
        print(f"Erreur : Fichier JSON invalide : {chemin_fichier}")
        return None
    except Exception as e:
        print(f"Une erreur inattendue s'est produite : {e}")
        return None