using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using QuizzMS.Models.EntityFramework;
using Apache.NMS.ActiveMQ;
using Microsoft.EntityFrameworkCore;

namespace QuizzMS.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class QuizController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly QuizDbContext _context;

        public QuizController(IConfiguration configuration, QuizDbContext context)
        {
            _configuration = configuration;
            _context = context;
        }

        // Endpoint POST pour créer un quiz
        [HttpPost]
        public async Task<IActionResult> CreateQuiz([FromBody] QuizRequest request)
        {
            // Valider la requête
            if (string.IsNullOrEmpty(request.FilmId) || string.IsNullOrEmpty(request.TitreDuFilm))
            {
                return BadRequest("L'ID du film et le titre du film sont requis.");
            }

            // Vérifier si le quiz existe déjà dans la base de données
            var existingQuiz = await _context.Quizzes
                                           .Include(q => q.ListeDeQuestions)
                                           .ThenInclude(q => q.Options)
                                           .FirstOrDefaultAsync(q => q.FilmId == request.FilmId);

            if (existingQuiz != null)
            {
                // Quiz existant trouvé, le retourner directement
                return Ok(existingQuiz);
            }

            // Quiz non trouvé, envoyer un message à ActiveMQ pour génération
            var messageContent = JsonConvert.SerializeObject(new QuizMessage 
            { 
                FilmId = request.FilmId, 
                TitreDuFilm = request.TitreDuFilm 
            });

            try
            {
                var factory = new ConnectionFactory(_configuration["ActiveMQ:BrokerUrl"]);
                using (var connection = factory.CreateConnection(_configuration["ActiveMQ:Username"], _configuration["ActiveMQ:Password"]))
                {
                    connection.Start();
                    using (var session = connection.CreateSession())
                    {
                        var destination = session.GetQueue("QuizQueue");
                        var producer = session.CreateProducer(destination);
                        var message = session.CreateTextMessage(messageContent);
                        producer.Send(message);
                    }
                }

                return Accepted(new { message = "Votre demande de quiz est en cours de traitement." });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erreur lors de l'envoi du message à ActiveMQ : {ex.Message}");
                return StatusCode(500, "Erreur interne lors de la création du quiz.");
            }
        }

        // Endpoint GET pour récupérer un quiz par filmId
        [HttpGet("{filmId}")]
        public async Task<IActionResult> GetQuiz(string filmId)
        {
            if (string.IsNullOrEmpty(filmId))
            {
                return BadRequest("L'ID du film est requis.");
            }

            var quiz = await _context.Quizzes
                               .Include(q => q.ListeDeQuestions)
                               .ThenInclude(q => q.Options)
                               .FirstOrDefaultAsync(q => q.FilmId == filmId);

            if (quiz == null)
            {
                return NotFound("Quiz non trouvé pour cet ID de film.");
            }

            return Ok(quiz);
        }
    }

    // Classe pour la requête reçue du frontend
    public class QuizRequest
    {
        public string FilmId { get; set; }
        public string TitreDuFilm { get; set; }
    }

    // Classe pour le message envoyé à ActiveMQ
    public class QuizMessage
    {
        public string FilmId { get; set; }
        public string TitreDuFilm { get; set; }
    }
}