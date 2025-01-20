using System.Net;

namespace ms_auth.Models.DTO
{
    public class APIResponseDTO
    {
        public HttpStatusCode StatusCode { get; set; }
        public UserDTO Data { get; set; }
        public string ErrorMessage { get; set; }

        public bool IsSuccess => StatusCode == HttpStatusCode.Created;
    }
}
