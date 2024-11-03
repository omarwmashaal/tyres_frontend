using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TruckTracking.Migrations
{
    /// <inheritdoc />
    public partial class addTyreLogs1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Mileage",
                table: "TyreLogs",
                type: "integer",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Mileage",
                table: "TyreLogs");
        }
    }
}
