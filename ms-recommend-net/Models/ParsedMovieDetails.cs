namespace ms_recommend_net.Models
{
    public class ParsedMovieDetails
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string poster_path { get; set; }
        public int Runtime { get; set; }
        public string Overview { get; set; }
        public string ReleaseDate { get; set; }
        public List<string> Genres { get; set; }
        public List<string> Actors { get; set; }
    }

}
