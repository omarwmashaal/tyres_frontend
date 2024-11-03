using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TruckTracking.Migrations
{
    /// <inheritdoc />
    public partial class correcteCurrentMileageName : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "CUrrentMileage",
                table: "Trucks",
                newName: "CurrentMileage");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "CurrentMileage",
                table: "Trucks",
                newName: "CUrrentMileage");
        }
    }
}
