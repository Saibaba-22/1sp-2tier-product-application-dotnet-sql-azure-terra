using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Product_Net.Data;
using Product_Net.Models;

namespace Product_Net.Controllers;

[ApiController]
[Route("api/[controller]")]    // URL prefix: api/products
public class ProductsController : ControllerBase
{
    private readonly AppDbContext _db;

    // Constructor injection: ASP.NET Core provides the DbContext automatically
    public ProductsController(AppDbContext db) { _db = db; }

    // ── GET api/products  ────────────────── get all products ──
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        try
        {
            var products = await _db.Products.ToListAsync();
            return Ok(products);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new
            {
                error = ex.Message,
                inner = ex.InnerException?.Message
            });
        }
    }

    // ── GET api/products/{id}  ───────────── get one product ───
    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var product = await _db.Products.FindAsync(id);
        if (product == null) return NotFound("Product not found");
        return Ok(product);
    }

    // ── POST api/products  ───────────────── create product ────
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] Product product)
    {
        try
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            product.CreatedAt = DateTime.UtcNow;

            _db.Products.Add(product);
            await _db.SaveChangesAsync();

            return CreatedAtAction(nameof(GetById), new { id = product.Id }, product);
        }
        catch (Exception ex)
        {
            return StatusCode(500, new
            {
                error = ex.Message,
                inner = ex.InnerException?.Message
            });
        }
    }

    // ── PUT api/products/{id}  ───────────── update product ────
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] Product updated)
    {
        var product = await _db.Products.FindAsync(id);
        if (product == null) return NotFound("Product not found");

        product.Name     = updated.Name;
        product.Category = updated.Category;
        product.Price    = updated.Price;
        product.Quantity = updated.Quantity;

        await _db.SaveChangesAsync();
        return Ok(product);
    }

    // ── DELETE api/products/{id}  ────────── delete product ────
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        var product = await _db.Products.FindAsync(id);
        if (product == null) return NotFound("Product not found");

        _db.Products.Remove(product);
        await _db.SaveChangesAsync();
        return Ok("Product deleted successfully");
    }
}
