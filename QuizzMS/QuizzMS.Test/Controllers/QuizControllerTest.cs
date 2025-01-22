// QuizzMS.Tests/Controllers/QuizControllerTests.cs
using Xunit;
using Moq;
using Microsoft.Extensions.Configuration;
using QuizzMS.Controllers;
using QuizzMS.Models.EntityFramework;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;

namespace QuizzMS.Tests.Controllers
{
    public class QuizControllerTests
    {
        private readonly Mock<IConfiguration> _mockConfiguration;
        private readonly QuizDbContext _context;
        private readonly QuizController _controller;

        public QuizControllerTests()
        {
            // Mock de IConfiguration
            _mockConfiguration = new Mock<IConfiguration>();
            _mockConfiguration.SetupGet(x => x["ActiveMQ:BrokerUrl"]).Returns("mockBrokerUrl");
            _mockConfiguration.SetupGet(x => x["ActiveMQ:Username"]).Returns("mockUsername");
            _mockConfiguration.SetupGet(x => x["ActiveMQ:Password"]).Returns("mockPassword");

            // Configuration de la base de données en mémoire
            var options = new DbContextOptionsBuilder<QuizDbContext>()
                .UseInMemoryDatabase(databaseName: "QuizTestDb")
                .Options;
            _context = new QuizDbContext(options);

            // Initialiser le contrôleur
            _controller = new QuizController(_mockConfiguration.Object, _context);
        }

        [Fact]
        public async Task CreateQuiz_ReturnsBadRequest_WhenRequestIsInvalid()
        {
            // Arrange
            var invalidRequest = new QuizRequest
            {
                FilmId = "", // ID du film vide
                TitreDuFilm = "Some Film"
            };

            // Act
            var result = await _controller.CreateQuiz(invalidRequest);

            // Assert
            var badRequest = Assert.IsType<BadRequestObjectResult>(result);
            Assert.Equal("L'ID du film et le titre du film sont requis.", badRequest.Value);
        }

        [Fact]
        public async Task CreateQuiz_ReturnsExistingQuiz_WhenQuizAlreadyExists()
        {
            // Arrange
            var existingQuiz = new Quiz
            {
                QuizId = 1,
                FilmId = "603",
                TitreDuFilm = "The Matrix",
                TitreDuQuiz = "Matrix Quiz",
                DescriptionDuQuiz = "A quiz about The Matrix.",
                ListeDeQuestions = new List<Question>
                {
                    new Question
                    {
                        QuestionId = 1,
                        TexteDeLaQuestion = "What is the red pill?",
                        ReponseCorrecte = "Reality",
                        QuizId = 1,
                        Options = new List<Option>
                        {
                            new Option { OptionId = 1, Texte = "Illusion", EstCorrecte = false },
                            new Option { OptionId = 2, Texte = "Reality", EstCorrecte = true }
                        }
                    }
                }
            };
            _context.Quizzes.Add(existingQuiz);
            _context.SaveChanges();

            var request = new QuizRequest
            {
                FilmId = "603",
                TitreDuFilm = "The Matrix"
            };

            // Act
            var result = await _controller.CreateQuiz(request);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnedQuiz = Assert.IsType<Quiz>(okResult.Value); // Retourne l'entité Quiz directement
            Assert.Equal(existingQuiz.QuizId, returnedQuiz.QuizId);
            Assert.Equal(existingQuiz.TitreDuQuiz, returnedQuiz.TitreDuQuiz);
            Assert.Equal(existingQuiz.DescriptionDuQuiz, returnedQuiz.DescriptionDuQuiz);
            Assert.Equal(existingQuiz.TitreDuFilm, returnedQuiz.TitreDuFilm);
            Assert.Equal(existingQuiz.FilmId, returnedQuiz.FilmId);
            Assert.Single(returnedQuiz.ListeDeQuestions);
        }

        [Fact]
        public async Task CreateQuiz_ReturnsStatus500_WhenActiveMQThrowsException()
        {
            // Arrange
            var newRequest = new QuizRequest
            {
                FilmId = "605",
                TitreDuFilm = "Interstellar"
            };

            // Configurer le mock IConfiguration pour fournir une URL ActiveMQ invalide
            _mockConfiguration.SetupGet(x => x["ActiveMQ:BrokerUrl"]).Returns("invalidBrokerUrl");

            // Act
            var result = await _controller.CreateQuiz(newRequest);

            // Assert
            var statusCodeResult = Assert.IsType<ObjectResult>(result);
            Assert.Equal(500, statusCodeResult.StatusCode);
            Assert.Equal("Erreur interne lors de la création du quiz.", statusCodeResult.Value);
        }

        [Fact]
        public async Task GetQuiz_ReturnsBadRequest_WhenFilmIdIsEmpty()
        {
            // Arrange
            string filmId = "";

            // Act
            var result = await _controller.GetQuiz(filmId);

            // Assert
            var badRequest = Assert.IsType<BadRequestObjectResult>(result);
            Assert.Equal("L'ID du film est requis.", badRequest.Value);
        }

        [Fact]
        public async Task GetQuiz_ReturnsNotFound_WhenQuizDoesNotExist()
        {
            // Arrange
            string filmId = "999";

            // Act
            var result = await _controller.GetQuiz(filmId);

            // Assert
            var notFound = Assert.IsType<NotFoundObjectResult>(result);
            Assert.Equal("Quiz non trouvé pour cet ID de film.", notFound.Value);
        }

        [Fact]
        public async Task GetQuiz_ReturnsQuiz_WhenQuizExists()
        {
            // Arrange
            var existingQuiz = new Quiz
            {
                QuizId = 2,
                FilmId = "605",
                TitreDuFilm = "Interstellar",
                TitreDuQuiz = "Interstellar Quiz",
                DescriptionDuQuiz = "A quiz about Interstellar.",
                ListeDeQuestions = new List<Question>
                {
                    new Question
                    {
                        QuestionId = 2,
                        TexteDeLaQuestion = "What is the main theme of Interstellar?",
                        ReponseCorrecte = "Love transcending dimensions",
                        QuizId = 2,
                        Options = new List<Option>
                        {
                            new Option { OptionId = 3, Texte = "Space exploration", EstCorrecte = false },
                            new Option { OptionId = 4, Texte = "Love transcending dimensions", EstCorrecte = true }
                        }
                    }
                }
            };
            _context.Quizzes.Add(existingQuiz);
            _context.SaveChanges();

            // Act
            var result = await _controller.GetQuiz("605");

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnedQuiz = Assert.IsType<Quiz>(okResult.Value);
            Assert.Equal(existingQuiz.QuizId, returnedQuiz.QuizId);
            Assert.Equal(existingQuiz.TitreDuQuiz, returnedQuiz.TitreDuQuiz);
            Assert.Equal(existingQuiz.DescriptionDuQuiz, returnedQuiz.DescriptionDuQuiz);
            Assert.Equal(existingQuiz.TitreDuFilm, returnedQuiz.TitreDuFilm);
            Assert.Equal(existingQuiz.FilmId, returnedQuiz.FilmId);
            Assert.Single(returnedQuiz.ListeDeQuestions);
        }
    }
}