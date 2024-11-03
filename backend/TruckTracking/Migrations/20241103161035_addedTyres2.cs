using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TruckTracking.Migrations
{
    /// <inheritdoc />
    public partial class addedTyres2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Position_side",
                table: "Tyres",
                newName: "Position_Side");

            migrationBuilder.RenameColumn(
                name: "Position_index",
                table: "Tyres",
                newName: "Position_Index");

            migrationBuilder.RenameColumn(
                name: "Position_direction",
                table: "Tyres",
                newName: "Position_Direction");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Position_Side",
                table: "Tyres",
                newName: "Position_side");

            migrationBuilder.RenameColumn(
                name: "Position_Index",
                table: "Tyres",
                newName: "Position_index");

            migrationBuilder.RenameColumn(
                name: "Position_Direction",
                table: "Tyres",
                newName: "Position_direction");
        }
    }
}
