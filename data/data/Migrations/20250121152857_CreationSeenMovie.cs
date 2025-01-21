using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace data.Migrations
{
    /// <inheritdoc />
    public partial class CreationSeenMovie : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "t_e_liked_movies_utl",
                schema: "public",
                columns: table => new
                {
                    lik_id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    lik_idtmdb = table.Column<int>(type: "integer", nullable: false),
                    usr_id = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_t_e_liked_movies_utl", x => x.lik_id);
                    table.ForeignKey(
                        name: "fk_liked_movie",
                        column: x => x.usr_id,
                        principalSchema: "public",
                        principalTable: "t_e_users_utl",
                        principalColumn: "usr_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "t_e_seen_movies_utl",
                schema: "public",
                columns: table => new
                {
                    sem_id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    sem_idtmdb = table.Column<int>(type: "integer", nullable: false),
                    usr_id = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_t_e_seen_movies_utl", x => x.sem_id);
                    table.ForeignKey(
                        name: "fk_seen_movie",
                        column: x => x.usr_id,
                        principalSchema: "public",
                        principalTable: "t_e_users_utl",
                        principalColumn: "usr_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_t_e_liked_movies_utl_lik_id",
                schema: "public",
                table: "t_e_liked_movies_utl",
                column: "lik_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_liked_movies_utl_usr_id",
                schema: "public",
                table: "t_e_liked_movies_utl",
                column: "usr_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_seen_movies_utl_sem_id",
                schema: "public",
                table: "t_e_seen_movies_utl",
                column: "sem_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_seen_movies_utl_usr_id",
                schema: "public",
                table: "t_e_seen_movies_utl",
                column: "usr_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "t_e_liked_movies_utl",
                schema: "public");

            migrationBuilder.DropTable(
                name: "t_e_seen_movies_utl",
                schema: "public");
        }
    }
}
