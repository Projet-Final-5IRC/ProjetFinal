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

        public async Task<APIResponseDTO<PreferenceDTO>> PostUserPreferences(string endpoint, List<PreferenceDTO> preferenceDTOs)
        {

            var content = new StringContent(JsonConvert.SerializeObject(preferenceDTOs), System.Text.Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync(endpoint, content);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.Created)
            {
                var jsonResponse = JsonConvert.DeserializeObject<List<PreferenceDTO>>(responseContent);
                return new APIResponseDTO<PreferenceDTO>
                {
                    StatusCode = response.StatusCode,
                    Data = jsonResponse
                };
            }
            else
            {
                return new APIResponseDTO<PreferenceDTO>
                {
                    StatusCode = response.StatusCode,
                    ErrorMessage = responseContent
                };
            }
        }

        public async Task<APIResponseDTO<PreferenceDTO>> UpdateUserPreference(string endpoint, List<PreferenceDTO> updatedPreferenceList)
        {
            var content = new StringContent(JsonConvert.SerializeObject(updatedPreferenceList), System.Text.Encoding.UTF8, "application/json");

            var response = await _httpClient.PutAsync(endpoint, content);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.OK)
            {
                var jsonResponse = JsonConvert.DeserializeObject<List<PreferenceDTO>>(responseContent);
                return new APIResponseDTO<PreferenceDTO>
                {
                    StatusCode = response.StatusCode,
                    Data = jsonResponse
                };
            }
            else
            {
                return new APIResponseDTO<PreferenceDTO>
                {
                    StatusCode = response.StatusCode,
                    ErrorMessage = responseContent
                };
            }
        }

        public async Task<APIResponseDTO<LikedMovieDTO>> GetAllLikedMovieByUser(string endpoint)
        {
            var response = await _httpClient.GetAsync(endpoint);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.OK)
            {
                var jsonResponse = JsonConvert.DeserializeObject<List<LikedMovieDTO>>(responseContent);
                return new APIResponseDTO<LikedMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    Data = jsonResponse
                };
            }
            else
            {
                return new APIResponseDTO<LikedMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    ErrorMessage = responseContent
                };
            }
        }

        public async Task<APIResponseDTOSimple<LikedMovieDTO>> AddLikedMovie(string endpoint, LikedMovieDTO likedMovieDTO)
        {
            var content = new StringContent(JsonConvert.SerializeObject(likedMovieDTO), System.Text.Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync(endpoint, content);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.Created)
            {
                var jsonResponse = JsonConvert.DeserializeObject<LikedMovieDTO>(responseContent);
                return new APIResponseDTOSimple<LikedMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    Data = jsonResponse
                };
            }
            else
            {
                return new APIResponseDTOSimple<LikedMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    ErrorMessage = responseContent
                };
            }
        }

        public async Task<APIResponseDTOSimple<LikedMovieDTO>> DeleteLikedMovie(string endpoint)
        { 
            var response = await _httpClient.DeleteAsync(endpoint);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.NoContent)
            {
                var jsonResponse = JsonConvert.DeserializeObject<LikedMovieDTO>(responseContent);
                return new APIResponseDTOSimple<LikedMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    Data = jsonResponse
                };
            }
            else
            {
                return new APIResponseDTOSimple<LikedMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    ErrorMessage = responseContent
                };
            }
        }

        public async Task<APIResponseDTO<SeenMovieDTO>> GetAllSeenMovieByUser(string endpoint)
        {
            var response = await _httpClient.GetAsync(endpoint);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.OK)
            {
                var jsonResponse = JsonConvert.DeserializeObject<List<SeenMovieDTO>>(responseContent);
                return new APIResponseDTO<SeenMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    Data = jsonResponse
                };
            }
            else
            {
                return new APIResponseDTO<SeenMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    ErrorMessage = responseContent
                };
            }
        }

        public async Task<APIResponseDTOSimple<SeenMovieDTO>> AddSeenMovie(string endpoint, SeenMovieDTO seenMovieDTO)
        {
            var content = new StringContent(JsonConvert.SerializeObject(seenMovieDTO), System.Text.Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync(endpoint, content);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.Created)
            {
                var jsonResponse = JsonConvert.DeserializeObject<SeenMovieDTO>(responseContent);
                return new APIResponseDTOSimple<SeenMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    Data = jsonResponse
                };
            }
            else
            {
                return new APIResponseDTOSimple<SeenMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    ErrorMessage = responseContent
                };
            }
        }

        public async Task<APIResponseDTOSimple<SeenMovieDTO>> DeleteSeenMovie(string endpoint)
        {
            var response = await _httpClient.DeleteAsync(endpoint);
            var responseContent = await response.Content.ReadAsStringAsync();

            if (response.StatusCode == HttpStatusCode.NoContent)
            {
                var jsonResponse = JsonConvert.DeserializeObject<SeenMovieDTO>(responseContent);
                return new APIResponseDTOSimple<SeenMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    Data = jsonResponse
                };
            }
            else
            {
                return new APIResponseDTOSimple<SeenMovieDTO>
                {
                    StatusCode = response.StatusCode,
                    ErrorMessage = responseContent
                };
            }
        }
    }
}
