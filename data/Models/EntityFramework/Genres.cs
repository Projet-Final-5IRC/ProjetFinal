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

        [InverseProperty(nameof(Events.EventGenre))]
        public virtual ICollection<Events> GenreEvent {  get; set; } = new List<Events>();
    }
}
