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

        public RecommendationController(AppDbContext context, IRecommendationService recommendationService, ActiveMqService activeMqService)
        {
            _context = context;
            _recommendationService = recommendationService;
            _activeMqService = activeMqService;
        }

        [HttpGet("{userId}")]
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
    }
}
