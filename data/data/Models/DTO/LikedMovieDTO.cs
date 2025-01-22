using data.Models.EntityFramework;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.DTO
{
    public class LikedMovieDTO
    {
        public int IdLikedMovies { get; set; }
        public int IdTmdbMovie { get; set; }
        public int IdUser { get; set; }

        public LikedMovieDTO() { }
        public LikedMovieDTO(LikedMovies likedMovies)
        {
            this.IdLikedMovies = likedMovies.IdLikedMovies;
            this.IdTmdbMovie = likedMovies.IdTmdbMovie;
            this.IdUser = likedMovies.IdUser;
        }
    }
}
