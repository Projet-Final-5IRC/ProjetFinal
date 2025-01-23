using data.Models.DataManager;
using data.Models.EntityFramework;
using data.Models.Repository;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddScoped<IDataRepositoryEventMore<Events>, EventsManager>();
builder.Services.AddScoped<IDataRepository<Genres>, GenresManager>();
builder.Services.AddScoped<IDataRepositoryWithEmail<Users>, UsersManager>();
builder.Services.AddScoped<IDataRepositoryEventInvite<EventsInvite>, EventsInviteManager>();
builder.Services.AddScoped<IDataRepositoryWithPreference<Preference>, PreferenceManager>();
builder.Services.AddScoped<IDataRepositoryWithMovies<LikedMovies>, LikedMoviesManager>();
builder.Services.AddScoped<IDataRepositoryWithMovies<SeenMovies>, SeenMoviesManager>();

builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<EventDBContext>(options =>
  options.UseNpgsql(builder.Configuration.GetConnectionString("EventsDB")));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
