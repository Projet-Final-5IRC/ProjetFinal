using Newtonsoft.Json;

namespace MovieMS.Models.EntityFramework;

public class Movie
{
    public int Id { get; set; } // Correspond à "id" dans TMDb
    [JsonProperty("title")]
    public string Title { get; set; }

    [JsonProperty("overview")]
    public string Overview { get; set; }

    [JsonProperty("poster_path")]
    public string PosterPath { get; set; }

    [JsonProperty("release_date")]
    public DateTime? ReleaseDate { get; set; }

    [JsonProperty("popularity")]
    public double Popularity { get; set; }

    [JsonProperty("vote_average")]
    public double VoteAverage { get; set; }

    [JsonProperty("vote_count")]
    public int VoteCount { get; set; }
}