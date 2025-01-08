using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.EntityFramework
{
    [Table("t_e_eventsinvite_utl")]
    [Index(nameof(idEventsInvite))]
    [PrimaryKey(nameof(idEventsInvite))]
    public class EventsInvite
    {
        [Key]
        [Column("ein_id")]
        public int idEventsInvite {  get; set; }

        [Required]
        [Column("evt_id")]
        public int IdEvent { get; set; }

        [Required]
        [Column("usr_id")]
        public int IdUser { get; set; }

        [Required]
        [Column("ein_state")]
        public bool IsPending { get; set; }

        [ForeignKey(nameof(IdEvent))]
        [InverseProperty(nameof(Events.EventInvitation))]
        public virtual Events? EventReference { get; set; } = null!;

        [ForeignKey(nameof(IdUser))]
        [InverseProperty(nameof(Users.UserInvitation))]
        public virtual Users? UserReference { get; set; } = null!;

        public void UpdateInviteValues(EventsInvite invite)
        {
            if (this.IsPending != invite.IsPending)
                this.IsPending = invite.IsPending;
        }
    }
}
