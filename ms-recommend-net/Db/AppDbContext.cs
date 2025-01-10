using Microsoft.EntityFrameworkCore;
using ms_recommend_net.Models;

namespace ms_recommend_net.Db
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Users> Users { get; set; }
        public DbSet<Preference> Preferences { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Users>().HasKey(u => u.IdUser);
            modelBuilder.Entity<Preference>().HasKey(p => p.Id);
        }

    }
}
