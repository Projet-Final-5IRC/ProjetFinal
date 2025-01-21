using Newtonsoft.Json;

namespace MovieMS.Models.EntityFramework
{
    public class MovieDetails
    {
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("title")]
        public string Title { get; set; }
        
        [JsonProperty("overview")]
        public string Overview { get; set; }
        
        [JsonProperty("poster_path")]
        public string PosterPath { get; set; }
        
        [JsonProperty("runtime")]
        public int Runtime { get; set; } // Durée en minutes
        
        [JsonProperty("release_date")] 
        public string ReleaseDate { get; set; } // Date de sortie
        
        [JsonProperty("genres")]
        public List<Genre> Genres { get; set; } // Liste des genres
    }
}