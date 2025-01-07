using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using ms_evt.Models.EntityFramework.Complexity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.EntityFramework
{
    [Table("t_e_events_utl")]
    [Index(nameof(IdEvent))]
    [PrimaryKey(nameof(IdEvent))]
    public partial class Events
    {
        [Key]
        [Column("evt_id")]
        public int IdEvent { get; set; }

        [Required]
        [Column("evt_name")]
        [MaxLength(50)]
        public string EventName { get; set; }

        [Column("evt_hour")]
        [HourComplexity]
        public string? EventHour { get; set; }

        [Column("evt_date")]
        [DateComplexity]
        public string? EventDate { get; set; }

        [Column("evt_location")]
        public string? EventLocation { get; set; }

        [Column("gen_id")]
        public int? IdGenre { get; set; }

        [Column("evt_description")]
        [MaxLength(500)]
        public string? EventDescription { get; set; }

        [ForeignKey(nameof(IdGenre))]
        [InverseProperty(nameof(Genres.EventsGenre))]
        public virtual Genres? GenreEvent { get; set; } = null!;

        public virtual ICollection<EventsInvite>? EventInvitation { get; set; } = new List<EventsInvite>();
    }
}
