using ms_usr.Models.DTO;
using Newtonsoft.Json;
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

        public async Task<List<PreferenceDTO>> GetAllUserPreferences(string endpoint, int idUser)
        {
            var response = await _httpClient.GetStringAsync($"{endpoint}/{idUser}");
            return JsonConvert.DeserializeObject<List<PreferenceDTO>>(response);
        }
    }
}
