using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using MovieMS.Models.EntityFramework;

namespace MovieMS.Services;
public class TMDbService
{
    private readonly HttpClient _httpClient;
    private readonly string _apiKey;
    private readonly string _baseUrl;

    public TMDbService(HttpClient httpClient, IConfiguration configuration)
    {
        _httpClient = httpClient;
        _apiKey = configuration["TMDbSettings:ApiKey"];
        _baseUrl = configuration["TMDbSettings:BaseUrl"];
    }

    public async Task<List<Movie>>  SearchMoviesAsync(string query)
    {
        var response = await _httpClient.GetAsync($"{_baseUrl}/search/movie?api_key={_apiKey}&query={Uri.EscapeDataString(query)}");
        if (!response.IsSuccessStatusCode)
        {
            throw new Exception($"Erreur lors de l'appel à TMDb API : {response.ReasonPhrase}");
        }

        var content = await response.Content.ReadAsStringAsync();

        // Désérialiser le JSON complet dans une structure dynamique
        var json = JsonConvert.DeserializeObject<dynamic>(content);

        // Extraire la liste des résultats et la convertir en une liste de Movie
        var movies = JsonConvert.DeserializeObject<List<Movie>>(json.results.ToString());

        return movies;
    }
    
    public async Task<List<RentalPlatform>> GetRentalProvidersAsync(int movieId, string country = "US")
    {
        var response = await _httpClient.GetAsync($"{_baseUrl}/movie/{movieId}/watch/providers?api_key={_apiKey}");
        if (!response.IsSuccessStatusCode)
        {
            throw new Exception($"Erreur lors de l'appel à TMDb API : {response.ReasonPhrase}");
        }

        var content = await response.Content.ReadAsStringAsync();
        var json = JsonConvert.DeserializeObject<dynamic>(content);

        // Vérifiez si le pays spécifié existe dans "results"
        var countryData = json.results?[country];
        if (countryData == null) return new List<RentalPlatform>();

        var providers = new List<RentalPlatform>();

        // Ajouter les plateformes pour chaque type (rent, buy, flatrate)
        foreach (var type in new[] { "rent", "buy", "flatrate" })
        {
            if (countryData[type] != null)
            {
                foreach (var provider in countryData[type])
                {
                    providers.Add(new RentalPlatform
                    {
                        ProviderName = provider.provider_name,
                        LogoPath = provider.logo_path,
                        Type = type,
                        TmdbLink = countryData.link
                    });
                }
            }
        }

        return providers;
    }
    
    public async Task<MovieDetails> GetMovieDetailsAsync(int movieId)
    {
        var response = await _httpClient.GetAsync($"{_baseUrl}/movie/{movieId}?api_key={_apiKey}");
        if (!response.IsSuccessStatusCode)
        {
            throw new Exception($"Erreur lors de l'appel à TMDb API : {response.ReasonPhrase}");
        }

        var content = await response.Content.ReadAsStringAsync();

        // Désérialiser uniquement les champs nécessaires
        var json = JsonConvert.DeserializeObject<dynamic>(content);

        var movieDetails = new MovieDetails
        {
            Title = json.title,
            Overview = json.overview,
            PosterPath = json.poster_path,
            Runtime = json.runtime,
            ReleaseDate = json.release_date,
            Genres = json.genres.ToObject<List<Genre>>() // Mapper les genres
        };

        return movieDetails;
    }
    
    public async Task<List<Actor>> GetMovieActorsAsync(int movieId)
    {
        var response = await _httpClient.GetAsync($"{_baseUrl}/movie/{movieId}/credits?api_key={_apiKey}");
        if (!response.IsSuccessStatusCode)
        {
            throw new Exception($"Erreur lors de l'appel à TMDb API : {response.ReasonPhrase}");
        }

        var content = await response.Content.ReadAsStringAsync();

        // Désérialiser la réponse JSON dans le modèle typé
        var credits = JsonConvert.DeserializeObject<MovieCreditsResponse>(content);

        // Filtrer les acteurs et limiter à 10, triés par popularité décroissante
        var actors = credits.Cast
            .Where(c => c.KnownForDepartment == "Acting")
            .OrderByDescending(c => c.Popularity) // Tri par popularité décroissante
            .Take(10)
            .Select(c => new Actor
            {
                Id = c.Id,
                Name = c.Name,
                Character = c.Character,
                ProfilePath = c.ProfilePath,
                Popularity = c.Popularity
            }).ToList();

        return actors;
    }
    
    
}