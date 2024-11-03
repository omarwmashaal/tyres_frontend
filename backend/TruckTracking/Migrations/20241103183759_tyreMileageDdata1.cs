using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TruckTracking.Migrations
{
    /// <inheritdoc />
    public partial class tyreMileageDdata1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "InstallEndMileage",
                table: "Tyres");

            migrationBuilder.DropColumn(
                name: "InstallStartMileage",
                table: "Tyres");

            migrationBuilder.RenameColumn(
                name: "TyreStartMileage",
                table: "Tyres",
                newName: "StartMileage");

            migrationBuilder.RenameColumn(
                name: "TyreEndMileage",
                table: "Tyres",
                newName: "EndMileage");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "StartMileage",
                table: "Tyres",
                newName: "TyreStartMileage");

            migrationBuilder.RenameColumn(
                name: "EndMileage",
                table: "Tyres",
                newName: "TyreEndMileage");

            migrationBuilder.AddColumn<int>(
                name: "InstallEndMileage",
                table: "Tyres",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "InstallStartMileage",
                table: "Tyres",
                type: "integer",
                nullable: true);
        }
    }
}
