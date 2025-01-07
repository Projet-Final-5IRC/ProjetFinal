using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ms_recommend_net.Db;
using ms_recommend_net.Interfaces;
using ms_recommend_net.Models;

namespace ms_recommend_net.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RecommendationController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly IRecommendationService _recommendationService;

        public RecommendationController(AppDbContext context, IRecommendationService recommendationService)
        {
            _context = context;
            _recommendationService = recommendationService;
        }

        [HttpGet("{userId}")]
        public async Task<IActionResult> GetRecommendations(int userId)
        {
            var recommendations = await _recommendationService.GetRecommendationsAsync(userId);

            if (!recommendations.Any())
            {
                return NotFound("Aucune recommandation disponible.");
            }

            return Ok(recommendations);
        }

        [HttpPost("update-preferences/{userId}")]
        public async Task<IActionResult> UpdatePreferences(int userId, [FromBody] List<Preference> preferences)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                return NotFound("Utilisateur non trouvé.");
            }

            // Update preferences
            _context.Preferences.RemoveRange(_context.Preferences.Where(p => p.UserId == userId));
            await _context.Preferences.AddRangeAsync(preferences);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpGet("preferences/{userId}")]
        public async Task<IActionResult> GetPreferences(int userId)
        {
            var preferences = await _context.Preferences.Where(p => p.UserId == userId).ToListAsync();

            if (!preferences.Any())
            {
                return NotFound("Aucune préférence trouvée pour cet utilisateur.");
            }

            return Ok(preferences);
        }
    }
}
