using Microsoft.EntityFrameworkCore;
using MovieMS;
using MovieMS.Models.EntityFramework;
using MovieMS.Services;

namespace MovieMS;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddControllers().AddNewtonsoftJson();
        builder.Services.AddHttpClient<TMDbService>();
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen();

        var app = builder.Build();

        if (app.Environment.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        app.UseHttpsRedirection();
        app.UseAuthorization();
        app.MapControllers();
        app.Run();
    }
}