namespace ms_usr.Models.DTO
{
    public class LikedMovieDTO
    {
        public int IdLikedMovies { get; set; }
        public int IdTmdbMovie { get; set; }
        public int IdUser { get; set; }

        public LikedMovieDTO() { }
    }
}
