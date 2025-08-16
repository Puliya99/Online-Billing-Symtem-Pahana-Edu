<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/13/25
  Time: 10:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Collections, com.example.pahanaedubillingsystem.backend.dto.VendorDTO, com.example.pahanaedubillingsystem.backend.bo.BOFactory, com.example.pahanaedubillingsystem.backend.bo.custom.VendorBO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.dto.ItemDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <title>Pahana Edu Billing System - Vendor</title>
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
        .form-control, .form-select {
            height: 40px;
            border-radius: 0.35rem;
            border: 1px solid #d1d3e2;
            padding: 0 1rem;
            width: 100%;
        }
        .form-control:focus, .form-select:focus {
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
        <h2><i class="fas fa-truck"></i> Vendor Management</h2>
        <p>Manage your vendors and their goods received notes</p>
    </div>
    <div class="form-card">
        <h4><i class="fas fa-edit"></i> Vendor Form</h4>
        <div class="alert alert-warning" style="display: none;" id="deleteWarning">
            <strong>Note:</strong> Vendors with associated goods received notes cannot be deleted. Please resolve all associated notes first.
        </div>
        <form id="vendor-form">
            <div class="form-group">
                <label for="grnId">GRN ID</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-receipt"></i></span>
                    <input type="text" class="form-control" id="grnId" placeholder="G001">
                </div>
            </div>
            <div class="form-group">
                <label for="name">Vendor Name</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" class="form-control" id="name" placeholder="Vendor Name">
                </div>
            </div>
            <div class="form-group">
                <label for="itemId">Item ID</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                    <select id="itemId" class="form-select" onchange="loadItemDetails()">
                                <option selected disabled>Select Item</option>
                                <%
                                    List<ItemDTO> items;
                                    try {
                                        ItemBO itemBO = (ItemBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.ITEM);
                                        items = itemBO.getAllItems();
                                    } catch (Exception ex) {
                                        items = Collections.emptyList();
                                    }
                                    for (ItemDTO item : items) {
                                %>
                                <option value="<%= item.getItemId() %>"><%= item.getItemId() %></option>
                                <% } %>
                            </select>
                </div>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-tag"></i></span>
                    <input type="text" class="form-control" id="description" placeholder="Item Description">
                </div>
            </div>
            <div class="form-group">
                <label for="qty">Quantity</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-cubes"></i></span>
                    <input type="number" class="form-control" id="qty" placeholder="0">
                </div>
            </div>
            <div class="form-group">
                <label for="buyingPrice">Buying Price</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-rupee-sign"></i></span>
                    <input type="number" step="0.01" class="form-control" id="buyingPrice" placeholder="0.00">
                </div>
            </div>
            <div class="buttons">
                <button type="button" class="btn btn-primary" onclick="saveVendor()"><i class="fas fa-save"></i> Save</button>
                <button type="button" class="btn btn-success" onclick="updateVendor()"><i class="fas fa-sync"></i> Update</button>
                <button type="button" class="btn btn-danger" onclick="deleteVendor()"><i class="fas fa-trash"></i> Delete</button>
                <button type="reset" class="btn btn-warning" onclick="resetForm()"><i class="fas fa-eraser"></i> Clear</button>
            </div>
        </form>
    </div>
    <div class="data-card">
        <h4><i class="fas fa-list"></i> Vendor List</h4>

        <!-- Search & Export Bar -->
        <div style="margin-bottom: 1rem; display: flex; gap: 0.5rem; flex-wrap: wrap; align-items: center;">
            <input type="text" id="searchInput" class="form-control" placeholder="Search by GRN ID or Vendor Name" style="flex: 1; min-width: 200px;">
            <button type="button" class="btn btn-primary" onclick="searchVendor()" title="Search">
                <i class="fas fa-search"></i> Search
            </button>
            <button type="button" class="btn btn-warning" onclick="exportVendorsCsv()" title="Export Vendors to CSV">
                <i class="fas fa-file-export"></i> Export
            </button>
        </div>

        <!-- Scrollable Table -->
        <div style="max-height: 400px; overflow-y: auto; border: 1px solid #e3e6f0; border-radius: 0.35rem;">
            <table class="table">
                <thead>
                <tr>
                    <th>GRN ID</th>
                    <th>Vendor Name</th>
                    <th>Item ID</th>
                    <th>Description</th>
                    <th>Qty</th>
                    <th>Buying Price</th>
                </tr>
                </thead>
                <tbody id="vendorTable">
                <%
                    List<VendorDTO> vendors;
                    try {
                        VendorBO vendorBO = (VendorBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.VENDOR);
                        vendors = vendorBO.getAllVendors();
                    } catch (Exception ex) {
                        vendors = Collections.emptyList();
                    }
                    for (VendorDTO vendor : vendors) {
                %>
                <tr onclick="selectVendor('<%= vendor.getGrnId() %>', '<%= vendor.getName() %>', '<%= vendor.getItemId() %>', '<%= vendor.getDescription() %>', <%= vendor.getQty() %>, <%= vendor.getBuyingPrice() %>)">
                    <td><%= vendor.getGrnId() %></td>
                    <td><%= vendor.getName() %></td>
                    <td><%= vendor.getItemId() %></td>
                    <td><%= vendor.getDescription() %></td>
                    <td><%= vendor.getQty() %></td>
                    <td><%= vendor.getBuyingPrice() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    const BASE = '<%= request.getContextPath() %>';
    let rowIndex = null;

    function loadId() {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'http://localhost:8081/PahanaEduBillingSystem/VendorModel', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const vendors = JSON.parse(xhr.responseText);
                if (vendors.length === 0) {
                    document.getElementById('grnId').value = 'G001';
                } else {
                    const lastId = vendors[vendors.length - 1].grnId;
                    const lastNumber = parseInt(lastId.slice(1));
                    document.getElementById('grnId').value = 'G' + (lastNumber + 1).toString().padStart(3, '0');
                }
            }
        };
        xhr.send();
    }

    loadId();

    function checkValidation(grnId, name, itemId, description, qty, buyingPrice) {
        if (!/^[A-Za-z0-9]{3,10}$/.test(grnId)) {
            alert('Please enter a valid GRN ID (e.g., G001)!');
            return false;
        }
        if (!/^[A-Za-z\s]{4,60}$/.test(name)) {
            alert('Please enter a valid vendor name!');
            return false;
        }
        if (!/^[A-Za-z0-9]{3,10}$/.test(itemId)) {
            alert('Please enter a valid Item ID (e.g., I001)!');
            return false;
        }
        if (!/^[A-Za-z./0-9-\s]+$/.test(description)) {
            alert('Please enter a valid description!');
            return false;
        }
        if (!qty || qty <= 0) {
            alert('Please enter a valid quantity!');
            return false;
        }
        if (!buyingPrice || buyingPrice <= 0) {
            alert('Please enter a valid buying price!');
            return false;
        }
        return true;
    }

    function loadItemDetails() {
        const itemId = document.getElementById('itemId').value;
        if (!itemId) return;
        const xhr = new XMLHttpRequest();
        xhr.open('GET', BASE + '/ItemModel', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const items = JSON.parse(xhr.responseText);
                const item = items.find(itm => itm.itemId === itemId);
                if (item) {
                    document.getElementById('description').value = item.name;
                }
            }
        };
        xhr.send();
    }

    function saveVendor() {
        const grnId = document.getElementById('grnId').value;
        const name = document.getElementById('name').value;
        const itemId = document.getElementById('itemId').value;
        const description = document.getElementById('description').value;
        const qty = parseInt(document.getElementById('qty').value);
        const buyingPrice = parseFloat(document.getElementById('buyingPrice').value);

        if (!checkValidation(grnId, name, itemId, description, qty, buyingPrice)) return;

        const vendor = { grnId, name, itemId, description, qty, buyingPrice };
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'http://localhost:8081/PahanaEduBillingSystem/VendorModel', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'saved') {
                    alert('Vendor Saved Successfully!');
                    window.location.reload();
                } else {
                    alert('Error saving vendor!');
                }
            }
        };
        xhr.send(JSON.stringify(vendor));
    }

    function selectVendor(grnId, name, itemId, description, qty, buyingPrice) {
        document.getElementById('grnId').value = grnId;
        document.getElementById('name').value = name;
        document.getElementById('itemId').value = itemId;
        document.getElementById('description').value = description;
        document.getElementById('qty').value = qty;
        document.getElementById('buyingPrice').value = buyingPrice;
        const tableRows = document.getElementById('vendorTable').getElementsByTagName('tr');
        for (let i = 0; i < tableRows.length; i++) {
            if (tableRows[i].cells[0].innerText === grnId) {
                rowIndex = i;
                break;
            }
        }
        document.getElementById('deleteWarning').style.display = 'none';
    }

    function updateVendor() {
        if (rowIndex === null) {
            alert('Please select a vendor to update!');
            return;
        }
        const grnId = document.getElementById('grnId').value;
        const name = document.getElementById('name').value;
        const itemId = document.getElementById('itemId').value;
        const description = document.getElementById('description').value;
        const qty = parseInt(document.getElementById('qty').value);
        const buyingPrice = parseFloat(document.getElementById('buyingPrice').value);

        if (!checkValidation(grnId, name, itemId, description, qty, buyingPrice)) return;

        const vendor = { grnId, name, itemId, description, qty, buyingPrice };
        const xhr = new XMLHttpRequest();
        xhr.open('PUT', 'http://localhost:8081/PahanaEduBillingSystem/VendorModel', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'updated') {
                    alert('Vendor Updated Successfully!');
                    window.location.reload();
                } else {
                    alert('Error updating vendor!');
                }
            }
        };
        xhr.send(JSON.stringify(vendor));
    }

    function deleteVendor() {
        if (rowIndex === null) {
            alert('Please select a vendor to delete!');
            return;
        }

        const grnId = document.getElementById('grnId').value;

        if (!grnId || grnId.trim() === '') {
            alert('Please select a valid vendor to delete!');
            return;
        }

        if (!confirm('Are you sure you want to delete this vendor?\n\nNote: Vendors with associated goods received notes cannot be deleted.')) {
            return;
        }

        console.log('Attempting to delete vendor with GRN ID:', grnId);

        const xhr = new XMLHttpRequest();
        const url = 'http://localhost:8081/PahanaEduBillingSystem/VendorModel?grn_id=' + encodeURIComponent(grnId);
        console.log('DELETE URL:', url);

        xhr.open('DELETE', url, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                console.log('Response status:', xhr.status, 'Response text:', xhr.responseText);
                if (xhr.status === 200 && xhr.responseText === 'deleted') {
                    alert('Vendor Deleted Successfully!');
                    window.location.reload();
                } else if (xhr.status === 200 && xhr.responseText === 'not deleted') {
                    document.getElementById('deleteWarning').style.display = 'block';
                    alert('Cannot delete vendor!\n\nThis vendor has associated goods received notes. Please resolve all associated notes first before attempting to delete the vendor.');
                } else {
                    alert('Error deleting vendor! Status: ' + xhr.status);
                }
            }
        };
        xhr.send();
    }

    function resetForm() {
        document.getElementById('vendor-form').reset();
        document.getElementById('deleteWarning').style.display = 'none';
        rowIndex = null;
        setTimeout(loadId, 10);
    }

    function exportVendorsCsv() {
        try {
            window.location.href = 'http://localhost:8081/PahanaEduBillingSystem/VendorExport';
        } catch (e) {
            alert('Failed to start export: ' + (e && e.message ? e.message : e));
        }
    }

    function searchVendor() {
        const filter = document.getElementById('searchInput').value.toLowerCase();
        const table = document.getElementById('vendorTable');
        const rows = table.getElementsByTagName('tr');

        for (let i = 0; i < rows.length; i++) {
            const grnId = rows[i].cells[0].innerText.toLowerCase();
            const name = rows[i].cells[1].innerText.toLowerCase();
            if (grnId.includes(filter) || name.includes(filter)) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }
    }

    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchVendor();
        }
    });
</script>
</body>
</html>