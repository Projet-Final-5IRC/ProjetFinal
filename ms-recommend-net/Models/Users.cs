using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ms_recommend_net.Models
{
    public class Users
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id_user { get; set; } // Primary key
        public string Username { get; set; } = string.Empty; // Initialized to prevent null warning
        public ICollection<Preference> Preferences { get; set; } = new List<Preference>(); // Initialized to prevent null warning
    }
}
