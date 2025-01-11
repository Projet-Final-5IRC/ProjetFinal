using data.Models.DTO;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace data.Models.EntityFramework
{
    [Table("t_e_preference_utl")]
    [Index(nameof(IdPreference))]
    [PrimaryKey(nameof(IdPreference))]
    public class Preference
    {
        [Key]
        [Column("prf_id")]
        public int IdPreference { get; set; }

        [Required]
        [Column("usr_id")]
        public int IdUser { get; set; }

        [Required]
        [Column("gen_id")]
        public int IdGenre { get; set; }

        [ForeignKey(nameof(IdUser))]
        [InverseProperty(nameof(Users.UserPreference))]
        public virtual Users? UserReference { get; set; } = null!;

        [ForeignKey(nameof(IdGenre))]
        [InverseProperty(nameof(Genres.GenrePreference))]
        public virtual Genres? GenreReference { get; set; } = null!;

        public void UpdatePreferenceValue(Preference preference)
        {
            this.IdPreference = preference.IdPreference;
            this.IdUser = preference.IdUser;
            this.IdGenre = preference.IdGenre;
        }

        public Preference() { }
        public Preference(PreferenceDTO preference)
        {
            this.IdGenre = preference.IdGenre;
            this.IdUser = preference.IdUser;
        }
    }
}
