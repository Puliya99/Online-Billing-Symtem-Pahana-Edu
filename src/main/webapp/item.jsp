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
    .alert {
      padding: 0.75rem 1.25rem;
      margin-bottom: 1rem;
      border: 1px solid transparent;
      border-radius: 0.25rem;
    }
    .alert-warning {
      color: #856404;
      background-color: #fff3cd;
      border-color: #ffeaa7;
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
    <div class="alert alert-warning" style="display: none;" id="deleteWarning">
      <strong>Note:</strong> Items with associated bills cannot be deleted. Please delete all bills for this item first.
    </div>
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

    <!-- Search & Import Bar -->
    <div style="margin-bottom: 1rem; display: flex; gap: 0.5rem; flex-wrap: wrap; align-items: center;">
      <input type="text" id="searchInput" class="form-control" placeholder="Search by Description or Item ID" style="flex: 1; min-width: 200px;">
      <button type="button" class="btn btn-primary" onclick="searchItem()" title="Search">
        <i class="fas fa-search"></i> Search
      </button>
      <input type="file" id="itemCsvInput" accept=".csv" style="display:none" />
      <button type="button" class="btn btn-success" onclick="document.getElementById('itemCsvInput').click()" title="Import Items from CSV">
        <i class="fas fa-file-import"></i> Import
      </button>
      <button type="button" class="btn btn-warning" onclick="exportItemsCsv()" title="Export Items to CSV">
        <i class="fas fa-file-export"></i> Export
      </button>
    </div>

    <!-- Scrollable Table -->
    <div style="max-height: 400px; overflow-y: auto; border: 1px solid #e3e6f0; border-radius: 0.35rem;">
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
    if (!/^[A-Za-z./0-9-,'()\s]+$/.test(name)) {
      alert('Please enter a valid description!');
      return false;
    }
    if (!price || price <= 0) {
      alert('Please enter a valid price!');
      return false;
    }
    if (Number.isNaN(qty) || qty < 0) {
      alert('Please enter a valid quantity (0 or greater)!');
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
    document.getElementById('deleteWarning').style.display = 'none';
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

    const id = document.getElementById('itemId').value;

    if (!id || id.trim() === '') {
      alert('Please select a valid item to delete!');
      return;
    }

    if (!confirm('Are you sure you want to delete this item?\n\nNote: Items with associated bills cannot be deleted.')) {
      return;
    }

    console.log('Attempting to delete item with ID:', id);

    const xhr = new XMLHttpRequest();
    const url = 'http://localhost:8081/PahanaEduBillingSystem/ItemModel?item_id=' + encodeURIComponent(id);
    console.log('DELETE URL:', url);

    xhr.open('DELETE', url, true);
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        console.log('Response status:', xhr.status, 'Response text:', xhr.responseText);
        if (xhr.status === 200 && xhr.responseText === 'deleted') {
          alert('Item Deleted Successfully!');
          window.location.reload();
        } else if (xhr.status === 200 && xhr.responseText === 'not deleted') {
          document.getElementById('deleteWarning').style.display = 'block';
          alert('Cannot delete item!\n\nThis item has associated bills. Please delete all bills for this item first before attempting to delete the item.');
        } else {
          alert('Error deleting item! Status: ' + xhr.status);
        }
      }
    };
    xhr.send();
  }

  function resetForm() {
    document.getElementById('item-form').reset();
    document.getElementById('deleteWarning').style.display = 'none';
    rowIndex = null;
    setTimeout(loadId, 10);
  }

  // Search Function
  function searchItem() {
    const filter = document.getElementById('searchInput').value.toLowerCase();
    const table = document.getElementById('itemTable');
    const rows = table.getElementsByTagName('tr');

    for (let i = 0; i < rows.length; i++) {
      const itemId = rows[i].cells[0].innerText.toLowerCase();
      const description = rows[i].cells[1].innerText.toLowerCase();
      if (itemId.includes(filter) || description.includes(filter)) {
        rows[i].style.display = '';
      } else {
        rows[i].style.display = 'none';
      }
    }
  }

  document.getElementById('searchInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
      searchItem();
    }
  });
</script>
</body>
</html>

<script>
  (function(){
    const input = document.getElementById('itemCsvInput');
    if (input) {
      input.addEventListener('change', function(){
        if (!this.files || this.files.length === 0) return;
        const file = this.files[0];
        if (!file.name.toLowerCase().endsWith('.csv')) {
          alert('Please select a .csv file');
          this.value = '';
          return;
        }
        if (!confirm('Import items from file: ' + file.name + '?')) {
          this.value = '';
          return;
        }
        uploadItemCsv(file);
      });
    }
  })();

  function exportItemsCsv() {
    try {
      // Trigger file download; include context path explicitly used elsewhere
      window.location.href = 'http://localhost:8081/PahanaEduBillingSystem/ItemExport';
    } catch (e) {
      alert('Failed to start export: ' + (e && e.message ? e.message : e));
    }
  }

  function uploadItemCsv(file) {
    const btns = document.querySelectorAll('button');
    btns.forEach(b => b.disabled = true);
    const fd = new FormData();
    fd.append('file', file);
    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'http://localhost:8081/PahanaEduBillingSystem/ItemImport', true);
    xhr.onreadystatechange = function(){
      if (xhr.readyState === 4) {
        btns.forEach(b => b.disabled = false);
        const msg = xhr.responseText || ('Status: ' + xhr.status);
        alert('Import result:\n\n' + msg);
        if (xhr.status === 200) {
          window.location.reload();
        }
      }
    };
    xhr.send(fd);
  }
</script>
