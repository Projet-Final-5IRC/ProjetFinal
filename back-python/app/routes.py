# from flask import Blueprint, jsonify, request
# from .recommender.get_recommendations_by_genre import get_recommendations_by_genre
# from .recommender.get_recommendations_by_films import get_recommendations_by_films

# api = Blueprint('api', __name__)

# # Endpoint pour les recommandations basées sur les genres
# @api.route('/api/recommend/genres', methods=['POST'])
# def recommend_by_genre():
#     genres = request.json.get("genres", [])
#     recommendations = get_recommendations_by_genre(genres)
#     return jsonify({"recommendations": recommendations}), 200



