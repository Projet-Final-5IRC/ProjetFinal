using Microsoft.EntityFrameworkCore;
using ms_recommend_net.Db;
using ms_recommend_net.Interfaces;
using ms_recommend_net.Models;
using System.Text.Json;
using System.Text;
using Microsoft.Extensions.Configuration;

namespace ms_recommend_net.Services
{
    public class RecommendationService : IRecommendationService
    {
        private readonly AppDbContext _context;
        private readonly ITmdbService _tmdbService;
        private readonly string _pythonApiUrl;

        public RecommendationService(AppDbContext context, ITmdbService tmdbService, IConfiguration configuration)
        {
            _context = context;
            _tmdbService = tmdbService;
            _pythonApiUrl = configuration.GetValue<string>("PyApi:GenreUrl");
        }
        public async Task<List<ParsedMovieDetails>> GetRecommendationsAsync(int userId)
        {
            // Récupérer les préférences de l'utilisateur
            var preferences = await GetGenresAsync(userId);

            if (preferences == null || preferences.Count == 0)
            {
                throw new Exception("Aucune préférence trouvée pour cet utilisateur.");
            }

            // Serialize preferences to JSON
            var jsonPayload = JsonSerializer.Serialize(preferences);

            Console.WriteLine($"Payload sent: {jsonPayload}");

            using var httpClient = new HttpClient();

            try
            {
                // Call external Python API
                var httpResponse = await httpClient.PostAsync(_pythonApiUrl, new StringContent(jsonPayload, Encoding.UTF8, "application/json"));

                if (!httpResponse.IsSuccessStatusCode)
                {
                    // Log detailed error information
                    var errorContent = await httpResponse.Content.ReadAsStringAsync();
                    var responseHeaders = string.Join("\n", httpResponse.Headers.Select(h => $"{h.Key}: {string.Join(", ", h.Value)}"));

                    throw new Exception(
                        $"Erreur lors de l'appel à l'API Python.\n" +
                        $"Statut HTTP : {httpResponse.StatusCode}\n" +
                        $"En-têtes de réponse :\n{responseHeaders}\n" +
                        $"Contenu de la réponse : {errorContent}");
                }

                // Parse Python API response
                var responseContent = await httpResponse.Content.ReadAsStringAsync();
                var recommendationsResponse = JsonSerializer.Deserialize<ApiPyResponse>(responseContent);

                if (recommendationsResponse == null || recommendationsResponse.ResultatRenvoye == null)
                {
                    throw new Exception("Aucune recommandation valide renvoyée par l'API Python.");
                }

                var recommendedTitles = recommendationsResponse.ResultatRenvoye;

                // Retrieve TMDb movie IDs
                var movieIds = new List<int>();
                foreach (var title in recommendedTitles)
                {
                    var movieId = await _tmdbService.GetMovieIdAsync(title);
                    if (movieId.HasValue)
                    {
                        movieIds.Add(movieId.Value);
                    }
                }

                // Retrieve and parse movie details
                var parsedMovieDetails = new List<ParsedMovieDetails>();

                foreach (var movieId in movieIds)
                {
                    var detailsJson = await _tmdbService.GetMovieDetailsAsync(movieId);

                    // Deserialize JSON response into a JsonElement
                    var details = JsonSerializer.Deserialize<JsonElement>(detailsJson);

                    // Extract the required fields
                    var movieDetails = new ParsedMovieDetails
                    {
                        Id = details.GetProperty("id").GetInt32(),
                        Title = details.TryGetProperty("title", out var title) ? title.GetString() : null, // Extract Title
                        poster_path = details.TryGetProperty("poster_path", out var posterPath) ? posterPath.GetString() : null,
                        Runtime = details.TryGetProperty("runtime", out var runtime) ? runtime.GetInt32() : 0,
                        Overview = details.TryGetProperty("overview", out var overview) ? overview.GetString() : null,
                        ReleaseDate = details.TryGetProperty("release_date", out var releaseDate) ? releaseDate.GetString() : null,
                        Genres = details.TryGetProperty("genres", out var genres)
                            ? genres.EnumerateArray().Select(genre => genre.GetProperty("name").GetString()).ToList()
                            : new List<string>(),
                        Actors = new List<string>() // Fetch actors if needed from another API or logic
                    };


                    parsedMovieDetails.Add(movieDetails);
                }

                return parsedMovieDetails;
            }
            catch (HttpRequestException ex)
            {
                throw new Exception($"Erreur réseau lors de l'appel à l'API Python : {ex.Message}", ex);
            }
            catch (Exception ex)
            {
                throw new Exception($"Une erreur s'est produite lors de l'appel à l'API Python : {ex.Message}", ex);
            }
        }

        // Get user preferences grouped by type
        public async Task<Dictionary<string, List<string>>> GetGenresAsync(int userId)
        {
            // Join t_e_preference_utl and t_e_genres_utl to fetch user preferences
            var userGenres = await (
                from preferences in _context.Preferences // Table: t_e_preference_utl
                join genres in _context.Genres // Table: t_e_genres_utl
                    on preferences.GenId equals genres.GenId
                where preferences.UserId == userId
                select genres.GenName
            ).ToListAsync();

            // Return the result in the desired format
            return new Dictionary<string, List<string>>
            {
                { "Genre", userGenres }
            };
        }

        // Update user preferences
        public async Task<bool> UpdatePreferencesAsync(int userId, List<Preference> preferences)
        {
            // Check if user exists
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
                return false;

            // Remove existing preferences
            var existingPreferences = _context.Preferences.Where(p => p.UserId == userId);
            _context.Preferences.RemoveRange(existingPreferences);

            // Add new preferences
            foreach (var preference in preferences)
            {
                preference.UserId = userId; // Ensure the UserId is set
            }
            await _context.Preferences.AddRangeAsync(preferences);
            await _context.SaveChangesAsync();

            return true;
        }
    }
}
