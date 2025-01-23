using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace QuizzMS.Migrations
{
    /// <inheritdoc />
    public partial class NewModelForMCQ : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "t_e_quiz_quz",
                columns: table => new
                {
                    quz_id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    quz_titre = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    quz_description = table.Column<string>(type: "text", nullable: false),
                    quz_titrefilm = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    quz_filmid = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_quiz", x => x.quz_id);
                });

            migrationBuilder.CreateTable(
                name: "t_e_question_qst",
                columns: table => new
                {
                    qst_id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    qst_textequestion = table.Column<string>(type: "text", nullable: false),
                    qst_reponsecorrecte = table.Column<string>(type: "text", nullable: false),
                    qst_quizid = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_question", x => x.qst_id);
                    table.ForeignKey(
                        name: "FK_question_quiz",
                        column: x => x.qst_quizid,
                        principalTable: "t_e_quiz_quz",
                        principalColumn: "quz_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "t_e_option_opt",
                columns: table => new
                {
                    opt_id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    opt_texte = table.Column<string>(type: "text", nullable: false),
                    opt_est_correcte = table.Column<bool>(type: "boolean", nullable: false),
                    opt_questionid = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_option", x => x.opt_id);
                    table.ForeignKey(
                        name: "FK_option_question",
                        column: x => x.opt_questionid,
                        principalTable: "t_e_question_qst",
                        principalColumn: "qst_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_t_e_option_opt_opt_questionid",
                table: "t_e_option_opt",
                column: "opt_questionid");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_question_qst_qst_quizid",
                table: "t_e_question_qst",
                column: "qst_quizid");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "t_e_option_opt");

            migrationBuilder.DropTable(
                name: "t_e_question_qst");

            migrationBuilder.DropTable(
                name: "t_e_quiz_quz");
        }
    }
}
