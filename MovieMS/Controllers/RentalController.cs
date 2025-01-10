using Microsoft.AspNetCore.Mvc;
using MovieMS.Services;

namespace MovieMS.Controllers;
    
[ApiController]
[Route("api/[controller]")]
public class RentalController : ControllerBase
{
    private readonly TMDbService _tmdbService;

    public RentalController(TMDbService tmdbService)
    {
        _tmdbService = tmdbService;
    }

    [HttpGet("{movieId}/{country}")]
    public async Task<IActionResult> GetRentalProviders(int movieId, string country = "US")
    {
        if (movieId <= 0)
        {
            return BadRequest("L'ID du film est requis.");
        }

        var providers = await _tmdbService.GetRentalProvidersAsync(movieId, country);

        if (providers.Count == 0)
        {
            return NotFound($"Aucune plateforme disponible pour le pays : {country}.");
        }

        return Ok(providers);
    }
}