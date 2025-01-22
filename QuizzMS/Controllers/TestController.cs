using Microsoft.AspNetCore.Mvc;
using QuizzMS.Hubs;
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;

namespace QuizzMS.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TestController : ControllerBase
    {
        private readonly IHubContext<QuizHub> _hubContext;

        public TestController(IHubContext<QuizHub> hubContext)
        {
            _hubContext = hubContext;
        }

        [HttpGet("sendQuizReady")]
        public async Task<IActionResult> SendQuizReady(string filmId, string titreDuFilm)
        {
            if (string.IsNullOrEmpty(filmId) || string.IsNullOrEmpty(titreDuFilm))
            {
                return BadRequest("FilmId et titreDuFilm sont requis.");
            }

            await _hubContext.Clients.All.SendAsync("QuizReady", filmId, titreDuFilm);
            return Ok("QuizReady envoyé.");
        }
    }
}