<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 5:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.example.pahanaedubillingsystem.backend.dto.CustomerDTO, com.example.pahanaedubillingsystem.backend.dto.ItemDTO, com.example.pahanaedubillingsystem.backend.dto.BillDTO, com.example.pahanaedubillingsystem.backend.bo.BOFactory, com.example.pahanaedubillingsystem.backend.bo.custom.CustomerBO, com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO, com.example.pahanaedubillingsystem.backend.bo.custom.BillBO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <title>Pahana Edu Billing System - Bill</title>
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
        }
        .section-header {
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
        .bill-header, .customer-details, .bill-summary, .bill-history {
            margin-bottom: 1.5rem;
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
        .card {
            background: white;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            padding: 3rem;
        }
        .card-header {
            background-color: #f8f9fc;
            border-bottom: 1px solid #e3e6f0;
            font-weight: 600;
            padding: 1rem;
        }
        .total-amount {
            background-color: #f8f9fc;
            padding: 1.5rem;
            border-radius: 0.35rem;
            border-left: 0.25rem solid #1cc88a;
        }
        .total-amount h2 {
            color: #1cc88a;
            font-weight: 700;
        }
        .btn {
            padding: 0.75rem 2rem;
            border-radius: 0.35rem;
            border: none;
            color: white;
            cursor: pointer;
            background-color: #1cc88a;
        }
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
        }
        .table-scroll {
            max-height: 300px;
            overflow-y: auto;
        }
        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .col-md-2{
            flex: 1;
            min-width: 250px;
        }
        .col-md-3 {
            flex: 1;
            min-width: 300px;
        }
        .col-md-4 {
            flex: 1.33;
            min-width: 320px;
        }
        .col-md-6 {
            flex: 2;
            min-width: 300px;
        }
    </style>
</head>
<body>
<%@ include file="nav.jsp" %>
<div class="container">
    <div class="section-header">
        <h2><i class="fas fa-file-invoice-dollar"></i> Billing</h2>
        <p>Generate and manage customer bills</p>
    </div>
    <div class="bill-header">
        <div class="row">
            <div class="col-md-3">
                <div class="form-group">
                    <label for="billId">Bill ID</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                        <input type="text" class="form-control" id="billId" disabled>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="billDate">Date</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                        <input type="text" class="form-control" id="billDate" disabled>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="customer-details">
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-user-tag"></i> Customer & Item Details</h5>
            </div>
            <div class="card-body">
                <div class="row" style="margin-top: 30px">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="billCusId">Customer ID</label>
                            <select id="billCusId" class="form-select" onchange="loadCustomerDetails()">
                                <option selected disabled>Select Customer</option>
                                <%
                                    CustomerBO customerBO = (CustomerBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.CUSTOMER);
                                    List<CustomerDTO> customers = customerBO.getAllCustomers();
                                    for (CustomerDTO customer : customers) {
                                %>
                                <option value="<%= customer.getAccountNo() %>"><%= customer.getAccountNo() %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="billCusName">Customer Name</label>
                            <input type="text" class="form-control" id="billCusName" disabled>
                        </div>
                    </div>
                    <div class="col-md-3" style="margin-left: 30px">
                        <div class="form-group">
                            <label for="itemId">Item ID</label>
                            <select id="itemId" class="form-select" onchange="loadItemDetails()">
                                <option selected disabled>Select Item</option>
                                <%
                                    ItemBO itemBO = (ItemBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.ITEM);
                                    List<ItemDTO> items = itemBO.getAllItems();
                                    for (ItemDTO item : items) {
                                %>
                                <option value="<%= item.getItemId() %>"><%= item.getItemId() %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="itemName">Item Description</label>
                            <input type="text" class="form-control" id="itemName" disabled>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-2">
                        <div class="form-group">
                            <label for="itemPrice">Item Price</label>
                            <input type="text" class="form-control" id="itemPrice" disabled>
                        </div>
                    </div>
                    <div class="col-md-2" style="margin-left: 30px">
                        <div class="form-group">
                            <label for="qty">Qty</label>
                            <input type="number" class="form-control" id="qty" oninput="calculateTotal()">
                        </div>
                    </div>
                    <div class="col-md-2" style="margin-left: 30px">
                        <div class="form-group">
                            <label for="discount">Discount</label>
                            <input type="number" class="form-control" id="discount" oninput="calculateTotal()">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="bill-summary">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="total-amount">
                            <h6 style="color: #858796;">Total Amount</h6>
                            <h2 id="billTotal">Rs. 0.00</h2>
                        </div>
                    </div>
                    <div class="col-md-6" style="text-align: right;">
                        <button class="btn" id="generateBtn" onclick="generateBill()"><i class="fas fa-file-invoice"></i> Generate Bill</button>
                        <button class="btn" id="updateBtn" onclick="updateBill()" style="display:none;background-color:#4e73df;margin-left:10px"><i class="fas fa-save"></i> Update Bill</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="bill-history">
        <div class="card">
            <div class="card-header">
                <h5><i class="fas fa-history"></i> Bill History</h5>
            </div>
            <div style="margin-bottom: 1rem; display: flex; gap: 0.5rem; flex-wrap: wrap; align-items: center;">
                <input type="text" id="searchInput" class="form-control" placeholder="Search by Bill Id" style="flex: 1; min-width: 200px;">
                <div class="input-group" style="flex: 0 1 auto; min-width: 220px;">
                    <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                    <input type="date" id="billDateFilter" class="form-control" placeholder="Filter by Date">
                </div>
                <button type="button" class="btn btn-primary" onclick="searchBill()">
                    <i class="fas fa-search"></i> Search
                </button>
                <button type="button" class="btn" style="background-color:#858796" onclick="clearFilters()">
                    <i class="fas fa-times"></i> Clear
                </button>
            </div>
            <div class="card-body">
                <div class="table-scroll">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Bill ID</th>
                            <th>Date</th>
                            <th>Customer ID</th>
                            <th>Item ID</th>
                            <th>Qty</th>
                            <th>Unit Price</th>
                            <th>Discount</th>
                            <th>Total Amount</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="billTable">
                        <%
                            BillBO billBO = (BillBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.BILL);
                            List<BillDTO> bills = billBO.getAllBills();
                            for (BillDTO bill : bills) {
                        %>
                        <tr data-bill-id="<%= bill.getBillId() %>">
                            <td><%= bill.getBillId() %></td>
                            <td><%= bill.getBillDate() %></td>
                            <td><%= bill.getAccountNo() %></td>
                            <td><%= bill.getItemId() %></td>
                            <td><%= bill.getQty() %></td>
                            <td><%= bill.getUnitPrice() %></td>
                            <td><%= bill.getDiscount() %></td>
                            <td><%= bill.getTotalAmount() %></td>
                            <td>
                                <button title="Print" style="background:none;border:none;color:#4e73df;cursor:pointer" onclick="printBill('<%= bill.getBillId() %>')"><i class="fas fa-print"></i></button>
                                <button title="Edit" style="background:none;border:none;color:#1cc88a;cursor:pointer" onclick="editBill('<%= bill.getBillId() %>','<%= bill.getAccountNo() %>','<%= bill.getItemId() %>',<%= bill.getQty() %>,<%= bill.getUnitPrice() %>,<%= bill.getDiscount() %>)"><i class="fas fa-edit"></i></button>
                                <button title="Delete" style="background:none;border:none;color:#e74a3b;cursor:pointer" onclick="deleteBill('<%= bill.getBillId() %>')"><i class="fas fa-trash"></i></button>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function loadIdDate() {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'http://localhost:8081/PahanaEduBillingSystem/BillModel', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const bills = JSON.parse(xhr.responseText);
                if (bills.length === 0) {
                    document.getElementById('billId').value = 'B001';
                } else {
                    const lastId = bills[bills.length - 1].billId;
                    const lastNumber = parseInt(lastId.slice(1));
                    document.getElementById('billId').value = 'B' + (lastNumber + 1).toString().padStart(3, '0');
                }
            }
        };
        xhr.send();
        const today = new Date().toLocaleDateString('en-GB', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        }).split('/').reverse().join('-');
        document.getElementById('billDate').value = today;
    }

    loadIdDate();

    function loadCustomerDetails() {
        const cusId = document.getElementById('billCusId').value;
        if (!cusId) return;
        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'http://localhost:8081/PahanaEduBillingSystem/CustomerModel', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const customers = JSON.parse(xhr.responseText);
                const customer = customers.find(cus => cus.accountNo === cusId);
                if (customer) {
                    document.getElementById('billCusName').value = customer.name;
                    calculateTotal();
                }
            }
        };
        xhr.send();
    }

    function loadItemDetails() {
        const itemId = document.getElementById('itemId').value;
        if (!itemId) return;
        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'http://localhost:8081/PahanaEduBillingSystem/ItemModel', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const items = JSON.parse(xhr.responseText);
                const item = items.find(itm => itm.itemId === itemId);
                if (item) {
                    document.getElementById('itemName').value = item.name;
                    document.getElementById('itemPrice').value = item.price.toFixed(2);
                    window.itemPrice = item.price;
                    calculateTotal();
                }
            }
        };
        xhr.send();
    }

    function calculateTotal() {
        const qty = parseInt(document.getElementById('qty').value, 10) || 0;
        const discount = parseInt(document.getElementById('discount').value) || 0;
        const unitPrice = parseFloat(document.getElementById('itemPrice').value) || 0;
        const discountBeforePrice = qty * unitPrice;
        const totalPrice = discountBeforePrice - (discountBeforePrice * discount / 100);
        document.getElementById('billTotal').innerText = 'Rs. ' + totalPrice.toFixed(2);
    }

    function generateBill() {
        const billId = document.getElementById('billId').value;
        const billDate = document.getElementById('billDate').value;
        const accountNo = document.getElementById('billCusId').value;
        const itemId = document.getElementById('itemId').value;
        const qty = parseInt(document.getElementById('qty').value, 10) || 0;
        const unitPrice = parseFloat(document.getElementById('itemPrice').value) || 0;
        const discount = parseFloat(document.getElementById('discount').value) || 0;
        const discountBeforePrice = qty * unitPrice;
        const totalAmount = discountBeforePrice - (discountBeforePrice * discount / 100);

        if (!accountNo || !itemId) {
            alert('Please select a customer and an item!');
            return;
        }

        const bill = { billId, billDate, accountNo, itemId, qty, unitPrice, discount, totalAmount };
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'http://localhost:8081/PahanaEduBillingSystem/BillModel', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'saved') {
                    alert('Bill Generated Successfully!');
                    window.location.reload();
                } else {
                    alert('Error generating bill!');
                }
            }
        };
        xhr.send(JSON.stringify(bill));
    }

    function findBillRow(billId) {
        const rows = document.querySelectorAll('#billTable tr');
        for (const row of rows) {
            const idCell = row.cells[0];
            if (idCell && idCell.textContent.trim() === billId) return row;
        }
        return null;
    }

    function printBill(billId) {
        const row = findBillRow(billId);
        if (!row) return alert('Bill not found to print');
        const data = {
            billId: row.cells[0].textContent,
            billDate: row.cells[1].textContent,
            accountNo: row.cells[2].textContent,
            itemId: row.cells[3].textContent,
            qty: row.cells[4].textContent,
            unitPrice: row.cells[5].textContent,
            discount: row.cells[6].textContent,
            totalAmount: row.cells[7].textContent
        };
        const w = window.open('', '_blank');
        w.document.write('<html><head><title>Bill ' + data.billId + '</title></head><body>');
        w.document.write('<h1>Pahana Edu</h1>');
        w.document.write('<h2>Bill</h2>');
        w.document.write('<p><strong>Bill ID:</strong> ' + data.billId + '</p>');
        w.document.write('<p><strong>Date:</strong> ' + data.billDate + '</p>');
        w.document.write('<p><strong>Customer ID:</strong> ' + data.accountNo + '</p>');
        w.document.write('<p><strong>Item ID:</strong> ' + data.itemId + '</p>');
        w.document.write('<p><strong>Qty:</strong> ' + data.qty + '</p>');
        w.document.write('<p><strong>Unit Price:</strong> ' + data.unitPrice + '</p>');
        w.document.write('<p><strong>Discount:</strong> ' + data.discount + '%</p>');
        w.document.write('<h3>Total: Rs. ' + Number(data.totalAmount).toFixed(2) + '</h3>');
        w.document.write('</body></html>');
        w.document.close();
        w.focus();
        w.print();
        w.close();
    }

    function editBill(billId, accountNo, itemId, qty, unitPrice, discount) {
        document.getElementById('billId').value = billId;
        const cusSel = document.getElementById('billCusId');
        cusSel.value = accountNo;
        const itemSel = document.getElementById('itemId');
        itemSel.value = itemId;
        document.getElementById('qty').value = qty;
        document.getElementById('itemPrice').value = parseFloat(unitPrice).toFixed(2);
        document.getElementById('discount').value = discount;
        calculateTotal();
        document.getElementById('generateBtn').style.display = 'none';
        document.getElementById('updateBtn').style.display = 'inline-block';
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function updateBill() {
        const billId = document.getElementById('billId').value;
        if (!billId) {
            alert('No Bill ID selected for update');
            return;
        }
        const billDate = document.getElementById('billDate').value;
        const accountNo = document.getElementById('billCusId').value;
        const itemId = document.getElementById('itemId').value;
        const qty = parseInt(document.getElementById('qty').value, 10) || 0;
        const unitPrice = parseFloat(document.getElementById('itemPrice').value) || 0;
        const discount = parseFloat(document.getElementById('discount').value) || 0;
        const totalAmount = (qty * unitPrice) - ((qty * unitPrice) * discount / 100);

        if (!accountNo || !itemId) {
            alert('Please select a customer and an item!');
            return;
        }

        const bill = { billId, billDate, accountNo, itemId, qty, unitPrice, discount, totalAmount };
        const xhr = new XMLHttpRequest();
        xhr.open('PUT', 'http://localhost:8081/PahanaEduBillingSystem/BillModel', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'updated') {
                    alert('Bill Updated Successfully!');
                    window.location.reload();
                } else {
                    alert('Error updating bill!');
                }
            }
        };
        xhr.send(JSON.stringify(bill));
    }

    function deleteBill(billId) {
        if (!confirm('Are you sure you want to delete bill ' + billId + '?')) return;
        const xhr = new XMLHttpRequest();
        xhr.open('DELETE', 'http://localhost:8081/PahanaEduBillingSystem/BillModel?bill_id=' + encodeURIComponent(billId), true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'deleted') {
                    alert('Bill Deleted Successfully!');
                    window.location.reload();
                } else {
                    alert('Error deleting bill!');
                }
            }
        };
        xhr.send();
    }

    function applyTableFilters() {
        const textFilter = document.getElementById('searchInput').value.toLowerCase().trim();
        const dateFilter = (document.getElementById('billDateFilter').value || '').trim();
        const table = document.getElementById('billTable');
        const rows = table.getElementsByTagName('tr');

        for (let i = 0; i < rows.length; i++) {
            const billId = rows[i].cells[0].innerText.toLowerCase();
            const billDateRaw = rows[i].cells[1].innerText.trim();
            const billDate = billDateRaw;

            const matchesText = !textFilter || billId.includes(textFilter);
            const matchesDate = !dateFilter || billDate === dateFilter;

            rows[i].style.display = (matchesText && matchesDate) ? '' : 'none';
        }
    }

    function searchBill() {
        applyTableFilters();
    }

    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('billDateFilter').value = '';
        applyTableFilters();
    }

    document.getElementById('searchInput').addEventListener('keyup', function() {
        applyTableFilters();
    });
    document.getElementById('billDateFilter').addEventListener('change', function() {
        applyTableFilters();
    });
</script>
</body>
</html>