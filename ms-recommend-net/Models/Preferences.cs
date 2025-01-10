using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ms_recommend_net.Models
{
    public class Preference
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; } // Primary key

        public int UserId { get; set; } // Foreign key

        public string Type { get; set; } = string.Empty; // Maps to 'type' column in the database

        public string Value { get; set; } = string.Empty; // Maps to 'value' column in the database

    }

}