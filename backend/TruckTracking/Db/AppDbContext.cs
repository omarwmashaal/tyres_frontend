using Microsoft.EntityFrameworkCore;
using System.Runtime;

namespace TruckTracking.Db
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    }
}
