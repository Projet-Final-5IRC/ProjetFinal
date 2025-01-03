﻿using Microsoft.EntityFrameworkCore;
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

        public static readonly ILoggerFactory MyLoggerFactory = LoggerFactory.Create(builder => builder.AddConsole());
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder.UseLoggerFactory(MyLoggerFactory)
                                .EnableSensitiveDataLogging();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasDefaultSchema("public");

            modelBuilder.Entity<Events>(entity =>
            {
                entity.HasOne(d => d.GenreEvent).WithMany(p => p.EventsGenre)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_genre_events");
            });

            modelBuilder.Entity<EventsInvite>(entity =>
            {
                entity.HasOne(d => d.UserReference).WithMany(p => p.UserInvitation)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_users_invitation");

                entity.HasOne(d => d.EventReference).WithMany(p => p.EventInvitation)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("fk_event_invitation");
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
