using Microsoft.EntityFrameworkCore;
using ms_badge.Models;

namespace ms_badge.Db
{
    public class BadgeContext : DbContext
    {
        public BadgeContext(DbContextOptions<BadgeContext> options) : base(options) { }
        public DbSet<Badge> Badges { get; set; }
        public DbSet<UserBadge> UserBadges { get; set; }

    }
}
