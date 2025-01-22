using Microsoft.EntityFrameworkCore.Infrastructure;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace data.Models.EntityFramework
{
    [Table("t_e_genres_utl")]
    public class Genres
    {
        [Key]
        [Column("gen_id")]
        public int IdGenre { get; set; }

        [Required]
        [Column("gen_tmid")]
        public int IdTMDBGenre { get; set; }

        [Required]
        [Column("gen_name")]
        public string GenreName { get; set; }

        [JsonIgnore]
        public virtual ICollection<Events> EventsGenre { get; set; } = new List<Events>();

        [JsonIgnore]
        public virtual ICollection<Preference> GenrePreference { get; set; } = new List<Preference>();

        public void UpdateGenreValues(Genres updatedGenre)
        {
            if (updatedGenre.IdTMDBGenre != 0)
                this.IdTMDBGenre = updatedGenre.IdTMDBGenre;

            if (!string.IsNullOrEmpty(updatedGenre.GenreName))
                this.GenreName = updatedGenre.GenreName;

        }
    }
}
