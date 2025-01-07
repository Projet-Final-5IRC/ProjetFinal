using ms_evt.Models.DTO;
using Newtonsoft.Json;

namespace ms_evt.Services
{
    public class DataService
    {

        private readonly HttpClient _httpClient;

        public DataService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;

            var apiBaseUrl = configuration.GetValue<string>("ConnectionStrings:BaseUrl");

            _httpClient.BaseAddress = new Uri(apiBaseUrl);
        }

        public async Task<List<EventDTO>> GetEventAsync<EventDTO>(string endpoint)
        {
            var response = await _httpClient.GetStringAsync(endpoint);
            return JsonConvert.DeserializeObject<List<EventDTO>>(response);
        }

        public async Task<bool> PostDataAsync<EventDTO>(string endpoint, EventDTO data)
        {
            var content = new StringContent(JsonConvert.SerializeObject(data), System.Text.Encoding.UTF8, "application/json");
            var response = await _httpClient.PostAsync(endpoint, content);
            return response.IsSuccessStatusCode;
        }
    }
}
