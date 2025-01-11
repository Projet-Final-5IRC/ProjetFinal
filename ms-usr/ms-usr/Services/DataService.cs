using ms_usr.Models.DTO;
using System.Net;

namespace ms_usr.Services
{
    public class DataService
    {
        private readonly HttpClient _httpClient;

        public DataService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;

            var apiBaseUrl = configuration.GetValue<string>("ConnectionStrings:BaseURL");

            _httpClient.BaseAddress = new Uri(apiBaseUrl);
        }

        public async Task<List<PreferenceDTO>> GetAllPreferences(string endpoint, string idUser)
        {

        }
    }
}
