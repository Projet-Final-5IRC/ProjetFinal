using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace QuizzMS.Models.EntityFramework
{
    [Table("t_e_question_qst")] // Nom de la table
    public class Question
    {
        [Key]
        [Column("qst_id")] // Colonne primaire
        public int QuestionId { get; set; }

        [Required]
        [Column("qst_textequestion", TypeName = "text")] // Texte de la question
        public string TexteDeLaQuestion { get; set; }

        [Required]
        [Column("qst_reponsecorrecte", TypeName = "text")] // Réponse correcte
        public string ReponseCorrecte { get; set; }

        [Required]
        [ForeignKey("Quiz")]
        [Column("qst_quizid")] // Clé étrangère vers Quiz
        public int QuizId { get; set; }

        [InverseProperty("ListeDeQuestions")]
        [JsonIgnore]
        public Quiz Quiz { get; set; }

        // Nouvelle propriété pour les options
        [InverseProperty("Question")]
        public List<Option> Options { get; set; } = new();
    }
}