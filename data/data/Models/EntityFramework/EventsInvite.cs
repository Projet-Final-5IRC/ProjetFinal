using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.EntityFramework
{
    [Table("t_e_eventsinvite_utl")]
    [Index(nameof(idEventsInvite))]
    [PrimaryKey(nameof(idEventsInvite),nameof(IdEvent),nameof(IdUser))]
    public class EventsInvite
    {
        [Key]
        [Column("ein_id")]
        public int idEventsInvite {  get; set; }

        [Key]
        [Required]
        [Column("evt_id")]
        public int IdEvent { get; set; }

        [Key]
        [Required]
        [Column("usr_id")]
        public int IdUser { get; set; }

        [Required]
        [Column("ein_state")]
        public bool IsPending { get; set; }

        [ForeignKey(nameof(IdEvent))]
        [InverseProperty(nameof(Events.EventInvitation))]
        public virtual Events EventReference { get; set; } = null!;

        [ForeignKey(nameof(IdUser))]
        [InverseProperty(nameof(Users.UserInvitation))]
        public virtual Users UserReference { get; set; } = null!;
    }
}
