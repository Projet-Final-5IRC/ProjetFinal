using Newtonsoft.Json;

namespace MovieMS.Models.EntityFramework;

public class MovieCreditsResponse
{
    public int Id { get; set; }
    public List<CastMember> Cast { get; set; }
}

public class CastMember
{
    public int Id { get; set; }
    [JsonProperty("name")]
    public string Name { get; set; }
    [JsonProperty("character")]
    public string Character { get; set; }
    [JsonProperty("profile_path")]
    public string ProfilePath { get; set; }
    [JsonProperty("popularity")]
    public double Popularity { get; set; }
    [JsonProperty("known_for_department")]
    public string KnownForDepartment { get; set; }
    [JsonProperty("order")]
    public int Order { get; set; }
}