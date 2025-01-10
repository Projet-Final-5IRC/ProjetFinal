using Models.Complexity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics.CodeAnalysis;

namespace ms_recommend_net.Models
{
    [Table("t_e_users_utl")]
    public class Users
    {
        [Key]
        [Column("usr_id")]
        public int IdUser { get; set; }

    }
}
