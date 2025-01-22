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
        private readonly ITmdbService _tmdbService;

        public RecommendationController(AppDbContext context, IRecommendationService recommendationService, ITmdbService tmdbService)
        {
            _context = context;
            _recommendationService = recommendationService;
            _tmdbService = tmdbService;
        }

        [HttpGet("get-recommendations/{userId}")]
        public async Task<IActionResult> GetRecommendations(int userId)
        {
            try
            {
                var recommendations = await _recommendationService.GetRecommendationsAsync(userId);
                return Ok(recommendations);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Erreur lors de la récupération des recommandations: {ex.Message}");
            }
        }
    }
}
