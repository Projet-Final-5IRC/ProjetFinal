// Hubs/QuizHub.cs
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;

namespace QuizzMS.Hubs
{
    public class QuizHub : Hub
    {
        // Méthode pour notifier le frontend que le quiz est prêt
        public async Task NotifyQuizReady(string filmId, string titreDuFilm)
        {
            await Clients.All.SendAsync("QuizReady", filmId, titreDuFilm);
        }
    }
}