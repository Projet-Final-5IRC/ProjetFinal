using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace data.Migrations
{
    /// <inheritdoc />
    public partial class CreationBDSeries : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.EnsureSchema(
                name: "public");

            migrationBuilder.CreateTable(
                name: "t_e_genres_utl",
                schema: "public",
                columns: table => new
                {
                    gen_id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    gen_name = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_t_e_genres_utl", x => x.gen_id);
                });

            migrationBuilder.CreateTable(
                name: "t_e_users_utl",
                schema: "public",
                columns: table => new
                {
                    usr_id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    usr_nametag = table.Column<string>(type: "text", nullable: false),
                    usr_firstname = table.Column<string>(type: "text", nullable: true),
                    usr_lastname = table.Column<string>(type: "text", nullable: true),
                    usr_email = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    usr_password = table.Column<string>(type: "text", nullable: false),
                    usr_datecreation = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_t_e_users_utl", x => x.usr_id);
                });

            migrationBuilder.CreateTable(
                name: "t_e_events_utl",
                schema: "public",
                columns: table => new
                {
                    evt_id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    evt_name = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    gen_id = table.Column<int>(type: "integer", nullable: false),
                    evt_description = table.Column<string>(type: "character varying(500)", maxLength: 500, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_t_e_events_utl", x => x.evt_id);
                    table.ForeignKey(
                        name: "fk_genre_events",
                        column: x => x.gen_id,
                        principalSchema: "public",
                        principalTable: "t_e_genres_utl",
                        principalColumn: "gen_id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "t_e_eventsinvite_utl",
                schema: "public",
                columns: table => new
                {
                    ein_id = table.Column<int>(type: "integer", nullable: false),
                    evt_id = table.Column<int>(type: "integer", nullable: false),
                    usr_id = table.Column<int>(type: "integer", nullable: false),
                    ein_state = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_t_e_eventsinvite_utl", x => new { x.ein_id, x.evt_id, x.usr_id });
                    table.ForeignKey(
                        name: "fk_event_invitation",
                        column: x => x.evt_id,
                        principalSchema: "public",
                        principalTable: "t_e_events_utl",
                        principalColumn: "evt_id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "fk_users_invitation",
                        column: x => x.usr_id,
                        principalSchema: "public",
                        principalTable: "t_e_users_utl",
                        principalColumn: "usr_id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_t_e_events_utl_evt_id",
                schema: "public",
                table: "t_e_events_utl",
                column: "evt_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_events_utl_gen_id",
                schema: "public",
                table: "t_e_events_utl",
                column: "gen_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_eventsinvite_utl_ein_id",
                schema: "public",
                table: "t_e_eventsinvite_utl",
                column: "ein_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_eventsinvite_utl_evt_id",
                schema: "public",
                table: "t_e_eventsinvite_utl",
                column: "evt_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_eventsinvite_utl_usr_id",
                schema: "public",
                table: "t_e_eventsinvite_utl",
                column: "usr_id");

            migrationBuilder.CreateIndex(
                name: "IX_t_e_users_utl_usr_email",
                schema: "public",
                table: "t_e_users_utl",
                column: "usr_email",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "t_e_eventsinvite_utl",
                schema: "public");

            migrationBuilder.DropTable(
                name: "t_e_events_utl",
                schema: "public");

            migrationBuilder.DropTable(
                name: "t_e_users_utl",
                schema: "public");

            migrationBuilder.DropTable(
                name: "t_e_genres_utl",
                schema: "public");
        }
    }
}
