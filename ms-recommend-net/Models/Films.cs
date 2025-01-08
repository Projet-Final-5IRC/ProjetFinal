using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ms_recommend_net.Models
{
    public class Films
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; } // Primary key
        public string Name { get; set; } = string.Empty; // Initialized to prevent null warning
        public string Genre { get; set; } = string.Empty; // Initialized to prevent null warning
        public string Description { get; set; } = string.Empty; // Initialized to prevent null warning
    }
}
