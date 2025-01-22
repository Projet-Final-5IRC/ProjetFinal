using data.Models.DTO;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.EntityFramework
{
    [Table("t_e_liked_movies_utl")]
    [Index(nameof(IdLikedMovies))]
    [PrimaryKey(nameof(IdLikedMovies))]
    public class LikedMovies
    {
        [Key]
        [Column("lik_id")]
        public int IdLikedMovies { get; set; }

        [Column("lik_idtmdb")]
        public int IdTmdbMovie { get; set; }

        [Column("usr_id")]
        public int IdUser { get; set; }

        [ForeignKey(nameof(IdUser))]
        [InverseProperty(nameof(Users.UserLikedMovies))]
        public virtual Users? UserReference { get; set; } = null!;

        public LikedMovies() { }
        public LikedMovies(LikedMovieDTO likedMovie)
        {
            this.IdLikedMovies = likedMovie.IdLikedMovies;
            this.IdUser = likedMovie.IdUser;
            this.IdTmdbMovie = likedMovie.IdTmdbMovie;
        }

        public void UpdateLikeMovieValue(LikedMovies likedMovies)
        {
            this.IdLikedMovies = likedMovies.IdLikedMovies;
            this.IdUser = likedMovies.IdUser;
            this.IdTmdbMovie = likedMovies.IdTmdbMovie;
        }
    }
}
