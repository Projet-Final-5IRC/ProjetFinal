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
    
    
    // EP pour actors
    [HttpGet("{movieId}/actors")]
    public async Task<IActionResult> GetMovieActors(int movieId)
    {
        if (movieId <= 0)
        {
            return BadRequest("L'ID du film est requis.");
        }

        try
        {
            var actors = await _tmdbService.GetMovieActorsAsync(movieId);
            return Ok(actors);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erreur : {ex.Message}");
        }
    }
    
    [HttpGet("{movieId}")]
    public async Task<IActionResult> GetFullMovieDetails(int movieId)
    {
        if (movieId <= 0)
        {
            return BadRequest("L'ID du film est requis.");
        }

        try
        {
            // Exécuter les deux requêtes en parallèle
            var movieDetailsTask = _tmdbService.GetMovieDetailsAsync(movieId);
            var movieActorsTask = _tmdbService.GetMovieActorsAsync(movieId);

            await Task.WhenAll(movieDetailsTask, movieActorsTask);

            // Récupérer les résultats
            var movieDetails = movieDetailsTask.Result;
            var actors = movieActorsTask.Result;

            // Inclure l'ID dans les détails
            movieDetails.Id = movieId;

            // Combiner les résultats
            var fullDetails = new MovieFullDetails
            {
                Details = movieDetails,
                Actors = actors
            };

            return Ok(fullDetails);
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Erreur : {ex.Message}");
        }
    }
    
}