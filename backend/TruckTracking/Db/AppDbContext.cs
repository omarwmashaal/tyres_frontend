using Microsoft.EntityFrameworkCore;
using System.Runtime;
using TruckTracking.Models;

namespace TruckTracking.Db
{
    public class AppDbContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Truck> Trucks { get; set; }
        public DbSet<Tyre> Tyres { get; set; }
        public DbSet<TyreLog> TyreLogs { get; set; }
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Tyre>()
                .HasOne<Truck>()
                .WithMany(t => t.Tyres)
                .HasForeignKey(t => t.TruckId);

            modelBuilder.Entity<Tyre>()
               .OwnsOne(t => t.Position, p =>
               {
                   p.Property(tp => tp.Direction).HasColumnName("Position_Direction").IsRequired(false);
                   p.Property(tp => tp.Side).HasColumnName("Position_Side").IsRequired(false);
                   p.Property(tp => tp.Index).HasColumnName("Position_Index").IsRequired(false);
               });
        }

    }
}
