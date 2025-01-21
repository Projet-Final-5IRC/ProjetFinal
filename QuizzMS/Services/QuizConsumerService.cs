using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Apache.NMS;
using Apache.NMS.ActiveMQ;
using Newtonsoft.Json;
using QuizzMS.Models.EntityFramework;
using System.Threading.Tasks;
using System.Threading;
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using System.Net.Http.Headers;
using QuizzMS.Hubs;
using Microsoft.AspNetCore.SignalR;
using QuizzMS.Controllers;
using ISession = Apache.NMS.ISession;

namespace QuizzMS.Services
{
    public class QuizConsumerService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;
        private readonly IConfiguration _configuration;
        private IConnection _connection;
        private ISession _session;
        private IMessageConsumer _consumer;

        public QuizConsumerService(IServiceProvider serviceProvider, IConfiguration configuration)
        {
            _serviceProvider = serviceProvider;
            _configuration = configuration;

            var factory = new ConnectionFactory(_configuration["ActiveMQ:BrokerUrl"]);
            _connection = factory.CreateConnection(_configuration["ActiveMQ:Username"], _configuration["ActiveMQ:Password"]);
            _connection.Start();
            _session = _connection.CreateSession();
            var destination = _session.GetQueue("QuizQueue");
            _consumer = _session.CreateConsumer(destination);
        }

        protected override Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _consumer.Listener += async message =>
            {
                if (message is ITextMessage textMessage)
                {
                    var quizMessage = JsonConvert.DeserializeObject<QuizMessage>(textMessage.Text);
                    var filmId = quizMessage.FilmId;
                    var titreDuFilm = quizMessage.TitreDuFilm;

                    Console.WriteLine($"Reçu un message pour le film ID: {filmId}, Titre: {titreDuFilm}");

                    // Générer le quiz
                    var quiz = await GenerateQuizAsync(filmId, titreDuFilm);

                    if (quiz != null)
                    {
                        // Insérer le quiz dans la base de données
                        using (var scope = _serviceProvider.CreateScope())
                        {
                            var db = scope.ServiceProvider.GetRequiredService<QuizDbContext>();
                            db.Quizzes.Add(quiz);
                            await db.SaveChangesAsync();

                            Console.WriteLine($"Quiz pour le film {titreDuFilm} enregistré avec succès.");

                            // Notifier le frontend via SignalR
                            var hubContext = scope.ServiceProvider.GetRequiredService<IHubContext<QuizHub>>();
                            await hubContext.Clients.All.SendAsync("QuizReady", filmId, titreDuFilm);
                        }
                    }
                    else
                    {
                        Console.WriteLine($"Le quiz pour le film {titreDuFilm} n'a pas pu être généré.");
                    }
                }
            };

            return Task.CompletedTask;
        }

        private async Task<Quiz> GenerateQuizAsync(string filmId, string titreDuFilm)
        {
            try
            {
                using (var httpClient = new HttpClient())
                {
                    httpClient.BaseAddress = new Uri(_configuration["MistralApi:BaseUrl"]);
                    httpClient.DefaultRequestHeaders.Authorization =
                        new AuthenticationHeaderValue("Bearer", _configuration["MistralApi:BearerToken"]);

                    var requestBody = new
                    {
                        model = "mistral-large-latest",
                        messages = new[]
                        {
                            new
                            {
                                role = "user",
                                content =
                                    $"Génère un quizz sur le film {titreDuFilm} avec les éléments suivants :\n" +
                                    "1. Titre du quizz\n" +
                                    "2. Description du quizz\n" +
                                    "3. Liste de questions avec les éléments suivants pour chaque question :\n" +
                                    "- Texte de la question\n" +
                                    "- Liste des options de réponse\n" +
                                    "- Réponse correcte\n" +
                                    "Formate la sortie en JSON sans blocs de code."
                            }
                        }
                    };

                    var response = await httpClient.PostAsJsonAsync("/v1/chat/completions", requestBody);

                    if (response.IsSuccessStatusCode)
                    {
                        var apiResponse = await response.Content.ReadAsStringAsync();

                        var parsedResponse = JsonConvert.DeserializeObject<MistralApiResponse>(apiResponse);

                        var messageContent = parsedResponse.Choices[0].Message.Content;

                        // Suppression des blocs de code Markdown si présents
                        if (messageContent.StartsWith("```json\n") && messageContent.EndsWith("\n```"))
                        {
                            messageContent = messageContent.Substring("```json\n".Length);
                            messageContent = messageContent.Substring(0, messageContent.Length - "\n```".Length);
                        }

                        var quizContent = JsonConvert.DeserializeObject<QuizResponse>(messageContent);

                        // Vérification que 'quizContent' et 'questions' ne sont pas null
                        if (quizContent == null || quizContent.Questions == null)
                        {
                            Console.WriteLine("Le contenu du quiz ou les questions sont null.");
                            return null;
                        }

                        // Vérification que chaque question a une réponse correcte
                        foreach (var question in quizContent.Questions)
                        {
                            if (string.IsNullOrEmpty(question.Reponse_correcte))
                            {
                                Console.WriteLine("Une question manque de la réponse correcte.");
                                return null;
                            }
                        }

                        // Création de l'entité Quiz
                        var quiz = new Quiz
                        {
                            TitreDuQuiz = quizContent.Titre,
                            DescriptionDuQuiz = quizContent.Description,
                            TitreDuFilm = titreDuFilm,
                            FilmId = filmId,
                            ListeDeQuestions = new List<Question>()
                        };

                        // Création et ajout des questions avec leurs options
                        foreach (var q in quizContent.Questions)
                        {
                            var question = new Question
                            {
                                TexteDeLaQuestion = q.Texte,
                                ReponseCorrecte = q.Reponse_correcte,
                                Options = new List<Option>() // Initialisation de la liste des options
                            };

                            foreach (var opt in q.Options)
                            {
                                var option = new Option
                                {
                                    Texte = opt,
                                    EstCorrecte = opt.Equals(q.Reponse_correcte, StringComparison.OrdinalIgnoreCase)
                                };
                                question.Options.Add(option);
                            }

                            quiz.ListeDeQuestions.Add(question);
                        }

                        // Simuler une génération de 15 secondes si nécessaire
                        // await Task.Delay(15000);

                        return quiz;
                    }
                    else
                    {
                        Console.WriteLine($"Erreur de l'API Mistral : {await response.Content.ReadAsStringAsync()}");
                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erreur lors de la génération du quiz : {ex.Message}");
                return null;
            }
        }

        public override void Dispose()
        {
            _consumer.Close();
            _session.Close();
            _connection.Close();
            base.Dispose();
        }
    }

    // Classe pour la notification de quiz prêt (SignalR n'a plus besoin de cette classe)
    public class QuizReadyMessage
    {
        public string FilmId { get; set; }
        public string TitreDuFilm { get; set; }
    }

    // Classes pour la désérialisation de la réponse de l'API Mistral
    public class MistralApiResponse
    {
        public List<Choice> Choices { get; set; }
    }

    public class Choice
    {
        public MessageContent Message { get; set; }
    }

    public class MessageContent
    {
        public string Content { get; set; }
    }

    public class QuizResponse
    {
        [JsonProperty("titre")]
        public string Titre { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }

        [JsonProperty("questions")]
        public List<QuestionResponse> Questions { get; set; }
    }

    public class QuestionResponse
    {
        [JsonProperty("texte")]
        public string Texte { get; set; }

        [JsonProperty("options")]
        public List<string> Options { get; set; }

        [JsonProperty("reponse_correcte")]
        public string Reponse_correcte { get; set; }
    }
}