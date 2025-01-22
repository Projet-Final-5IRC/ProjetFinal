using Microsoft.EntityFrameworkCore;
using QuizzMS.Models.EntityFramework;
using QuizzMS.Services;
using QuizzMS.Hubs;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace QuizzMS
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Ajouter les services au conteneur.

            // Config de la base de données PostgreSQL
            builder.Services.AddDbContext<QuizDbContext>(options =>
                options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));


            // Ajouter les contrôleurs
            builder.Services.AddControllers();

            // Ajouter SignalR
            builder.Logging.AddConsole();
            builder.Services.AddSignalR(options => options.EnableDetailedErrors =  true);

            // Ajouter CORS pour autoriser toutes les origines (à restreindre en production)
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAll",
                    builder =>
                    {
                        builder
                            .SetIsOriginAllowed(origin => true)
                            .AllowAnyMethod()
                            .AllowAnyHeader()
                            .AllowCredentials();
                    });
            });

            // Configuration de Swagger 
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            // Ajouter le service consommateur ActiveMQ
            builder.Services.AddHostedService<QuizConsumerService>();

            var app = builder.Build();

            // Migration automatique 
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

            // CORS avant d'utiliser l'Authorization et le Routing
            app.UseRouting();
            app.UseCors("AllowAll");
            
            // Activer WebSockets
            app.UseWebSockets();
            
            app.UseAuthorization();

            // Map SignalR Hubs
            app.MapHub<QuizHub>("/quizHub");

            app.MapControllers();

            app.Run();
        }
    }
}