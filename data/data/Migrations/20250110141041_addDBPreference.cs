using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace data.Migrations
{
    /// <inheritdoc />
    public partial class addDBPreference : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_genre_events",
                schema: "public",
                table: "t_e_events_utl");

            migrationBuilder.DropForeignKey(
                name: "fk_owner_events",
                schema: "public",
                table: "t_e_events_utl");

            migrationBuilder.DropForeignKey(
                name: "fk_event_invitation",
                schema: "public",
                table: "t_e_eventsinvite_utl");

            migrationBuilder.DropForeignKey(
                name: "fk_users_invitation",
                schema: "public",
                table: "t_e_eventsinvite_utl");

            migrationBuilder.CreateTable(
                name: "t_e_preference_utl",
                schema: "public",
                columns: table => new
                {
                    prf_id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    usr_id = table.Column<int>(type: "integer", nullable: false),
                    gen_id = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_t_e_preference_utl", x => x.prf_id);
                    table.ForeignKey(
                        name: "fk_genre_preference",
                        column: x => x.gen_id,
                        principalSchema: "public",
                        principalTable: "t_e_genres_utl",
                        principalColumn: "gen_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_user_preference",
                        column: x => x.usr_id,
                        principalSchema: "public",
                        principalTable: "t_e_users_utl",
                        principalColumn: "usr_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_t_e_preference_utl_gen_id",
                schema: "public",
                table: "t_e_preference_utl",
                column: "gen_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_preference_utl_prf_id",
                schema: "public",
                table: "t_e_preference_utl",
                column: "prf_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_preference_utl_usr_id",
                schema: "public",
                table: "t_e_preference_utl",
                column: "usr_id");

            migrationBuilder.AddForeignKey(
                name: "fk_genre_events",
                schema: "public",
                table: "t_e_events_utl",
                column: "gen_id",
                principalSchema: "public",
                principalTable: "t_e_genres_utl",
                principalColumn: "gen_id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_owner_events",
                schema: "public",
                table: "t_e_events_utl",
                column: "usr_id",
                principalSchema: "public",
                principalTable: "t_e_users_utl",
                principalColumn: "usr_id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_event_invitation",
                schema: "public",
                table: "t_e_eventsinvite_utl",
                column: "evt_id",
                principalSchema: "public",
                principalTable: "t_e_events_utl",
                principalColumn: "evt_id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_users_invitation",
                schema: "public",
                table: "t_e_eventsinvite_utl",
                column: "usr_id",
                principalSchema: "public",
                principalTable: "t_e_users_utl",
                principalColumn: "usr_id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_genre_events",
                schema: "public",
                table: "t_e_events_utl");

            migrationBuilder.DropForeignKey(
                name: "fk_owner_events",
                schema: "public",
                table: "t_e_events_utl");

            migrationBuilder.DropForeignKey(
                name: "fk_event_invitation",
                schema: "public",
                table: "t_e_eventsinvite_utl");

            migrationBuilder.DropForeignKey(
                name: "fk_users_invitation",
                schema: "public",
                table: "t_e_eventsinvite_utl");

            migrationBuilder.DropTable(
                name: "t_e_preference_utl",
                schema: "public");

            migrationBuilder.AddForeignKey(
                name: "fk_genre_events",
                schema: "public",
                table: "t_e_events_utl",
                column: "gen_id",
                principalSchema: "public",
                principalTable: "t_e_genres_utl",
                principalColumn: "gen_id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_owner_events",
                schema: "public",
                table: "t_e_events_utl",
                column: "usr_id",
                principalSchema: "public",
                principalTable: "t_e_users_utl",
                principalColumn: "usr_id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_event_invitation",
                schema: "public",
                table: "t_e_eventsinvite_utl",
                column: "evt_id",
                principalSchema: "public",
                principalTable: "t_e_events_utl",
                principalColumn: "evt_id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_users_invitation",
                schema: "public",
                table: "t_e_eventsinvite_utl",
                column: "usr_id",
                principalSchema: "public",
                principalTable: "t_e_users_utl",
                principalColumn: "usr_id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
