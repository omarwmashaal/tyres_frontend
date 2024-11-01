using Microsoft.EntityFrameworkCore;
using System.Runtime;
using TruckTracking.Models;

namespace TruckTracking.Db
{
    public class AppDbContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    }
}
