using ms_usr.Services;

var builder = WebApplication.CreateBuilder(args);

// Retrieve connection strings
var baseUrl = builder.Configuration.GetConnectionString("BaseURL");
var defaultConnection = builder.Configuration.GetConnectionString("DefaultConnection");

if (string.IsNullOrEmpty(baseUrl) || string.IsNullOrEmpty(defaultConnection))
{
    throw new ArgumentNullException("Connection strings cannot be null or empty.");
}

// Register UserActivityService with the DefaultConnection string
builder.Services.AddSingleton<UserActivityService>(sp => new UserActivityService(defaultConnection));

// Add HttpClient for the BaseURL
builder.Services.AddHttpClient("BaseApiClient", client =>
{
    client.BaseAddress = new Uri(baseUrl);
});

// Add services to the container
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.Run();
