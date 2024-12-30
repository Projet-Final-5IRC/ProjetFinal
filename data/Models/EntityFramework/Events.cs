using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.EntityFramework
{
    [Table("t_e_events_utl")]
    public partial class Events
    {
        [Key]
        [Column("evt_id")]
        public int IdEvent { get; set; }

        [Required]
        [Column("evt_name")]
        [MaxLength(50)]
        public required string EventName { get; set; }

        [Column("gen_id")]
        public int? IdGenre { get; set; }


        [Column("evt_description")]
        [MaxLength(500)]
        public string? EventDescription { get; set; }

        [ForeignKey(nameof(IdGenre))]
        [InverseProperty(nameof(Genres.IdGenre))]
        public virtual Genres EventGenre { get; set; } = null!;

        [InverseProperty(nameof(EventsInvite.EventReference))]
        public virtual ICollection<EventsInvite> EventInvitation { get; set; } = new List<EventsInvite>();
    }
}
