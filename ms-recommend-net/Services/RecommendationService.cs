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

        // Get recommendations for a user
        public void GetRecommendationsAsync(int userId)
        {
            
        }

        // Get user preferences grouped by type
        public async Task<Dictionary<string, List<string>>> GetPreferencesAsync(int userId)
        {
            // Fetch user preferences grouped by type
            return await _context.Preferences
                .Where(p => p.UserId == userId)
                .GroupBy(p => p.Type)
                .ToDictionaryAsync(
                    g => g.Key, // The preference type (e.g., "Genre", "Actor")
                    g => g.Select(p => p.Value).ToList() // List of preferences for that type
                );
        }

        // Update user preferences
        public async Task<bool> UpdatePreferencesAsync(int userId, List<Preference> preferences)
        {
            // Check if user exists
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
                return false;

            // Remove existing preferences
            var existingPreferences = _context.Preferences.Where(p => p.UserId == userId);
            _context.Preferences.RemoveRange(existingPreferences);

            // Add new preferences
            foreach (var preference in preferences)
            {
                preference.UserId = userId; // Ensure the UserId is set
            }
            await _context.Preferences.AddRangeAsync(preferences);
            await _context.SaveChangesAsync();

            return true;
        }
    }
}
