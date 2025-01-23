using Microsoft.EntityFrameworkCore;
using ms_badge.Db;
using ms_badge.Models;

namespace ms_badge.Services
{
    public class BadgeEvaluatorService
    {
        public async Task<UserActivity> GetUserActivity(int userId, BadgeContext _context)
        {
            // Simule la récupération des données d'activité de l'utilisateur depuis la base de données
            var userActivity = await _context.UserActivities
                .FirstOrDefaultAsync(ua => ua.UserId == userId);

            if (userActivity == null)
            {
                throw new Exception($"User activity not found for UserId: {userId}");
            }

            return userActivity;
        }

        public bool EvaluateCriteria(Badge badge, UserActivity userActivity)
        {
            return badge.Criteria switch
            {
                "LoginCount >= 1" => userActivity.LoginCount >= 1,
                "QuizScore >= 80" => userActivity.QuizScore >= 80,
                "MoviesWatchedInMonth >= 10" => userActivity.MoviesWatchedInMonth >= 10,
                "EventsAttended >= 5" => userActivity.EventsAttended >= 5,
                "Days = 5" => userActivity.DaysActive == 5,
                "ReviewsWritten >= 10" => userActivity.ReviewsWritten >= 10,
                "UniqueGenresWatched >= 5" => userActivity.UniqueGenresWatched >= 5,
                "UserId <= 50" => userActivity.UserId <= 50,
                _ => false
            };
        }
    }

    public class UserActivity
    {
        public int LoginCount { get; set; }
        public int QuizScore { get; set; }
        public int MoviesWatchedInMonth { get; set; }
        public int EventsAttended { get; set; }
        public int DaysActive { get; set; }
        public int ReviewsWritten { get; set; }
        public int UniqueGenresWatched { get; set; }
        public int UserId { get; set; }
    }

}
