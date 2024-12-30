using data.Models.EntityFramework.Complexity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics.CodeAnalysis;

namespace data.Models.EntityFramework
{
    [Table("t_e_users_utl")]
    public class Users
    {
        [Key]
        [Column("usr_id")]
        public int IdUser { get; set; }

        [Required]
        [Column("usr_nametag")]
        public required string UserName { get; set; }

        [Column("usr_firstname")]
        public string? FirstName { get; set; }

        [Column("usr_lastname")]
        public string? LastName { get; set; }

        [Required]
        [Column("usr_email")]
        [EmailAddress]
        [StringLength(100, MinimumLength = 6, ErrorMessage = "Email lenght need to be between 6 and 100 char.")]
        public required string Email { get; set; }

        [Required]
        [PasswordComplexity]
        [Column("usr_password")]
        public required string Password { get; set; }

        [Column("usr_datecreation")]
        [NotNull]
        public DateTime DateCreation { get; set; } = DateTime.Now;

        [InverseProperty(nameof(EventsInvite.UserReference))]
        public virtual ICollection<EventsInvite> UserInvitation { get; set; } = new List<EventsInvite>();
    }
}
