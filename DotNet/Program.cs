using Microsoft.EntityFrameworkCore;
using Product_Net.Data;

var builder = WebApplication.CreateBuilder(args);

// IMPORTANT: allow env vars from systemd
builder.Configuration.AddEnvironmentVariables();

builder.WebHost.UseUrls("http://0.0.0.0:5001");

// Get connection string
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

Console.WriteLine($"Connection String: {connectionString}");

// SAFE GUARD (STOP CRASH)
if (string.IsNullOrEmpty(connectionString))
{
    Console.WriteLine("❌ DB not configured. App will NOT start DB context.");
}
else
{
    builder.Services.AddDbContext<AppDbContext>(options =>
        options.UseMySql(
            connectionString,
            ServerVersion.AutoDetect(connectionString)
        )
    );
}

builder.Services.AddControllers();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        policy =>
        {
            policy.AllowAnyOrigin()
                  .AllowAnyMethod()
                  .AllowAnyHeader();
        });
});

var app = builder.Build();

// ONLY RUN DB IF CONNECTION EXISTS
if (!string.IsNullOrEmpty(connectionString))
{
    using (var scope = app.Services.CreateScope())
    {
        var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();

        try
        {
            db.Database.EnsureCreated();
            Console.WriteLine("Database connected successfully.");
        }
        catch (Exception ex)
        {
            Console.WriteLine("DATABASE ERROR:");
            Console.WriteLine(ex.ToString());
        }
    }
}

app.UseDefaultFiles();
app.UseStaticFiles();
app.UseCors("AllowAll");
app.UseAuthorization();
app.MapControllers();
app.Run();