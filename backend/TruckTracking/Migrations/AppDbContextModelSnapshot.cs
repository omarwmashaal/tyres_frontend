﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using TruckTracking.Db;

#nullable disable

namespace TruckTracking.Migrations
{
    [DbContext(typeof(AppDbContext))]
    partial class AppDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.20")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("TruckTracking.Models.Truck", b =>
                {
                    b.Property<int?>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int?>("Id"));

                    b.Property<int?>("CurrentMileage")
                        .HasColumnType("integer");

                    b.Property<DateTime>("LastUpdatedMileageDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("PlatNo")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Trucks");
                });

            modelBuilder.Entity("TruckTracking.Models.Tyre", b =>
                {
                    b.Property<int?>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int?>("Id"));

                    b.Property<DateTime?>("AddedDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<int?>("EndMileage")
                        .HasColumnType("integer");

                    b.Property<DateTime?>("InstalledDate")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Model")
                        .HasColumnType("text");

                    b.Property<string>("Serial")
                        .HasColumnType("text");

                    b.Property<int?>("StartMileage")
                        .HasColumnType("integer");

                    b.Property<int?>("TruckId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("TruckId");

                    b.ToTable("Tyres");
                });

            modelBuilder.Entity("TruckTracking.Models.TyreLog", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer");

                    NpgsqlPropertyBuilderExtensions.UseIdentityByDefaultColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("Date")
                        .HasColumnType("timestamp with time zone");

                    b.Property<int>("Mileage")
                        .HasColumnType("integer");

                    b.Property<int>("Status")
                        .HasColumnType("integer");

                    b.Property<int?>("TruckId")
                        .HasColumnType("integer");

                    b.Property<string>("TruckPlateNo")
                        .HasColumnType("text");

                    b.Property<int>("TyreId")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("TyreId");

                    b.ToTable("TyreLogs");
                });

            modelBuilder.Entity("TruckTracking.Models.User", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("text");

                    b.Property<int>("AccessFailedCount")
                        .HasColumnType("integer");

                    b.Property<string>("ConcurrencyStamp")
                        .HasColumnType("text");

                    b.Property<string>("Email")
                        .HasColumnType("text");

                    b.Property<bool>("EmailConfirmed")
                        .HasColumnType("boolean");

                    b.Property<bool>("LockoutEnabled")
                        .HasColumnType("boolean");

                    b.Property<DateTimeOffset?>("LockoutEnd")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("NormalizedEmail")
                        .HasColumnType("text");

                    b.Property<string>("NormalizedUserName")
                        .HasColumnType("text");

                    b.Property<string>("PasswordHash")
                        .HasColumnType("text");

                    b.Property<string>("PhoneNumber")
                        .HasColumnType("text");

                    b.Property<bool>("PhoneNumberConfirmed")
                        .HasColumnType("boolean");

                    b.Property<string>("SecurityStamp")
                        .HasColumnType("text");

                    b.Property<bool>("TwoFactorEnabled")
                        .HasColumnType("boolean");

                    b.Property<string>("UserName")
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("TruckTracking.Models.Tyre", b =>
                {
                    b.HasOne("TruckTracking.Models.Truck", null)
                        .WithMany("Tyres")
                        .HasForeignKey("TruckId");

                    b.OwnsOne("TruckTracking.Models.TyrePosition", "Position", b1 =>
                        {
                            b1.Property<int>("TyreId")
                                .HasColumnType("integer");

                            b1.Property<int?>("Direction")
                                .HasColumnType("integer")
                                .HasColumnName("Position_Direction");

                            b1.Property<int?>("Index")
                                .HasColumnType("integer")
                                .HasColumnName("Position_Index");

                            b1.Property<int?>("Side")
                                .HasColumnType("integer")
                                .HasColumnName("Position_Side");

                            b1.HasKey("TyreId");

                            b1.ToTable("Tyres");

                            b1.WithOwner()
                                .HasForeignKey("TyreId");
                        });

                    b.Navigation("Position");
                });

            modelBuilder.Entity("TruckTracking.Models.TyreLog", b =>
                {
                    b.HasOne("TruckTracking.Models.Tyre", "Tyre")
                        .WithMany()
                        .HasForeignKey("TyreId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Tyre");
                });

            modelBuilder.Entity("TruckTracking.Models.Truck", b =>
                {
                    b.Navigation("Tyres");
                });
#pragma warning restore 612, 618
        }
    }
}
