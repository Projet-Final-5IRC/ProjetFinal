using ms_usr.Models.DTO;
using Newtonsoft.Json;
using System.Net;
using static System.Runtime.InteropServices.JavaScript.JSType;

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

        public async Task<APIResponseDTO> PostUserPreferences(string endpoint, List<PreferenceDTO> preferenceDTOs)
        {

            var content = new StringContent(JsonConvert.SerializeObject(preferenceDTOs), System.Text.Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync(endpoint, content);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.Created)
            {
                var jsonResponse = JsonConvert.DeserializeObject<List<PreferenceDTO>>(responseContent);
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

        public async Task<APIResponseDTO> UpdateUserPreference(string endpoint, List<PreferenceDTO> updatedPreferenceList)
        {
            var content = new StringContent(JsonConvert.SerializeObject(updatedPreferenceList), System.Text.Encoding.UTF8, "application/json");

            var response = await _httpClient.PutAsync(endpoint, content);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.OK)
            {
                var jsonResponse = JsonConvert.DeserializeObject<List<PreferenceDTO>>(responseContent);
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
