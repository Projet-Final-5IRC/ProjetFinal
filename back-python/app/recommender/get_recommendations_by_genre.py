def get_recommendations_by_genre(genres):
    # Cette fonction reçoit une liste de genres et retourne des recommandations basées sur ces genres
    if not genres:
        return ["No genres provided"]
    # Logique pour récupérer des recommandations basées sur les genres
    return [f"Recommended Movie {i}" for i in range(1, 6)]
