namespace Product_Net.Models;

// This class maps to the 'Products' table in MySQL.
// EF Core will create the table automatically on first run.
public class Product
{
    // Id is the primary key; EF Core auto-increments this
    public int Id { get; set; }

    // Product name - cannot be null (required)
    public string Name { get; set; } = string.Empty;

    // Product category
    public string Category { get; set; } = string.Empty;

    // Price stored with decimal precision
    public decimal Price { get; set; }

    // Number of items in stock
    public int Quantity { get; set; }

    // Timestamp set automatically when product is created
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
