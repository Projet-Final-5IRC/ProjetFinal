using System;
using System.Data;
using System.Threading.Tasks;
using ms_usr.Models.DTO;
using Npgsql;
using Dapper;
using System.Collections.Generic;
using System.Security.Cryptography.Xml;

public class UserActivityService
{
    private readonly string _connectionString;

    public UserActivityService(string connectionString)
    {
        _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
    }
    // Retrieve user activities from the database
    public async Task<UserActivityDTO> GetUserActivity(int userId)
    {
        const string query = @"
                SELECT 
                    userid AS UserId,
                    logincount AS LoginCount,
                    quizscore AS QuizScore,
                    movieswatchedinmonth AS MoviesWatchedInMonth,
                    eventsattended AS EventsAttended,
                    daysactive AS DaysActive,
                    reviewswritten AS ReviewsWritten,
                    uniquegenreswatched AS UniqueGenresWatched
                FROM public.""UserActivity""
                WHERE userid = @UserId";


        using (var connection = new NpgsqlConnection(_connectionString))
        {
            return await connection.QuerySingleOrDefaultAsync<UserActivityDTO>(query, new { UserId = userId });
        }
    }

    // Update or insert user activities in the database
    public async Task<bool> UpdateUserActivity(UserActivityDTO userActivity)
    {
        const string query = @"
            INSERT INTO public.""UserActivity"" (userid, logincount, quizscore, movieswatchedinmonth, eventsattended, daysactive, reviewswritten, uniquegenreswatched)
            VALUES (@UserId, @LoginCount, @QuizScore, @MoviesWatchedInMonth, @EventsAttended, @DaysActive, @ReviewsWritten, @UniqueGenresWatched)
            ON CONFLICT (userid) DO UPDATE
            SET 
                logincount = EXCLUDED.logincount,
                quizscore = GREATEST(""UserActivity"".quizscore, EXCLUDED.quizscore),
                movieswatchedinmonth = EXCLUDED.movieswatchedinmonth,
                eventsattended = EXCLUDED.eventsattended,
                daysactive = EXCLUDED.daysactive,
                reviewswritten = EXCLUDED.reviewswritten,
                uniquegenreswatched = EXCLUDED.uniquegenreswatched;";

        try
        {
            using (IDbConnection db = new NpgsqlConnection(_connectionString))
            {
                var result = await db.ExecuteAsync(query, userActivity);
                return result > 0; // True if at least one row was affected
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error updating user activities: {ex.Message}");
            throw;
        }
    }

    // Log a user action and update corresponding activity
    public async Task<(bool Success, string Message)> LogUserAction(UserActionDTO action)
    {
        if (action == null || action.UserId <= 0)
        {
            return (false, "Invalid user action data.");
        }

        try
        {
            // Retrieve or initialize user activities
            var userActivity = await GetUserActivity(action.UserId) ?? new UserActivityDTO { UserId = action.UserId };

            // Update activity based on the action type
            switch (action.ActionType.ToLower())
            {
                case "login":
                    userActivity.LoginCount += 1;
                    break;
                case "quizscore":
                    userActivity.QuizScore = Math.Max(userActivity.QuizScore, action.Value);
                    break;
                case "movieswatched":
                    userActivity.MoviesWatchedInMonth += action.Value;
                    break;
                case "eventattended":
                    userActivity.EventsAttended += action.Value;
                    break;
                case "daysactive":
                    userActivity.DaysActive += action.Value;
                    break;
                case "reviewswritten":
                    userActivity.ReviewsWritten += action.Value;
                    break;
                case "uniquegenreswatched":
                    userActivity.UniqueGenresWatched += action.Value;
                    break;
                default:
                    return (false, "Invalid action type.");
            }

            // Save updated activities
            var updateResult = await UpdateUserActivity(userActivity);
            if (!updateResult)
            {
                return (false, "Failed to update user activities.");
            }

            return (true, "User action logged successfully.");
        }
        catch (Exception ex)
        {
            return (false, $"Error: {ex.Message}");
        }
    }


}
