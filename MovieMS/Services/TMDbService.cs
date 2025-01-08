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
}