using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ms_recommend_net.Db;
using ms_recommend_net.Interfaces;
using ms_recommend_net.Models;
using ms_recommend_net.Services;

namespace ms_recommend_net.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RecommendationController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly IRecommendationService _recommendationService;
        private readonly ActiveMqService _activeMqService;
        private readonly TmdbService _tmdbService;

        public RecommendationController(AppDbContext context, IRecommendationService recommendationService, ActiveMqService activeMqService, TmdbService tmdbService)
        {
            _context = context;
            _recommendationService = recommendationService;
            _activeMqService = activeMqService;
            _tmdbService = tmdbService;
        }

        [HttpGet("get-recommendations/{userId}")]
        public async Task<IActionResult> GetRecommendations(int userId)
        {
            return null;
        }

        [HttpPost("update-preferences/{userId}")]
        public async Task<IActionResult> UpdatePreferences(int userId, [FromBody] List<Preference> preferences)
        {
            var success = await _recommendationService.UpdatePreferencesAsync(userId, preferences);

            if (!success)
            {
                return NotFound("Utilisateur non trouvé.");
            }

            return NoContent();
        }

        [HttpGet("preferences/{userId}")]
        public async Task<IActionResult> GetPreferences(int userId)
        {
            var preferences = await _recommendationService.GetPreferencesAsync(userId);

            if (!preferences.Any())
            {
                return NotFound("Aucune préférence trouvée pour cet utilisateur.");
            }

            return Ok(preferences);
        }

        [HttpGet("process-movie-title/{movieTitle}")]
        public async Task<IActionResult> ProcessMovieTitle(string movieTitle)
        {
            try
            {
                // Rechercher l'identifiant du film
                var movieId = await _tmdbService.GetMovieIdAsync(movieTitle);

                if (movieId == null)
                {
                    return NotFound("Aucun film correspondant trouvé dans l'API TMDB.");
                }

                // Récupérer les détails du film
                var movieDetails = await _tmdbService.GetMovieDetailsAsync(movieId.Value);

                return Ok(movieDetails);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        } 
    }
}
