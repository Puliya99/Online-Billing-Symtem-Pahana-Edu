<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 5:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.example.pahanaedubillingsystem.backend.dto.ItemDTO, com.example.pahanaedubillingsystem.backend.bo.BOFactory, com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <title>Pahana Edu Billing System - Item</title>
  <style>
    body {
      background-color: #f8f9fc;
      color: #333;
      line-height: 1.6;
      font-family: Arial, sans-serif;
      margin: 0;
    }
    .container {
      width: 90%;
      margin: 0 auto;
      padding: 2rem 0;
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
    }
    .section-header {
      width: 100%;
      margin-bottom: 2rem;
      padding-bottom: 1rem;
      border-bottom: 1px solid #e3e6f0;
    }
    .section-header h2 {
      font-weight: 700;
      color: #5a5c69;
      display: flex;
      align-items: center;
    }
    .section-header p {
      color: #858796;
      margin-bottom: 0;
    }
    .form-card, .data-card {
      background: white;
      border-radius: 0.35rem;
      box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
      padding: 1.5rem;
    }
    .form-card {
      flex: 1;
      min-width: 300px;
    }
    .data-card {
      flex: 2;
      min-width: 300px;
    }
    .form-card h4, .data-card h4 {
      font-weight: 600;
      color: #5a5c69;
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
    }
    .form-group {
      margin-bottom: 1.5rem;
    }
    .form-control {
      height: 40px;
      border-radius: 0.35rem;
      border: 1px solid #d1d3e2;
      padding: 0 1rem;
      width: 100%;
    }
    .form-control:focus {
      border-color: #4e73df;
      outline: none;
      box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
    }
    .input-group {
      display: flex;
      align-items: center;
    }
    .input-group-text {
      background-color: #f8f9fc;
      border: 1px solid #d1d3e2;
      border-right: none;
      padding: 0 10px;
      height: 40px;
      display: flex;
      align-items: center;
    }
    .buttons {
      display: flex;
      flex-wrap: wrap;
      gap: 0.5rem;
    }
    .btn {
      padding: 0.5rem 1rem;
      border-radius: 0.35rem;
      border: none;
      color: white;
      cursor: pointer;
      flex: 1;
      text-align: center;
    }
    .btn-primary { background-color: #4e73df; }
    .btn-success { background-color: #1cc88a; }
    .btn-danger { background-color: #e74a3b; }
    .btn-warning { background-color: #f6c23e; }
    .btn:hover {
      opacity: 0.9;
    }
    .table {
      width: 100%;
      border-collapse: collapse;
      color: #5a5c69;
    }
    .table th, .table td {
      padding: 1rem;
      border: 1px solid #e3e6f0;
      text-align: left;
    }
    .table th {
      font-weight: 700;
      text-transform: uppercase;
      font-size: 0.7rem;
    }
    .table tbody tr:hover {
      background-color: rgba(78, 115, 223, 0.05);
      cursor: pointer;
    }
  </style>
</head>
<body>
<%@ include file="nav.jsp" %>
<div class="container">
  <div class="section-header">
    <h2><i class="fas fa-box-open"></i> Item Management</h2>
    <p>Manage your inventory items</p>
  </div>
  <div class="form-card">
    <h4><i class="fas fa-edit"></i> Item Form</h4>
    <form id="item-form">
      <div class="form-group">
        <label for="itemId">Item ID</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-barcode"></i></span>
          <input type="text" class="form-control" id="itemId" placeholder="I001">
        </div>
      </div>
      <div class="form-group">
        <label for="itemName">Description</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-tag"></i></span>
          <input type="text" class="form-control" id="itemName" placeholder="Item Description">
        </div>
      </div>
      <div class="form-group">
        <label for="itemPrice">Price</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-rupee-sign"></i></span>
          <input type="number" step="0.01" class="form-control" id="itemPrice" placeholder="0.00">
        </div>
      </div>
      <div class="form-group">
        <label for="itemQty">Quantity</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-cubes"></i></span>
          <input type="number" class="form-control" id="itemQty" placeholder="0">
        </div>
      </div>
      <div class="buttons">
        <button type="button" class="btn btn-primary" onclick="saveItem()"><i class="fas fa-save"></i> Save</button>
        <button type="button" class="btn btn-success" onclick="updateItem()"><i class="fas fa-sync"></i> Update</button>
        <button type="button" class="btn btn-danger" onclick="deleteItem()"><i class="fas fa-trash"></i> Delete</button>
        <button type="reset" class="btn btn-warning" onclick="resetForm()"><i class="fas fa-eraser"></i> Clear</button>
      </div>
    </form>
  </div>
  <div class="data-card">
    <h4><i class="fas fa-list"></i> Item List</h4>
    <table class="table">
      <thead>
      <tr>
        <th>Item ID</th>
        <th>Description</th>
        <th>Price</th>
        <th>Qty</th>
      </tr>
      </thead>
      <tbody id="itemTable">
      <%
        ItemBO itemBO = (ItemBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.ITEM);
        List<ItemDTO> items = itemBO.getAllItems();
        for (ItemDTO item : items) {
      %>
      <tr onclick="selectItem('<%= item.getItemId() %>', '<%= item.getName() %>', <%= item.getPrice() %>, <%= item.getQty() %>)">
        <td><%= item.getItemId() %></td>
        <td><%= item.getName() %></td>
        <td><%= item.getPrice() %></td>
        <td><%= item.getQty() %></td>
      </tr>
      <% } %>
      </tbody>
    </table>
  </div>
</div>
<script>
  let rowIndex = null;

  function loadId() {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', 'http://localhost:8081/PahanaEduBillingSystem/ItemModel', true);
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4 && xhr.status === 200) {
        const items = JSON.parse(xhr.responseText);
        if (items.length === 0) {
          document.getElementById('itemId').value = 'I001';
        } else {
          const lastId = items[items.length - 1].itemId;
          const lastNumber = parseInt(lastId.slice(1));
          document.getElementById('itemId').value = 'I' + (lastNumber + 1).toString().padStart(3, '0');
        }
      }
    };
    xhr.send();
  }

  loadId();

  function checkValidation(id, name, price, qty) {
    if (!/^[A-Za-z0-9]{3,10}$/.test(id)) {
      alert('Please enter a valid Item ID (e.g., I001)!');
      return false;
    }
    if (!/^[A-Za-z./0-9-\s]+$/.test(name)) {
      alert('Please enter a valid description!');
      return false;
    }
    if (!price || price <= 0) {
      alert('Please enter a valid price!');
      return false;
    }
    if (!qty || qty <= 0) {
      alert('Please enter a valid quantity!');
      return false;
    }
    return true;
  }

  function saveItem() {
    const id = document.getElementById('itemId').value;
    const name = document.getElementById('itemName').value;
    const price = parseFloat(document.getElementById('itemPrice').value);
    const qty = parseInt(document.getElementById('itemQty').value);

    if (!checkValidation(id, name, price, qty)) return;

    const item = { itemId: id, name, price, qty };
    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'http://localhost:8081/PahanaEduBillingSystem/ItemModel', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200 && xhr.responseText === 'saved') {
          alert('Item Saved Successfully!');
          window.location.reload();
        } else {
          alert('Error saving item!');
        }
      }
    };
    xhr.send(JSON.stringify(item));
  }

  function selectItem(id, name, price, qty) {
    document.getElementById('itemId').value = id;
    document.getElementById('itemName').value = name;
    document.getElementById('itemPrice').value = price;
    document.getElementById('itemQty').value = qty;
    const tableRows = document.getElementById('itemTable').getElementsByTagName('tr');
    for (let i = 0; i < tableRows.length; i++) {
      if (tableRows[i].cells[0].innerText === id) {
        rowIndex = i;
        break;
      }
    }
  }

  function updateItem() {
    if (rowIndex === null) {
      alert('Please select an item to update!');
      return;
    }
    const id = document.getElementById('itemId').value;
    const name = document.getElementById('itemName').value;
    const price = parseFloat(document.getElementById('itemPrice').value);
    const qty = parseInt(document.getElementById('itemQty').value);

    if (!checkValidation(id, name, price, qty)) return;

    const item = { itemId: id, name, price, qty };
    const xhr = new XMLHttpRequest();
    xhr.open('PUT', 'http://localhost:8081/PahanaEduBillingSystem/ItemModel', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200 && xhr.responseText === 'updated') {
          alert('Item Updated Successfully!');
          window.location.reload();
        } else {
          alert('Error updating item!');
        }
      }
    };
    xhr.send(JSON.stringify(item));
  }

  function deleteItem() {
    if (rowIndex === null) {
      alert('Please select an item to delete!');
      return;
    }
    if (!confirm('Are you sure you want to delete this item?')) return;
    const id = document.getElementById('itemId').value;
    const xhr = new XMLHttpRequest();
    xhr.open('DELETE', `http://localhost:8081/PahanaEduBillingSystem/ItemModel?item_id=${id}`, true);
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200 && xhr.responseText === 'deleted') {
          alert('Item Deleted Successfully!');
          window.location.reload();
        } else {
          alert('Error deleting item!');
        }
      }
    };
    xhr.send();
  }

  function resetForm() {
    document.getElementById('item-form').reset();
    setTimeout(loadId, 10);
  }
</script>
</body>
</html>
