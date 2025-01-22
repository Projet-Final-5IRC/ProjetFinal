using data.Models.DTO;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.EntityFramework
{
    [Table("t_e_seen_movies_utl")]
    [Index(nameof(IdSeenMovies))]
    [PrimaryKey(nameof(IdSeenMovies))]
    public class SeenMovies
    {
        [Key]
        [Column("sem_id")]
        public int IdSeenMovies { get; set; }

        [Column("sem_idtmdb")]
        public int IdTmdbMovie { get; set; }

        [Column("usr_id")]
        public int IdUser { get; set; }

        [ForeignKey(nameof(IdUser))]
        [InverseProperty(nameof(Users.UserSeenMovies))]
        public virtual Users? UserReference { get; set; } = null!;

        public SeenMovies() { }
        public SeenMovies(SeenMovieDTO seenMovieDTO)
        {
            this.IdSeenMovies = seenMovieDTO.IdSeenMovies;
            this.IdTmdbMovie = seenMovieDTO.IdTmdbMovie;
            this.IdUser = seenMovieDTO.IdUser;
        }

        public void UpdateSeenMovieValue(SeenMovies seenMovies)
        {
            this.IdSeenMovies = seenMovies.IdSeenMovies;
            this.IdUser = seenMovies.IdUser;
            this.IdTmdbMovie = seenMovies.IdTmdbMovie;
        }
    }
}
