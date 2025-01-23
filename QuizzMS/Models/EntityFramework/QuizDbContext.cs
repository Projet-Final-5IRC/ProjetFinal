// Models/EntityFramework/QuizDbContext.cs
using Microsoft.EntityFrameworkCore;

namespace QuizzMS.Models.EntityFramework
{
    public class QuizDbContext : DbContext
    {
        public QuizDbContext(DbContextOptions<QuizDbContext> options) : base(options) { }

        // DbSet pour Quiz
        public DbSet<Quiz> Quizzes { get; set; }

        // DbSet pour Question
        public DbSet<Question> Questions { get; set; }

        // DbSet pour Option
        public DbSet<Option> Options { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Configuration de la table Quiz
            modelBuilder.Entity<Quiz>(entity =>
            {
                entity.ToTable("t_e_quiz_quz");

                entity.HasKey(e => e.QuizId)
                      .HasName("PK_quiz");

                entity.Property(e => e.QuizId)
                      .HasColumnName("quz_id")
                      .ValueGeneratedOnAdd();

                entity.Property(e => e.TitreDuQuiz)
                      .HasColumnName("quz_titre")
                      .HasMaxLength(100)
                      .IsRequired();

                entity.Property(e => e.DescriptionDuQuiz)
                      .HasColumnName("quz_description")
                      .HasColumnType("text");

                entity.Property(e => e.TitreDuFilm)
                      .HasColumnName("quz_titrefilm")
                      .HasMaxLength(100);

                entity.Property(e => e.FilmId)
                      .HasColumnName("quz_filmid")
                      .HasMaxLength(50)
                      .IsRequired();

                entity.HasMany(e => e.ListeDeQuestions)
                      .WithOne(e => e.Quiz)
                      .HasForeignKey(e => e.QuizId)
                      .HasConstraintName("FK_question_quiz");
            });

            // Configuration de la table Question
            modelBuilder.Entity<Question>(entity =>
            {
                entity.ToTable("t_e_question_qst");

                entity.HasKey(e => e.QuestionId)
                      .HasName("PK_question");

                entity.Property(e => e.QuestionId)
                      .HasColumnName("qst_id")
                      .ValueGeneratedOnAdd();

                entity.Property(e => e.TexteDeLaQuestion)
                      .HasColumnName("qst_textequestion")
                      .HasColumnType("text")
                      .IsRequired();

                entity.Property(e => e.ReponseCorrecte)
                      .HasColumnName("qst_reponsecorrecte")
                      .HasColumnType("text")
                      .IsRequired();

                entity.Property(e => e.QuizId)
                      .HasColumnName("qst_quizid")
                      .IsRequired();

                entity.HasOne(e => e.Quiz)
                      .WithMany(e => e.ListeDeQuestions)
                      .HasForeignKey(e => e.QuizId)
                      .HasConstraintName("FK_question_quiz");

                // Configuration de la relation un-à-plusieurs avec Option
                entity.HasMany(e => e.Options)
                      .WithOne(o => o.Question)
                      .HasForeignKey(o => o.QuestionId)
                      .HasConstraintName("FK_option_question");
            });

            // Configuration de la table Option
            modelBuilder.Entity<Option>(entity =>
            {
                entity.ToTable("t_e_option_opt");

                entity.HasKey(e => e.OptionId)
                      .HasName("PK_option");

                entity.Property(e => e.OptionId)
                      .HasColumnName("opt_id")
                      .ValueGeneratedOnAdd();

                entity.Property(e => e.Texte)
                      .HasColumnName("opt_texte")
                      .HasColumnType("text")
                      .IsRequired();

                entity.Property(e => e.EstCorrecte)
                      .HasColumnName("opt_est_correcte")
                      .IsRequired();

                entity.Property(e => e.QuestionId)
                      .HasColumnName("opt_questionid")
                      .IsRequired();

                entity.HasOne(e => e.Question)
                      .WithMany(q => q.Options)
                      .HasForeignKey(e => e.QuestionId)
                      .HasConstraintName("FK_option_question");
            });
        }
    }
}