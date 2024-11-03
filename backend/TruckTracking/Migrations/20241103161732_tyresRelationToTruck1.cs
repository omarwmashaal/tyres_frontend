using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TruckTracking.Migrations
{
    /// <inheritdoc />
    public partial class tyresRelationToTruck1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Tyres_TruckId",
                table: "Tyres",
                column: "TruckId");

            migrationBuilder.AddForeignKey(
                name: "FK_Tyres_Trucks_TruckId",
                table: "Tyres",
                column: "TruckId",
                principalTable: "Trucks",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Tyres_Trucks_TruckId",
                table: "Tyres");

            migrationBuilder.DropIndex(
                name: "IX_Tyres_TruckId",
                table: "Tyres");
        }
    }
}
