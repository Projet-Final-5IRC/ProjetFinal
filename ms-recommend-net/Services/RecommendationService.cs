using Microsoft.EntityFrameworkCore;
using ms_recommend_net.Db;
using ms_recommend_net.Interfaces;
using ms_recommend_net.Models;

namespace ms_recommend_net.Services
{
    public class RecommendationService : IRecommendationService
    {
        private readonly AppDbContext _context;

        public RecommendationService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Films>> GetRecommendationsAsync(int userId)
        {
            var userPreferences = await _context.Preferences
                .Where(p => p.UserId == userId)
                .Select(p => p.Genre)
                .ToListAsync();

            return await _context.Movies
                .Where(m => userPreferences.Contains(m.Genre))
                .ToListAsync();
        }
    }
}
