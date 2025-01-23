using ms_recommend_net.Models;
using System.Text.Json;

namespace ms_recommend_net.Interfaces
{
    public interface IRecommendationService
    {
        /// <summary>
        /// Retrieves film recommendations for a user based on their preferences.
        /// </summary>
        /// <param name="userId">The ID of the user.</param>
        /// <returns>A collection of recommended films.</returns>
        Task<List<ParsedMovieDetails>> GetRecommendationsAsync(int userId);

        /// <summary>
        /// Retrieves user preferences grouped by type (e.g., Genre, Actor).
        /// </summary>
        /// <param name="userId">The ID of the user.</param>
        /// <returns>A dictionary where the key is the preference type, and the value is a list of preferences.</returns>
        Task<Dictionary<string, List<string>>> GetGenresAsync(int userId);
        Task<List<ParsedMovieDetails>> ProcessMovieTitleAsync();
    }
}
