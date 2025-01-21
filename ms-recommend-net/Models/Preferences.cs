using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ms_recommend_net.Models
{
    public class Preference
    {
        public int PrfId { get; set; } // Primary key
        public int UserId { get; set; } // Foreign key to User
        public int GenId { get; set; } // Foreign key to Genre
    }

}