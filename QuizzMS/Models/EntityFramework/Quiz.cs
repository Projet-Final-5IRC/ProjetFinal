using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuizzMS.Models.EntityFramework
{
    [Table("t_e_quiz_quz")] // Nom de la table
    public class Quiz
    {
        [Key]
        [Column("quz_id")] // Colonne primaire
        public int QuizId { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("quz_titre")] // Colonne titre du quiz
        public string TitreDuQuiz { get; set; }

        [Column("quz_description", TypeName = "text")] // Colonne description
        public string DescriptionDuQuiz { get; set; }

        [Column("quz_titrefilm")]
        [MaxLength(100)]
        public string TitreDuFilm { get; set; }

        [Required]
        [MaxLength(50)]
        [Column("quz_filmid")] // Nouveau champ pour lier le quiz au film
        public string FilmId { get; set; }

        [InverseProperty("Quiz")]
        public List<Question> ListeDeQuestions { get; set; } = new();
    }
}