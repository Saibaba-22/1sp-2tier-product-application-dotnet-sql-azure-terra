using Microsoft.EntityFrameworkCore;
using Product_Net.Models;

namespace Product_Net.Data;

public class AppDbContext : DbContext
{
    // Constructor: receives configuration injected by ASP.NET Core
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options) { }

    // DbSet = represents the 'Products' table in MySQL
    // You use this to query and save products
    public DbSet<Product> Products { get; set; }
}
