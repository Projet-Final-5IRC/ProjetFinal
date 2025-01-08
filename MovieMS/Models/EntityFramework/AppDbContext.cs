using Microsoft.EntityFrameworkCore;
using MovieMS.Models.EntityFramework;

namespace MovieMS.Models.EntityFramework;

public class AppDbContext : DbContext
{
    public DbSet<Movie> Movies { get; set; }

    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }
}