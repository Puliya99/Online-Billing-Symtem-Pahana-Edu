<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 5:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.example.pahanaedubillingsystem.backend.dto.CustomerDTO, com.example.pahanaedubillingsystem.backend.dto.BillDTO, com.example.pahanaedubillingsystem.backend.bo.BOFactory, com.example.pahanaedubillingsystem.backend.bo.custom.CustomerBO, com.example.pahanaedubillingsystem.backend.bo.custom.BillBO" %>
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
            padding: 1.5rem;
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
        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .col-md-3 {
            flex: 1;
            min-width: 200px;
        }
        .col-md-4 {
            flex: 1.33;
            min-width: 200px;
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
                <h5><i class="fas fa-user-tag"></i> Customer Details</h5>
            </div>
            <div class="card-body">
                <div class="row">
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
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="billCusUnits">Units Consumed</label>
                            <input type="text" class="form-control" id="billCusUnits" disabled>
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
                        <button class="btn" onclick="generateBill()"><i class="fas fa-file-invoice"></i> Generate Bill</button>
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
            <div class="card-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Date</th>
                        <th>Customer ID</th>
                        <th>Total Amount</th>
                    </tr>
                    </thead>
                    <tbody id="billTable">
                    <%
                        BillBO billBO = (BillBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.BILL);
                        List<BillDTO> bills = billBO.getAllBills();
                        for (BillDTO bill : bills) {
                    %>
                    <tr>
                        <td><%= bill.getBillId() %></td>
                        <td><%= bill.getBillDate() %></td>
                        <td><%= bill.getAccountNo() %></td>
                        <td><%= bill.getTotalAmount() %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
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
                    document.getElementById('billCusUnits').value = customer.unitsConsumed;
                    calculateTotal();
                }
            }
        };
        xhr.send();
    }

    function calculateTotal() {
        const units = parseInt(document.getElementById('billCusUnits').value) || 0;
        const total = units * 100; // Rs.100 per unit
        document.getElementById('billTotal').innerText = `Rs. ${total.toFixed(2)}`;
    }

    function generateBill() {
        const billId = document.getElementById('billId').value;
        const billDate = document.getElementById('billDate').value;
        const accountNo = document.getElementById('billCusId').value;
        const totalAmount = parseFloat(document.getElementById('billTotal').innerText.slice(4));

        if (!accountNo) {
            alert('Please select a customer!');
            return;
        }

        const bill = { billId, billDate, accountNo, totalAmount };
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
</script>
</body>
</html>
