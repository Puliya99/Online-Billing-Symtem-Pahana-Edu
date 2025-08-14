<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 5:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.example.pahanaedubillingsystem.backend.dto.CustomerDTO, com.example.pahanaedubillingsystem.backend.bo.BOFactory, com.example.pahanaedubillingsystem.backend.bo.custom.CustomerBO" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <title>Pahana Edu Billing System - Customer</title>
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
    <h2><i class="fas fa-users"></i> Customer Management</h2>
    <p>Manage your customers and their details</p>
  </div>

  <!-- Customer Form -->
  <div class="form-card">
    <h4><i class="fas fa-user-edit"></i> Customer Form</h4>
    <div class="alert alert-warning" style="display: none;" id="deleteWarning">
      <strong>Note:</strong> Customers with associated bills cannot be deleted. Please delete all bills for this customer first.
    </div>
    <form id="customer-form">
      <div class="form-group">
        <label for="cusId">Account No</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-id-card"></i></span>
          <input type="text" class="form-control" id="cusId" placeholder="C001">
        </div>
      </div>
      <div class="form-group">
        <label for="cusName">Name</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-user"></i></span>
          <input type="text" class="form-control" id="cusName" placeholder="Customer Name">
        </div>
      </div>
      <div class="form-group">
        <label for="cusAddress">Address</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
          <input type="text" class="form-control" id="cusAddress" placeholder="Customer Address">
        </div>
      </div>
      <div class="form-group">
        <label for="cusContact">Contact</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-phone"></i></span>
          <input type="text" class="form-control" id="cusContact" placeholder="Contact Number">
        </div>
      </div>
      <div class="form-group">
        <label for="cusUnits">Units Consumed</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-bolt"></i></span>
          <input type="number" class="form-control" id="cusUnits" placeholder="0">
        </div>
      </div>
      <div class="buttons">
        <button type="button" class="btn btn-primary" onclick="saveCustomer()"><i class="fas fa-save"></i> Save</button>
        <button type="button" class="btn btn-success" onclick="updateCustomer()"><i class="fas fa-sync"></i> Update</button>
        <button type="button" class="btn btn-danger" onclick="deleteCustomer()"><i class="fas fa-trash"></i> Delete</button>
        <button type="reset" class="btn btn-warning" onclick="resetForm()"><i class="fas fa-eraser"></i> Clear</button>
      </div>
    </form>
  </div>

  <!-- Customer List -->
  <div class="data-card">
    <h4><i class="fas fa-list"></i> Customer List</h4>

    <!-- Search & Import Bar -->
    <div style="margin-bottom: 1rem; display: flex; gap: 0.5rem; flex-wrap: wrap; align-items: center;">
      <input type="text" id="searchInput" class="form-control" placeholder="Search by Name or Account No" style="flex: 1; min-width: 200px;">
      <button type="button" class="btn btn-primary" onclick="searchCustomer()" title="Search">
        <i class="fas fa-search"></i> Search
      </button>
      <input type="file" id="customerCsvInput" accept=".csv" style="display:none" />
      <button type="button" class="btn btn-success" onclick="document.getElementById('customerCsvInput').click()" title="Import Customers from CSV">
        <i class="fas fa-file-import"></i> Import
      </button>
      <button type="button" class="btn btn-warning" onclick="exportCustomersCsv()" title="Export Customers to CSV">
        <i class="fas fa-file-export"></i> Export
      </button>
    </div>

    <!-- Scrollable Table -->
    <div style="max-height: 400px; overflow-y: auto; border: 1px solid #e3e6f0; border-radius: 0.35rem;">
      <table class="table">
        <thead>
        <tr>
          <th>Account No</th>
          <th>Name</th>
          <th>Address</th>
          <th>Contact</th>
          <th>Units</th>
        </tr>
        </thead>
        <tbody id="cusTable">
        <%
          CustomerBO customerBO = (CustomerBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.CUSTOMER);
          List<CustomerDTO> customers = customerBO.getAllCustomers();
          for (CustomerDTO customer : customers) {
        %>
        <tr onclick="selectCustomer('<%= customer.getAccountNo() %>', '<%= customer.getName() %>', '<%= customer.getAddress() %>', '<%= customer.getTelephone() %>', <%= customer.getUnitsConsumed() %>)">
          <td><%= customer.getAccountNo() %></td>
          <td><%= customer.getName() %></td>
          <td><%= customer.getAddress() %></td>
          <td><%= customer.getTelephone() %></td>
          <td><%= customer.getUnitsConsumed() %></td>
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
    xhr.open('GET', 'http://localhost:8081/PahanaEduBillingSystem/CustomerModel', true);
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4 && xhr.status === 200) {
        const customers = JSON.parse(xhr.responseText);
        if (customers.length === 0) {
          document.getElementById('cusId').value = 'C001';
        } else {
          const lastId = customers[customers.length - 1].accountNo;
          const lastNumber = parseInt(lastId.slice(1));
          document.getElementById('cusId').value = 'C' + (lastNumber + 1).toString().padStart(3, '0');
        }
      }
    };
    xhr.send();
  }

  loadId();

  function checkValidation(id, name, address, contact, units) {
    if (!/^[A-Za-z0-9]{3,10}$/.test(id)) {
      alert('Please enter a valid Account No (e.g., C001)!');
      return false;
    }
    if (!/^[a-zA-Z\s]{4,60}$/.test(name)) {
      alert('Please enter a valid name!');
      return false;
    }
    if (!/^[a-zA-Z0-9,/\s]{4,60}$/.test(address)) {
      alert('Please enter a valid address!');
      return false;
    }
    if (!/^\+?\d{10}$/.test(contact)) {
      alert('Please enter a valid contact number!');
      return false;
    }
    if (!units || units < 0) {
      alert('Please enter valid units consumed!');
      return false;
    }
    return true;
  }

  function saveCustomer() {
    const id = document.getElementById('cusId').value;
    const name = document.getElementById('cusName').value;
    const address = document.getElementById('cusAddress').value;
    const contact = document.getElementById('cusContact').value;
    const units = parseInt(document.getElementById('cusUnits').value);

    if (!checkValidation(id, name, address, contact, units)) return;

    const customer = { accountNo: id, name, address, telephone: contact, unitsConsumed: units };
    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'http://localhost:8081/PahanaEduBillingSystem/CustomerModel', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200 && xhr.responseText === 'saved') {
          alert('Customer Saved Successfully!');
          window.location.reload();
        } else {
          alert('Error saving customer! Please check if the account number already exists.');
        }
      }
    };
    xhr.send(JSON.stringify(customer));
  }

  function selectCustomer(id, name, address, contact, units) {
    console.log('Selecting customer:', id, name, address, contact, units);

    document.getElementById('cusId').value = id;
    document.getElementById('cusName').value = name;
    document.getElementById('cusAddress').value = address;
    document.getElementById('cusContact').value = contact;
    document.getElementById('cusUnits').value = units;

    document.getElementById('deleteWarning').style.display = 'none';

    const tableRows = document.getElementById('cusTable').getElementsByTagName('tr');
    for (let i = 0; i < tableRows.length; i++) {
      if (tableRows[i].cells[0].innerText === id) {
        rowIndex = i;
        break;
      }
    }

    console.log('Customer selected, rowIndex:', rowIndex, 'Account ID field value:', document.getElementById('cusId').value); // Debug log
  }

  function updateCustomer() {
    if (rowIndex === null) {
      alert('Please select a customer to update!');
      return;
    }
    const id = document.getElementById('cusId').value;
    const name = document.getElementById('cusName').value;
    const address = document.getElementById('cusAddress').value;
    const contact = document.getElementById('cusContact').value;
    const units = parseInt(document.getElementById('cusUnits').value);

    if (!checkValidation(id, name, address, contact, units)) return;

    const customer = { accountNo: id, name, address, telephone: contact, unitsConsumed: units };
    const xhr = new XMLHttpRequest();
    xhr.open('PUT', 'http://localhost:8081/PahanaEduBillingSystem/CustomerModel', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200 && xhr.responseText === 'updated') {
          alert('Customer Updated Successfully!');
          window.location.reload();
        } else {
          alert('Error updating customer!');
        }
      }
    };
    xhr.send(JSON.stringify(customer));
  }

  function deleteCustomer() {
    if (rowIndex === null) {
      alert('Please select a customer to delete!');
      return;
    }

    const id = document.getElementById('cusId').value;

    if (!id || id.trim() === '') {
      alert('Please select a valid customer to delete!');
      return;
    }

    if (!confirm('Are you sure you want to delete this customer?\n\nNote: Customers with associated bills cannot be deleted.')) {
      return;
    }

    console.log('Attempting to delete customer with ID:', id);

    const xhr = new XMLHttpRequest();
    const url = 'http://localhost:8081/PahanaEduBillingSystem/CustomerModel?account_no=' + encodeURIComponent(id);
    console.log('DELETE URL:', url);

    xhr.open('DELETE', url, true);
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        console.log('Response status:', xhr.status, 'Response text:', xhr.responseText);
        if (xhr.status === 200 && xhr.responseText === 'deleted') {
          alert('Customer Deleted Successfully!');
          window.location.reload();
        } else if (xhr.status === 200 && xhr.responseText === 'not deleted') {
          document.getElementById('deleteWarning').style.display = 'block';
          alert('Cannot delete customer!\n\nThis customer has associated bills. Please delete all bills for this customer first before attempting to delete the customer.');
        } else {
          alert('Error deleting customer! Status: ' + xhr.status);
        }
      }
    };
    xhr.send();
  }

  function resetForm() {
    document.getElementById('customer-form').reset();
    document.getElementById('deleteWarning').style.display = 'none';
    rowIndex = null;
    setTimeout(loadId, 10);
  }

  function searchCustomer() {
    const filter = document.getElementById('searchInput').value.toLowerCase();
    const table = document.getElementById('cusTable');
    const rows = table.getElementsByTagName('tr');

    for (let i = 0; i < rows.length; i++) {
      const accountNo = rows[i].cells[0].innerText.toLowerCase();
      const name = rows[i].cells[1].innerText.toLowerCase();
      if (accountNo.includes(filter) || name.includes(filter)) {
        rows[i].style.display = '';
      } else {
        rows[i].style.display = 'none';
      }
    }
  }

  document.getElementById('searchInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
      searchCustomer();
    }
  });
</script>
</body>
</html>

<script>
  (function(){
    const input = document.getElementById('customerCsvInput');
    if (input) {
      input.addEventListener('change', function(){
        if (!this.files || this.files.length === 0) return;
        const file = this.files[0];
        if (!file.name.toLowerCase().endsWith('.csv')) {
          alert('Please select a .csv file');
          this.value = '';
          return;
        }
        if (!confirm('Import customers from file: ' + file.name + '?')) {
          this.value = '';
          return;
        }
        uploadCustomerCsv(file);
      });
    }
  })();

  function uploadCustomerCsv(file) {
    const btns = document.querySelectorAll('button');
    btns.forEach(b => b.disabled = true);
    const fd = new FormData();
    fd.append('file', file);
    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'http://localhost:8081/PahanaEduBillingSystem/CustomerImport', true);
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

  function exportCustomersCsv() {
    try {
      window.location.href = 'http://localhost:8081/PahanaEduBillingSystem/CustomerExport';
    } catch (e) {
      alert('Failed to start export: ' + (e && e.message ? e.message : e));
    }
  }
</script>
