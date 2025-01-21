using data.Models.DTO;
using data.Models.EntityFramework.Complexity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics.CodeAnalysis;
using System.Text.Json.Serialization;

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
        public string UserName { get; set; }

        [Column("usr_firstname")]
        public string? FirstName { get; set; }

        [Column("usr_lastname")]
        public string? LastName { get; set; }

        [Required]
        [Column("usr_email")]
        [EmailAddress]
        [StringLength(100, MinimumLength = 6, ErrorMessage = "Email lenght need to be between 6 and 100 char.")]
        public string Email { get; set; }

        [Required]
        [PasswordComplexity]
        [Column("usr_password")]
        public string Password { get; set; }

        [Column("usr_datecreation")]
        [NotNull]
        [DateComplexity]
        public string DateCreation { get; set; }

        [JsonIgnore]
        public virtual ICollection<EventsInvite> UserInvitation { get; set; } = new List<EventsInvite>();

        [JsonIgnore]
        public virtual ICollection<Events> EventOwned { get; set; } = new List<Events>();

        [JsonIgnore]
        public virtual ICollection<Preference> UserPreference { get; set; } = new List<Preference>();

        public void UpdateUserValues(Users updatedUser)
        {
            if (!string.IsNullOrEmpty(updatedUser.Email))
                this.Email = updatedUser.Email;

            if (!string.IsNullOrEmpty(updatedUser.FirstName))
                this.FirstName = updatedUser.FirstName;

            if (!string.IsNullOrEmpty(updatedUser.LastName))
                this.LastName = updatedUser.LastName;

            if (!string.IsNullOrEmpty(updatedUser.UserName))
                this.UserName = updatedUser.UserName;

            if (!string.IsNullOrEmpty(updatedUser.Password))
                this.Password = updatedUser.Password;

            if (updatedUser.DateCreation != default)
                this.DateCreation = updatedUser.DateCreation;
        }
    }
}
