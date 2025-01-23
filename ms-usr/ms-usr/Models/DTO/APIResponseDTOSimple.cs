using System.Net;

namespace ms_usr.Models.DTO
{
    public class APIResponseDTOSimple<TEntity>
    {
        public HttpStatusCode StatusCode { get; set; }
        public TEntity? Data { get; set; }
        public string ErrorMessage { get; set; }

        public bool IsSuccess => StatusCode == HttpStatusCode.Created;
    }
}
