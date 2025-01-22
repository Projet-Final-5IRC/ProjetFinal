using ms_recommend_net.Models;

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

        /// <summary>
        /// Updates the preferences of a user.
        /// </summary>
        /// <param name="userId">The ID of the user.</param>
        /// <param name="preferences">A list of new preferences to be added.</param>
        /// <returns>A boolean indicating whether the update was successful.</returns>
        Task<bool> UpdatePreferencesAsync(int userId, List<Preference> preferences);
    }
}
