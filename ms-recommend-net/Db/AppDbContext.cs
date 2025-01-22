using Microsoft.EntityFrameworkCore;
using ms_recommend_net.Models;

namespace ms_recommend_net.Db
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Users> Users { get; set; }
        public DbSet<Preference> Preferences { get; set; } // Maps to t_e_preference_utl
        public DbSet<Genre> Genres { get; set; } // Maps to t_e_genres_utl
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Users>().HasKey(u => u.IdUser);

            // Map Preference to t_e_preference_utl
            modelBuilder.Entity<Preference>(entity =>
            {
                entity.ToTable("t_e_preference_utl");
                entity.HasKey(e => e.PrfId);
                entity.Property(e => e.UserId).HasColumnName("usr_id");
                entity.Property(e => e.PrfId).HasColumnName("prf_id");
                entity.Property(e => e.GenId).HasColumnName("gen_id");
            });

            // Map Genre to t_e_genres_utl
            modelBuilder.Entity<Genre>(entity =>
            {
                entity.ToTable("t_e_genres_utl");
                entity.HasKey(e => e.GenId);
                entity.Property(e => e.GenId).HasColumnName("gen_id");
                entity.Property(e => e.GenName).HasColumnName("gen_name");
                entity.Property(e => e.GenTmid).HasColumnName("gen_tmid");
            });
        }

    }
}
