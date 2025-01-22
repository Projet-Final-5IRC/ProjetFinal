using System.Text.Json.Serialization;

namespace ms_recommend_net.Models
{
    public class ApiPyResponse
    {
        [JsonPropertyName("resultat renvoyé")]
        public List<string> ResultatRenvoye { get; set; }
    }
}
