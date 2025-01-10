using Microsoft.EntityFrameworkCore;
using ms_recommend_net.Db;
using ms_recommend_net.Interfaces;
using ms_recommend_net.Services;
using System;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddScoped<IRecommendationService, RecommendationService>();

builder.Services.AddSingleton(new ActiveMqService(
    builder.Configuration.GetValue<string>("ActiveMq:BrokerUri"),
    builder.Configuration.GetValue<string>("ActiveMq:QueueName")
));

builder.Services.AddHttpClient<TmdbService>();
builder.Services.Configure<TmdbService>(builder.Configuration);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Recommend API v1");
        c.RoutePrefix = string.Empty; // This makes Swagger UI accessible at "/"
    });
}

// Use top-level route registrations
app.MapControllers();

app.Run();