using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using MovieMS.Models.EntityFramework;
using MovieMS.Services;

namespace MovieMS.Controllers;
[ApiController]
[Route("api/[controller]")]
public class MoviesController : ControllerBase
{
    private readonly TMDbService _tmdbService;

    public MoviesController(TMDbService tmdbService)
    {
        _tmdbService = tmdbService;
    }

    // Endpoint pour les suggestions
    [HttpGet("suggestions")]
    public async Task<IActionResult> GetSuggestions([FromQuery] string query)
    {
        if (string.IsNullOrWhiteSpace(query))
        {
            return BadRequest("La requête est vide.");
        }

        // Appeler le service TMDb pour obtenir les suggestions
        var results = await _tmdbService.SearchMoviesAsync(query);

        // Mapper les résultats pour retourner uniquement les données nécessaires
        var suggestions = results.Select(movie => new
        {
            Id = movie.Id,
            Title = movie.Title
        }).Take(10);

        return Ok(suggestions);
    }

    // Endpoint pour la recherche complète
    [HttpGet("search")]
    public async Task<IActionResult> SearchMovies([FromQuery] string query)
    {
        if (string.IsNullOrWhiteSpace(query))
        {
            return BadRequest("Le titre est requis pour effectuer une recherche.");
        }

        // Appeler le service TMDb pour obtenir les résultats complets
        var results = await _tmdbService.SearchMoviesAsync(query);

        return Ok(results);
    }
}