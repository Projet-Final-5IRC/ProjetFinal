using System.Net;

namespace ms_usr.Models.DTO
{
    public class APIResponseDTO<TEntity>
    {
        public HttpStatusCode StatusCode { get; set; }
        public List<TEntity>? Data { get; set; }
        public string ErrorMessage { get; set; }

        public bool IsSuccess => StatusCode == HttpStatusCode.Created;
    }
}
