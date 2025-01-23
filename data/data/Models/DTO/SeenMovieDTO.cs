using data.Models.EntityFramework;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.DTO
{
    public class SeenMovieDTO
    {

        public int IdSeenMovies { get; set; }
        public int IdTmdbMovie { get; set; }
        public int IdUser { get; set; }

        public SeenMovieDTO() { }
        public SeenMovieDTO(SeenMovies seenMovies)
        {
            this.IdSeenMovies = seenMovies.IdSeenMovies;
            this.IdTmdbMovie = seenMovies.IdTmdbMovie;
            this.IdUser = seenMovies.IdUser;
        }
    }
}
