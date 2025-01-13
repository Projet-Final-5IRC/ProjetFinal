using System.Net;

namespace ms_usr.Models.DTO
{
    public class APIResponseDTO
    {
        public HttpStatusCode StatusCode { get; set; }
        public List<PreferenceDTO>? Data { get; set; }
        public string ErrorMessage { get; set; }

        public bool IsSuccess => StatusCode == HttpStatusCode.Created;
    }
}
