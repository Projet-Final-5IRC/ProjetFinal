using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;

namespace QuizzMS.Hubs
{
    public class QuizHub : Hub
    {
        public override async Task OnConnectedAsync()
        {
            Console.WriteLine($"Client connecté : {Context.ConnectionId}");
            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception exception)
        {
            Console.WriteLine($"Client déconnecté : {Context.ConnectionId}");
            await base.OnDisconnectedAsync(exception);
        }

        // Méthode pour envoyer un quiz prêt (peut être utilisée pour tester)
        public async Task SendQuizReady(string filmId, string titreDuFilm)
        {
            Console.WriteLine($"Envoi du quiz prêt pour le film ID: {filmId}, Titre: {titreDuFilm}");
            await Clients.All.SendAsync("QuizReady", filmId, titreDuFilm);
        }
    }
}