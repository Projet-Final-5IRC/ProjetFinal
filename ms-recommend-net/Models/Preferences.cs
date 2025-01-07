using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ms_recommend_net.Models
{
    public class Preference
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; } // Primary key
        public int UserId { get; set; }
        public string Genre { get; set; } = string.Empty; // Initialized to prevent null warning
        public string Actor { get; set; } = string.Empty; // Added Actor preference
        public string Director { get; set; } = string.Empty; // Added Director preference
        public Users User { get; set; } = null!; // Marked as non-nullable and must be initialized
    }
}