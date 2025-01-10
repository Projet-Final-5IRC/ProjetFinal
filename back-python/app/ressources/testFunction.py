def traitement_like(exitDataUserSeen, entry_json, exitData):
    likes_str = entry_json.get("likes", "")
    likes_list = list(map(int, likes_str.split(',')))  # Conversion en liste d'entiers
    
    
    
