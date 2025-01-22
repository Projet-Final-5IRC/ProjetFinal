using Microsoft.AspNetCore.Mvc.Diagnostics;
using ms_auth.Models.DTO;
using Newtonsoft.Json;
using System.Net;
using System.Reflection;

namespace ms_auth.Services
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

        public async Task<T> GetByEmailAsync<T>(string endpoint, string email)
        {
            var response = await _httpClient.GetStringAsync($"{endpoint}{email}");

            if (response != null)
            {
                return JsonConvert.DeserializeObject<T>(response);
            }
            return JsonConvert.DeserializeObject<T>(null);
        }

        public async Task<APIResponseDTO> PostUserAsync(string endpoint, UserDTO data)
        {
            var content = new StringContent(JsonConvert.SerializeObject(data), System.Text.Encoding.UTF8, "application/json");
            var response = await _httpClient.PostAsync(endpoint, content);

            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.Created)
            {
                var jsonResponse = JsonConvert.DeserializeObject<UserDTO>(responseContent);
                return new APIResponseDTO
                {
                    StatusCode = response.StatusCode,
                    Data = jsonResponse
                };
            }
            else
            {
                return new APIResponseDTO
                {
                    StatusCode = response.StatusCode,
                    ErrorMessage = responseContent
                };
            }
        }
    }
}
