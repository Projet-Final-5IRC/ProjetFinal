using Microsoft.EntityFrameworkCore;
using System.Reflection.Emit;

namespace data.Models.EntityFramework
{
    public partial class EventDBContext : DbContext
    {
        public EventDBContext() { }

        public EventDBContext(DbContextOptions<EventDBContext> options) : base(options) { }

        public virtual DbSet<Events> Event { get; set; }
        public virtual DbSet<Users> User { get; set; }
        public virtual DbSet<Genres> Genre { get; set; }
        public virtual DbSet<EventsInvite> EventInvite { get; set; }
        public virtual DbSet<Preference> Preference { get; set; }

        public static readonly ILoggerFactory MyLoggerFactory = LoggerFactory.Create(builder => builder.AddConsole());
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder.UseLazyLoadingProxies().UseLoggerFactory(MyLoggerFactory)
                                .EnableSensitiveDataLogging();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema("public");

            modelBuilder.Entity<Events>(entity =>
            {
                entity.HasOne(d => d.GenreEvent).WithMany(p => p.EventsGenre)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("fk_genre_events");
                entity.HasOne(d => d.UserOwner).WithMany(p => p.EventOwned)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("fk_owner_events");
            });

            modelBuilder.Entity<EventsInvite>(entity =>
            {
                entity.HasOne(d => d.UserReference).WithMany(p => p.UserInvitation)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("fk_users_invitation");

                entity.HasOne(d => d.EventReference).WithMany(p => p.EventInvitation)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("fk_event_invitation");
            });

            modelBuilder.Entity<Preference>(entity =>
            {
                entity.HasOne(d => d.UserReference).WithMany(p => p.UserPreference)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("fk_user_preference");

                entity.HasOne(d => d.GenreReference).WithMany(p => p.GenrePreference)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("fk_genre_preference");
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasIndex(u => u.Email).IsUnique();
            });

            OnModelCreatingPartial(modelBuilder);
        }
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
