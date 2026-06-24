<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Product Inventory Dashboard</title>
  <style>
    * { box-sizing: border-box; }

    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #dbeafe, #eff6ff);
      padding: 20px;
    }

    .container {
      max-width: 1300px;
      margin: auto;
      background: #ffffff;
      border-radius: 15px;
      padding: 10px;
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
      border: 4px solid #7a97e8;
    }

    .title-bar {
      text-align: center;
      background: linear-gradient(90deg, #ffffff, #e5ecf9, #ffffff);
      color: rgb(6, 43, 228);
      padding: 8px;
      border-radius: 16px;
      font-size: 2rem;
      font-weight: 700;
      letter-spacing: 1px;
      margin-bottom: 24px;
      animation: glow 3s infinite alternate;
    }

    @keyframes glow {
      from { box-shadow: 0 0 10px rgba(113, 162, 240, 0.4); }
      to { box-shadow: 0 0 25px rgba(155, 184, 232, 0.8); }
    }

    .form-section {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 15px;
      margin-bottom: 24px;
    }

    .form-group {
      display: flex;
      flex-direction: column;
    }

    label {
      margin-bottom: 6px;
      font-weight: 600;
      color: #000000;
    }

    input, select {
      padding: 12px;
      border: 2px solid #bfdbfe;
      border-radius: 12px;
      font-size: 1rem;
      transition: 0.3s;
    }

    input:focus, select:focus {
      outline: none;
      border-color: #2563eb;
      box-shadow: 0 0 10px rgba(37, 99, 235, 0.25);
    }

    .btn {
      grid-column: 1 / -1;
      padding: 14px;
      border: none;
      border-radius: 12px;
      background: linear-gradient(90deg, #64df91, #22c55e);
      color: white;
      font-size: 1.1rem;
      font-weight: bold;
      cursor: pointer;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(34, 197, 94, 0.35);
    }

    .display-section {
      background: #f8fafc;
      border: 2px solid #cbd5e1;
      border-radius: 18px;
      min-height: 300px;
      padding: 20px;
      margin-bottom: 24px;
    }

    .display-section h2 {
      margin-top: 0;
      color: #000000;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }

    th, td {
      padding: 14px;
      text-align: left;
      border-bottom: 1px solid #dbeafe;
    }

    th {
      background: #2563eb;
      color: white;
    }

    tr:hover {
      background: #eff6ff;
    }

    .animation-bar {
      position: relative;
      overflow: hidden;
      height: 150px;
      background: linear-gradient(90deg, #0f172a, #1e293b);
      border-radius: 18px;
      padding: 20px 0;
    }

    .slider-track {
      display: flex;
      width: max-content;
      animation: scroll 28s linear infinite;
      align-items: center;
    }

    .item {
      min-width: 200px;
      margin: 0 20px;
      padding: 10px 10px;
      background: linear-gradient(135deg, #ffffff, #dbeafe);
      border-radius: 20px;
      text-align: center;
      box-shadow: 0 8px 18px rgba(0,0,0,0.25);
      transition: transform 0.3s;
      flex-shrink: 0;
    }

    .item .icon {
      display: block;
      font-size: 3.2rem;
      line-height: 1;
      margin-bottom: 10px;
    }

    .item .name {
      display: block;
      font-size: 0.95rem;
      font-weight: 700;
      color: #1e3a8a;
    }

    .item:hover {
      transform: scale(1.08) rotate(2deg);
    }

    @keyframes scroll {
      from { transform: translateX(0); }
      to { transform: translateX(-50%); }
    }

    .empty {
      text-align: center;
      color: #64748b;
      margin-top: 80px;
      font-size: 1.2rem;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="title-bar">Product Management System</div>

    <div class="form-section">
      <div class="form-group">
        <label>Product Name</label>
        <input type="text" id="name" placeholder="Enter product name">
      </div>

      <div class="form-group">
        <label>Category</label>
        <select id="category">
          <option>Mobile</option>
          <option>Laptop</option>
          <option>AC</option>
          <option>Fridge</option>
          <option>Cooler</option>
          <option>Home Theater</option>
          <option>TV</option>
        </select>
      </div>

      <div class="form-group">
        <label>Price (₹)</label>
        <input type="number" id="price" placeholder="Enter price">
      </div>

      <div class="form-group">
        <label>Quantity</label>
        <input type="number" id="quantity" placeholder="Enter quantity">
      </div>

      <button class="btn" onclick="addProduct()">Add Product</button>
    </div>

    <div class="display-section">
      <h2>Product Details</h2>
      <table id="productTable" style="display:none;">
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Created Date</th>
        </tr>
        </thead>
        <tbody id="productTableBody"></tbody>
      </table>
      <div class="empty" id="emptyState">No products added yet.</div>
    </div>

    <div class="animation-bar">
      <div class="slider-track">
        <div class="item"><span class="icon">📱</span><span class="name">Mobile</span></div>
        <div class="item"><span class="icon">💻</span><span class="name">Laptop</span></div>
        <div class="item"><span class="icon">❄️</span><span class="name">AC</span></div>
        <div class="item"><span class="icon">🧊</span><span class="name">Fridge</span></div>
        <div class="item"><span class="icon">🌬️</span><span class="name">Cooler</span></div>
        <div class="item"><span class="icon">🔊</span><span class="name">Home Theater</span></div>
        <div class="item"><span class="icon">📺</span><span class="name">TV</span></div>
        <div class="item"><span class="icon">📱</span><span class="name">Mobile</span></div>
        <div class="item"><span class="icon">💻</span><span class="name">Laptop</span></div>
        <div class="item"><span class="icon">❄️</span><span class="name">AC</span></div>
        <div class="item"><span class="icon">🧊</span><span class="name">Fridge</span></div>
        <div class="item"><span class="icon">🌬️</span><span class="name">Cooler</span></div>
        <div class="item"><span class="icon">🔊</span><span class="name">Home Theater</span></div>
        <div class="item"><span class="icon">📺</span><span class="name">TV</span></div>
      </div>
    </div>
  </div>

<script>
 const API_BASE = "http://${vm_ip}:5001";
  async function loadProducts() {
    try {
      const response = await fetch(`$${API_BASE}/api/products`);

      if (!response.ok) {
        throw new Error(`HTTP error! Status: $${response.status}`);
      }

      const text = await response.text();
      const products = text ? JSON.parse(text) : [];

      const tbody = document.getElementById('productTableBody');
      const table = document.getElementById('productTable');
      const emptyState = document.getElementById('emptyState');

      tbody.innerHTML = '';

      if (products.length === 0) {
        table.style.display = 'none';
        emptyState.style.display = 'block';
        return;
      }

      table.style.display = 'table';
      emptyState.style.display = 'none';

      products.forEach(product => {
        tbody.innerHTML += `
          <tr>
            <td>$${product.id}</td>
            <td>$${product.name}</td>
            <td>$${product.category}</td>
            <td>₹$${product.price}</td>
            <td>$${product.quantity}</td>
            <td>$${new Date(product.createdAt).toLocaleString()}</td>
          </tr>`;
      });
    } catch (error) {
      console.error('Error loading products:', error);
    }
  }

  async function addProduct() {
    try {
      const name = document.getElementById('name').value.trim();
      const category = document.getElementById('category').value.trim();
      const price = parseFloat(document.getElementById('price').value);
      const quantity = parseInt(document.getElementById('quantity').value);

      if (!name || !category || isNaN(price) || isNaN(quantity)) {
        alert('Please fill in all fields correctly.');
        return;
      }

      const product = {
        name: name,
        category: category,
        price: price,
        quantity: quantity
      };

      const response = await fetch(`$${API_BASE}/api/products`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(product)
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`Status: $${response.status} - $${errorText}`);
      }

      document.getElementById('name').value = '';
      document.getElementById('category').value = '';
      document.getElementById('price').value = '';
      document.getElementById('quantity').value = '';

      await loadProducts();
    } catch (error) {
      console.error('Error adding product:', error);
      alert('Failed to add product: ' + error.message);
    }
  }

  window.onload = loadProducts;
</script>
</body>
</html>
