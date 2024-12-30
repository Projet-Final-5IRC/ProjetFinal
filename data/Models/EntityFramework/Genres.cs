using Microsoft.EntityFrameworkCore.Infrastructure;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.EntityFramework
{
    [Table("t_e_genres_utl")]
    public class Genres
    {
        [Key]
        [Column("gen_id")]
        public int IdGenre { get; set; }

        [Required]
        [Column("gen_name")]
        public required string GenreName { get; set; }

        public virtual ICollection<Events> EventsGenre { get; set; } = new List<Events>();
    }
}
