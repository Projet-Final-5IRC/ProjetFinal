using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace QuizzMS.Models.EntityFramework
{
    [Table("t_e_option_opt")] // Nom de la table
    public class Option
    {
        [Key]
        [Column("opt_id")] // Colonne primaire
        public int OptionId { get; set; }

        [Required]
        [Column("opt_texte", TypeName = "text")] // Texte de l'option
        public string Texte { get; set; }

        [Column("opt_est_correcte")] // Indique si l'option est correcte
        public bool EstCorrecte { get; set; }

        [Required]
        [ForeignKey("Question")]
        [Column("opt_questionid")] // Clé étrangère vers Question
        public int QuestionId { get; set; }

        [InverseProperty("Options")]
        [JsonIgnore]
        public Question Question { get; set; }
    }
}