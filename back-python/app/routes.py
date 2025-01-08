from flask import Blueprint, jsonify, request
from .recommender.get_recommendations_by_genre import get_recommendations_by_genre
from .recommender.get_recommendations_by_films import get_recommendations_by_films

api = Blueprint('api', __name__)

# Endpoint pour la vérification de santé
@api.route('/api/health', methods=['GET'])
def health_check():
    return jsonify({"status": "OK", "message": "API is running"}), 200

# Endpoint pour les recommandations basées sur les genres
@api.route('/api/recommend/genres', methods=['POST'])
def recommend_by_genre():
    genres = request.json.get("genres", [])
    recommendations = get_recommendations_by_genre(genres)
    return jsonify({"recommendations": recommendations}), 200

# Endpoint pour les recommandations basées sur les films
@api.route('/api/recommend/films', methods=['POST'])
def recommend_by_films():
    films = request.json.get("films", [])
    recommendations = get_recommendations_by_films(films)
    return jsonify({"recommendations": recommendations}), 200

