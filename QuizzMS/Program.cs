using Microsoft.EntityFrameworkCore;
using QuizzMS.Models.EntityFramework;
using QuizzMS.Services;
using QuizzMS.Hubs;

namespace QuizzMS;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Ajouter les services au conteneur.

        // Configuration de la base de données PostgreSQL
        builder.Services.AddDbContext<QuizDbContext>(options =>
            options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

        // Ajouter SignalR
        builder.Services.AddSignalR();

        // Ajouter les contrôleurs
        builder.Services.AddControllers();

        // Configuration de Swagger (optionnel)
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen();

        // Ajouter le service consommateur ActiveMQ
        builder.Services.AddHostedService<QuizConsumerService>();

        var app = builder.Build();

        // Migration automatique (optionnel)
        using (var scope = app.Services.CreateScope())
        {
            var db = scope.ServiceProvider.GetRequiredService<QuizDbContext>();
            db.Database.Migrate();
        }

        // Configuration de l'environnement
        if (app.Environment.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        // Désactiver la redirection HTTPS si nécessaire
        // app.UseHttpsRedirection();

        app.UseAuthorization();

        // Map SignalR Hubs
        app.MapHub<QuizHub>("/quizHub");

        app.MapControllers();

        app.Run();
    }
}