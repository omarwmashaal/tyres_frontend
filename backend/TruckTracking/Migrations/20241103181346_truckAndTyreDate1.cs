using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TruckTracking.Migrations
{
    /// <inheritdoc />
    public partial class truckAndTyreDate1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "InstalledDate",
                table: "Tyres",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "InstalledDate",
                table: "Tyres");
        }
    }
}
