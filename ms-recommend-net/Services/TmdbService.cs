using System;
using System.Net.Http;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

namespace ms_recommend_net.Services
{
    public class TmdbService
    {
        private readonly HttpClient _httpClient;
        private readonly string _tmdbApiKey;
        private readonly string _baseUrl;

        public TmdbService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _tmdbApiKey = configuration.GetValue<string>("Tmdb:ApiKey");
            _baseUrl = configuration.GetValue<string>("Tmdb:BaseUrl");
        }

        public async Task<int?> GetMovieIdAsync(string movieTitle)
        {
            if (string.IsNullOrEmpty(movieTitle))
            {
                throw new ArgumentException("Le titre du film ne peut pas être vide.", nameof(movieTitle));
            }

            var encodedTitle = Uri.EscapeDataString(movieTitle.Trim());
            var tmdbSearchUrl = $"{_baseUrl}/search/movie?api_key={_tmdbApiKey}&query={Uri.EscapeDataString(movieTitle)}";
            Console.WriteLine($"Generated URL: {tmdbSearchUrl}");

            var searchResponse = await _httpClient.GetAsync(tmdbSearchUrl);

            if (!searchResponse.IsSuccessStatusCode)
            {
                throw new Exception("Erreur lors de la recherche du film dans l'API TMDB.");
            }

            // Lire le JSON en tant que chaîne brute
            var jsonString = await searchResponse.Content.ReadAsStringAsync();

            // Deserialize the JSON into TmdbSearchResponse

            var searchResult = JsonSerializer.Deserialize<TmdbSearchResponse>(jsonString);

            // Extract the first movie's ID
            var movieId = searchResult?.Results?.FirstOrDefault()?.Id;
            return movieId;
        }


        public async Task<string> GetMovieDetailsAsync(int movieId)
        {
            var tmdbDetailsUrl = $"https://api.themoviedb.org/3/movie/{movieId}?api_key={_tmdbApiKey}";
            var detailsResponse = await _httpClient.GetAsync(tmdbDetailsUrl);

            if (!detailsResponse.IsSuccessStatusCode)
            {
                throw new Exception("Erreur lors de la récupération des détails du film.");
            }

            var movieDetails = await detailsResponse.Content.ReadAsStringAsync();
            return movieDetails;
        }

        public class TmdbSearchResponse
        {
            [JsonPropertyName("page")]
            public int Page { get; set; }

            [JsonPropertyName("results")]
            public List<TmdbMovie> Results { get; set; }

            [JsonPropertyName("total_pages")]
            public int TotalPages { get; set; }

            [JsonPropertyName("total_results")]
            public int TotalResults { get; set; }
        }

        public class TmdbMovie
        {
            [JsonPropertyName("id")]
            public int Id { get; set; }

            [JsonPropertyName("title")]
            public string Title { get; set; }

            [JsonPropertyName("overview")]
            public string Overview { get; set; }

            [JsonPropertyName("release_date")]
            public string ReleaseDate { get; set; }

            [JsonPropertyName("genre_ids")]
            public List<int> GenreIds { get; set; }

            [JsonPropertyName("adult")]
            public bool Adult { get; set; }

            [JsonPropertyName("backdrop_path")]
            public string BackdropPath { get; set; }

            [JsonPropertyName("original_language")]
            public string OriginalLanguage { get; set; }

            [JsonPropertyName("original_title")]
            public string OriginalTitle { get; set; }

            [JsonPropertyName("popularity")]
            public double Popularity { get; set; }

            [JsonPropertyName("poster_path")]
            public string PosterPath { get; set; }

            [JsonPropertyName("video")]
            public bool Video { get; set; }

            [JsonPropertyName("vote_average")]
            public double VoteAverage { get; set; }

            [JsonPropertyName("vote_count")]
            public int VoteCount { get; set; }
        }
    }
}
