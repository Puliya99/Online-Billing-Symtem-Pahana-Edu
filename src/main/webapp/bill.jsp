<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 5:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<%@ page import="java.util.List, java.util.Collections, com.example.pahanaedubillingsystem.backend.dto.CustomerDTO, com.example.pahanaedubillingsystem.backend.dto.ItemDTO, com.example.pahanaedubillingsystem.backend.dto.BillDTO, com.example.pahanaedubillingsystem.backend.bo.BOFactory, com.example.pahanaedubillingsystem.backend.bo.custom.CustomerBO, com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO, com.example.pahanaedubillingsystem.backend.bo.custom.BillBO" %>
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
            color: #1a1a1a;
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
        .debug-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 0.25rem;
            cursor: pointer;
            margin: 0.25rem;
            font-size: 0.8rem;
        }
        .debug-panel {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
            padding: 1rem;
            margin: 1rem 0;
            font-family: monospace;
            font-size: 0.9rem;
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
        <input type="hidden" id="cartId" value=""/>
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
                        <input type="date" class="form-control" id="billDate">
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
                                    List<CustomerDTO> customers;
                                    try {
                                        customers = customerBO.getAllCustomers();
                                    } catch (Exception ex) {
                                        customers = java.util.Collections.emptyList();
                                    }
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
                                    List<ItemDTO> items;
                                    try {
                                        items = itemBO.getAllItems();
                                    } catch (Exception ex) {
                                        items = java.util.Collections.emptyList();
                                    }
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
                            <input type="number" class="form-control" id="qty" min="1" oninput="calculateTotal()">
                        </div>
                    </div>
                    <div class="col-md-3" style="display:flex; align-items:flex-end; gap: 10px; margin-left: 30px">
                        <div>
                            <label>Line Total</label>
                            <div id="itemLineTotal" style="font-weight: 600;">Rs. 0.00</div>
                        </div>
                        <button class="btn" type="button" onclick="addItemToCart()"><i class="fas fa-cart-plus"></i> Add Item</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card" style="margin-bottom:1.5rem;">
        <div class="card-header">
            <h5><i class="fas fa-list"></i> Bill Items</h5>
        </div>
        <div class="card-body">
            <div class="table-scroll">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Cart ID</th>
                        <th>Item ID</th>
                        <th>Qty</th>
                        <th>Unit Price</th>
                        <th>Line Total</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody id="cartTable">
                    </tbody>
                </table>
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
                    <div class="col-md-2" style="margin-left: 30px">
                        <div class="form-group">
                            <label for="discount">Discount (%)</label>
                            <input type="number" class="form-control" id="discount" min="0" max="100" oninput="recalcGrandTotal()">
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
                            <th>Cart ID</th>
                            <th>Discount</th>
                            <th>Total Amount</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody id="billTable">
                        <%
                            BillBO billBO = (BillBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.BILL);
                            List<BillDTO> bills;
                            try {
                                bills = billBO.getAllBills();
                            } catch (Exception ex) {
                                bills = java.util.Collections.emptyList();
                            }
                            for (BillDTO bill : bills) {
                        %>
                        <tr data-bill-id="<%= bill.getBillId() %>">
                            <td><%= bill.getBillId() %></td>
                            <td><%= bill.getBillDate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(bill.getBillDate()) : "" %></td>
                            <td><%= bill.getAccountNo() %></td>
                            <td><%= bill.getCartId() %></td>
                            <td><%= bill.getDiscount() %></td>
                            <td><%= bill.getTotalAmount() %></td>
                            <td>
                                <button title="View" style="background:none;border:none;color:#36b9cc;cursor:pointer" onclick="viewBill('<%= bill.getBillId() %>','<%= bill.getCartId() %>')"><i class="fas fa-eye"></i></button>
                                <button title="Print" style="background:none;border:none;color:#4e73df;cursor:pointer" onclick="printBill('<%= bill.getBillId() %>')"><i class="fas fa-print"></i></button>
                                <button title="Edit" style="background:none;border:none;color:#1cc88a;cursor:pointer" onclick="editBill('<%= bill.getBillId() %>','<%= bill.getAccountNo() %>','<%= bill.getCartId() %>',<%= bill.getDiscount() %>)"><i class="fas fa-edit"></i></button>
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

<!-- View Bill Items Modal -->
<div id="billItemsModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index: 1000; align-items: center; justify-content: center;">
    <div style="background:#fff; width:90%; max-width:800px; border-radius:8px; overflow:hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
        <div style="display:flex; align-items:center; justify-content:space-between; padding:12px 16px; background:#f8f9fc; border-bottom:1px solid #e3e6f0;">
            <h5 id="billItemsModalTitle" style="margin:0; color:#5a5c69; font-weight:600;">
                <i class="fas fa-eye"></i> Bill Items
            </h5>
            <button id="billItemsModalClose" aria-label="Close" style="background:none;border:none;font-size:20px;cursor:pointer;color:#6c757d">&times;</button>
        </div>
        <div style="padding:16px;">
            <div id="billItemsInfo" style="margin-bottom:8px; color:#6c757d; font-size:0.9rem;"></div>
            <div class="table-scroll" style="max-height: 360px;">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Item ID</th>
                            <th>Description</th>
                            <th>Qty</th>
                            <th>Unit Price</th>
                            <th>Line Total</th>
                        </tr>
                    </thead>
                    <tbody id="billItemsTbody">
                        <tr><td colspan="5" style="text-align:center;color:#858796">Loading...</td></tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div style="padding:12px 16px; text-align:right; border-top:1px solid #e3e6f0; background:#f8f9fc;">
            <button class="btn" id="billItemsModalOk" style="background-color:#4e73df">OK</button>
        </div>
    </div>
</div>

<script>
    const BASE = '<%= request.getContextPath() %>';
    const cart = [];
    window.itemPrice = 0;
    window.availableQty = 0;

    function updateDebugInfo(message) {
        const debugElement = document.getElementById('debugInfo');
        if (debugElement) {
            const timestamp = new Date().toLocaleTimeString();
            debugElement.innerHTML += `<div>[${timestamp}] ${message}</div>`;
        }
        console.log(message);
    }

    function loadIdDate() {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', BASE + '/BillModel', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const bills = JSON.parse(xhr.responseText || '[]');
                let maxNum = 0;
                let width = 3;
                if (Array.isArray(bills)) {
                    bills.forEach(b => {
                        const id = (b && b.billId) ? String(b.billId) : '';
                        const m = id.match(/(\d+)$/);
                        if (m) {
                            const n = parseInt(m[1], 10);
                            if (!isNaN(n)) {
                                if (n > maxNum) maxNum = n;
                                if (m[1].length > width) width = m[1].length;
                            }
                        }
                    });
                }
                const nextNum = maxNum + 1;
                const nextId = 'B' + String(nextNum).padStart(width, '0');
                document.getElementById('billId').value = nextId;
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

    function loadCustomerDetails() {
        const cusId = document.getElementById('billCusId').value;
        if (!cusId) return;
        const xhr = new XMLHttpRequest();
        xhr.open('GET', BASE + '/CustomerModel', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const customers = JSON.parse(xhr.responseText || '[]');
                const customer = customers.find(cus => cus.accountNo === cusId);
                if (customer) {
                    document.getElementById('billCusName').value = customer.name;
                    updateDebugInfo('Loaded customer: ' + customer.name);
                }
            }
        };
        xhr.send();
    }

    function loadItemDetails() {
        const itemId = document.getElementById('itemId').value;
        if (!itemId) return;
        const xhr = new XMLHttpRequest();
        xhr.open('GET', BASE + '/ItemModel', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const items = JSON.parse(xhr.responseText || '[]');
                const item = items.find(itm => itm.itemId === itemId);
                if (item) {
                    document.getElementById('itemName').value = item.name;
                    const priceNum = Number(item.price);
                    document.getElementById('itemPrice').value = isNaN(priceNum) ? '' : priceNum.toFixed(2);
                    window.itemPrice = priceNum;
                    window.availableQty = Number(item.qty) || 0;
                    calculateTotal();
                    updateDebugInfo('Loaded item: ' + item.name + ' - Rs. ' + priceNum + ' (Available: ' + window.availableQty + ')');
                }
            }
        };
        xhr.send();
    }

    function calculateTotal() {
        const qty = parseInt(document.getElementById('qty').value, 10) || 0;
        const unitPrice = parseFloat(document.getElementById('itemPrice').value) || 0;
        const lineSubtotal = qty * unitPrice;
        const elt = document.getElementById('itemLineTotal');
        if (elt) elt.innerText = 'Rs. ' + lineSubtotal.toFixed(2);
    }

    function fetchCartItems(cid, callback) {
        const cartId = cid || document.getElementById('cartId').value;
        if (!cartId) {
            updateDebugInfo('No cart ID provided to fetchCartItems');
            return;
        }

        updateDebugInfo('Fetching items for cart: ' + cartId);

        const xhr = new XMLHttpRequest();
        xhr.open('GET', BASE + '/CartItemModel?cart_id=' + encodeURIComponent(cartId), true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    try {
                        const items = JSON.parse(xhr.responseText || '[]');
                        updateDebugInfo('Fetched cart items: ' + JSON.stringify(items));

                        cart.length = 0;

                        if (Array.isArray(items) && items.length > 0) {
                            fetchItemDetailsAndPopulateCart(items, () => {
                                renderCart();
                                recalcGrandTotal();
                                if (callback) callback();
                            });
                        } else {
                            updateDebugInfo('No items found in cart');
                            renderCart();
                            recalcGrandTotal();
                            if (callback) callback();
                        }
                    } catch (e) {
                        updateDebugInfo('Failed to parse cart items: ' + e.message);
                        alert('Error loading cart items');
                    }
                } else {
                    updateDebugInfo('Failed to fetch cart items. Status: ' + xhr.status);
                    if (xhr.status === 400) {
                        cart.length = 0;
                        renderCart();
                        recalcGrandTotal();
                        if (callback) callback();
                    } else {
                        alert('Error loading cart items from server');
                    }
                }
            }
        };
        xhr.send();
    }

    function fetchItemDetailsAndPopulateCart(cartItems, callback) {
        updateDebugInfo('Fetching item details for ' + cartItems.length + ' cart items');
        const xhr = new XMLHttpRequest();
        xhr.open('GET', BASE + '/ItemModel', true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                let itemMap = {};

                if (xhr.status === 200) {
                    try {
                        const allItems = JSON.parse(xhr.responseText || '[]');
                        allItems.forEach(item => {
                            itemMap[item.itemId] = {
                                name: item.name || 'Unknown Item',
                                price: Number(item.price) || 0
                            };
                        });
                        updateDebugInfo('Created item map with ' + Object.keys(itemMap).length + ' items');
                    } catch (e) {
                        updateDebugInfo('Failed to parse items: ' + e.message);
                    }
                }

                cartItems.forEach(cartItem => {
                    const qtyNum = Number(cartItem.qty) || 0;
                    const unitNum = Number(cartItem.unitPrice) || (itemMap[cartItem.itemId] ? itemMap[cartItem.itemId].price : 0);
                    const lineTotal = Number(cartItem.lineTotal) || (qtyNum * unitNum);

                    cart.push({
                        cartId: cartItem.cartId || '',
                        itemId: cartItem.itemId || '',
                        qty: qtyNum,
                        unitPrice: unitNum,
                        lineTotal: lineTotal
                    });
                    updateDebugInfo('Added to cart: ' + JSON.stringify({ cartId: cartItem.cartId, itemId: cartItem.itemId, qty: qtyNum, unitPrice: unitNum, lineTotal: lineTotal }));
                });

                updateDebugInfo('Populated cart with ' + cart.length + ' items: ' + JSON.stringify(cart));
                if (callback) callback();
            }
        };
        xhr.send();
    }

    function renderCart() {
        const tbody = document.getElementById('cartTable');
        if (!tbody) {
            updateDebugInfo('ERROR: Cart table body not found');
            return;
        }

        tbody.innerHTML = '';

        if (cart.length === 0) {
            const tr = document.createElement('tr');
            tr.innerHTML = '<td colspan="6" style="text-align: center; color: #858796;">No items in cart</td>';
            tbody.appendChild(tr);
            updateDebugInfo('Rendered empty cart table');
            return;
        }

        cart.forEach((item, idx) => {
            const tr = document.createElement('tr');
            const cartId = item.cartId ? String(item.cartId) : '';
            const itemId = item.itemId ? String(item.itemId) : '';
            const qty = !isNaN(Number(item.qty)) ? Number(item.qty) : 0;
            const unitPrice = !isNaN(Number(item.unitPrice)) ? Number(item.unitPrice) : 0;
            const lineTotal = !isNaN(Number(item.lineTotal)) ? Number(item.lineTotal) : (qty * unitPrice);

            tr.innerHTML = `
            <td>${cartId}</td>
            <td>${itemId}</td>
            <td>${qty}</td>
            <td>Rs. ${unitPrice.toFixed(2)}</td>
            <td>Rs. ${lineTotal.toFixed(2)}</td>
            <td>
                <button class="btn" style="background-color:#e74a3b;padding:0.4rem 0.75rem"
                        onclick="removeCartItem(${idx})" title="Remove item">
                    <i class="fas fa-times"></i> Remove
                </button>
            </td>
        `;
            tbody.appendChild(tr);
            updateDebugInfo('Rendered row for item: ' + itemId + ' at index ' + idx);
        });

        updateDebugInfo('Rendered cart table with ' + cart.length + ' items');
    }

    function addItemToCart() {
        const cartId = document.getElementById('cartId').value;
        const itemId = document.getElementById('itemId').value;
        const qty = parseInt(document.getElementById('qty').value, 10) || 0;
        const unitPrice = parseFloat(document.getElementById('itemPrice').value) || 0;
        const accountNo = document.getElementById('billCusId').value;

        if (!accountNo) {
            alert('Please select a customer first');
            return;
        }
        if (!itemId) {
            alert('Please select an item');
            return;
        }
        if (qty <= 0) {
            alert('Please enter a valid quantity');
            return;
        }

        const available = Number(window.availableQty) || 0;
        let existingInCart = 0;
        for (const it of cart) {
            if (it.itemId === itemId) existingInCart += Number(it.qty) || 0;
        }
        if (qty + existingInCart > available) {
            alert('qty not enough. available qty is: ' + available);
            return;
        }

        const ensureCartAndAddItem = () => {
            const cartIdInput = document.getElementById('cartId');
            let cartId = cartIdInput.value;

            const addCartItem = (cid) => {
                const lineTotal = qty * unitPrice;
                const payload = { cartId: cid, itemId, qty, unitPrice, lineTotal };
                const xhrItem = new XMLHttpRequest();
                xhrItem.open('POST', BASE + '/CartItemModel', true);
                xhrItem.setRequestHeader('Content-Type', 'application/json');
                xhrItem.onreadystatechange = function () {
                    if (xhrItem.readyState === 4) {
                        if (xhrItem.status === 200 && xhrItem.responseText === 'saved') {
                            updateDebugInfo('Successfully added item to cart: ' + itemId);
                            fetchCartItems(cid, () => {
                                document.getElementById('itemId').value = '';
                                document.getElementById('itemName').value = '';
                                document.getElementById('itemPrice').value = '';
                                document.getElementById('qty').value = '';
                                const elt = document.getElementById('itemLineTotal');
                                if (elt) elt.innerText = 'Rs. 0.00';
                                window.availableQty = 0;
                                recalcGrandTotal();
                            });
                        } else {
                            alert('Failed to add item to cart in database');
                        }
                    }
                };
                xhrItem.send(JSON.stringify(payload));
            };

            if (cartId) {
                addCartItem(cartId);
                return;
            }

            const xhrGet = new XMLHttpRequest();
            xhrGet.open('GET', BASE + '/CartModel', true);
            xhrGet.onreadystatechange = function () {
                if (xhrGet.readyState === 4) {
                    let nextId = 'CART001';
                    if (xhrGet.status === 200) {
                        try {
                            const carts = JSON.parse(xhrGet.responseText || '[]');
                            if (Array.isArray(carts) && carts.length > 0) {
                                const last = carts[carts.length - 1].cartId || '';
                                const num = parseInt((last.match(/(\d+)$/) || [0,'0'])[1], 10);
                                nextId = 'CART' + String(num + 1).padStart(3, '0');
                            }
                        } catch (e) {
                        }
                    }
                    const newCart = { cartId: nextId, description: 'Cart for ' + accountNo };
                    const xhrPost = new XMLHttpRequest();
                    xhrPost.open('POST', BASE + '/CartModel', true);
                    xhrPost.setRequestHeader('Content-Type', 'application/json');
                    xhrPost.onreadystatechange = function () {
                        if (xhrPost.readyState === 4) {
                            if (xhrPost.status === 200 && xhrPost.responseText === 'saved') {
                                cartIdInput.value = nextId;
                                updateDebugInfo('Created new cart: ' + nextId);
                                addCartItem(nextId);
                            } else {
                                alert('Failed to create cart in database');
                            }
                        }
                    };
                    xhrPost.send(JSON.stringify(newCart));
                }
            };
            xhrGet.send();
        };

        ensureCartAndAddItem();
    }

    function removeCartItem(index) {
        const it = cart[index];
        const cartId = document.getElementById('cartId').value;
        if (!it || !cartId) {
            cart.splice(index, 1);
            renderCart();
            recalcGrandTotal();
            return;
        }
        if (!confirm('Remove ' + it.itemId + ' from this cart?')) return;

        updateDebugInfo('Removing item: ' + it.itemId + ' from cart: ' + cartId);

        const xhr = new XMLHttpRequest();
        xhr.open('DELETE', BASE + '/CartItemModel?cart_id=' + encodeURIComponent(cartId) + '&item_id=' + encodeURIComponent(it.itemId), true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'deleted') {
                    updateDebugInfo('Successfully removed item from cart');
                    fetchCartItems(cartId);
                } else {
                    updateDebugInfo('Failed to remove cart item. Status: ' + xhr.status + ' Response: ' + xhr.responseText);
                    alert('Failed to remove cart item from database');
                }
            }
        };
        xhr.send();
    }

    function recalcGrandTotal() {
        const subtotal = cart.reduce((acc, item) => {
            const lineTotal = Number(item.lineTotal) || (Number(item.qty) * Number(item.unitPrice)) || 0;
            return acc + lineTotal;
        }, 0);

        const discountPercent = parseFloat(document.getElementById('discount').value) || 0;
        const discountAmount = subtotal * (discountPercent / 100);
        const finalTotal = subtotal - discountAmount;

        const billTotalElement = document.getElementById('billTotal');
        if (billTotalElement) {
            billTotalElement.innerText = 'Rs. ' + finalTotal.toFixed(2);
        }

        updateDebugInfo('Grand total: Subtotal=' + subtotal.toFixed(2) + ', Discount=' + discountPercent + '%, Final=' + finalTotal.toFixed(2));
    }

    function generateBill() {
        const billId = document.getElementById('billId').value;
        const billDate = document.getElementById('billDate').value;
        const accountNo = document.getElementById('billCusId').value;
        const cartId = document.getElementById('cartId').value;
        const discount = parseFloat(document.getElementById('discount').value) || 0;

        if (!accountNo) {
            alert('Please select a customer');
            return;
        }
        if (!billDate) {
            alert('Please select a date for the bill');
            return;
        }
        if (!cartId) {
            alert('No cart found. Please add at least one item first.');
            return;
        }
        if (cart.length === 0) {
            alert('Please add at least one item to the bill');
            return;
        }

        const sum = cart.reduce((acc, it) => acc + (Number(it.lineTotal) || Number(it.totalAmount) || 0), 0);
        const totalAmount = sum - (sum * discount / 100);

        const payload = {
            billId,
            billDate,
            accountNo,
            cartId,
            discount: Math.round(discount),
            totalAmount
        };

        updateDebugInfo('Generating bill: ' + JSON.stringify(payload));

        const xhr = new XMLHttpRequest();
        xhr.open('POST', BASE + '/BillModel', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'saved') {
                    updateDebugInfo('Bill generated successfully');
                    alert('Bill Generated Successfully!');
                    window.location.reload();
                } else {
                    updateDebugInfo('Failed to generate bill. Status: ' + xhr.status + ' Response: ' + xhr.responseText);
                    alert('Error generating bill!');
                }
            }
        };
        xhr.send(JSON.stringify(payload));
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
            cartId: row.cells[3].textContent,
            discount: row.cells[4].textContent,
            totalAmount: row.cells[5].textContent
        };
        const w = window.open('', '_blank');
        w.document.write('<html><head><title>Bill ' + data.billId + '</title></head><body>');
        w.document.write('<h1>Pahana Edu</h1>');
        w.document.write('<h2>Bill</h2>');
        w.document.write('<p><strong>Bill ID:</strong> ' + data.billId + '</p>');
        w.document.write('<p><strong>Date:</strong> ' + data.billDate + '</p>');
        w.document.write('<p><strong>Customer ID:</strong> ' + data.accountNo + '</p>');
        w.document.write('<p><strong>Cart ID:</strong> ' + data.cartId + '</p>');
        w.document.write('<p><strong>Discount:</strong> ' + data.discount + '%</p>');
        w.document.write('<h3>Total: Rs. ' + Number(data.totalAmount).toFixed(2) + '</h3>');
        w.document.write('</body></html>');
        w.document.close();
        w.focus();
        w.print();
        w.close();
    }

    function editBill(billId, accountNo, cartId, discount) {
        updateDebugInfo('Editing bill: ' + JSON.stringify({ billId, accountNo, cartId, discount }));

        document.getElementById('billId').value = billId;
        document.getElementById('billCusId').value = accountNo;
        document.getElementById('cartId').value = cartId || '';
        document.getElementById('discount').value = discount || 0;
        try {
            const row = findBillRow(billId);
            if (row && row.cells && row.cells[1]) {
                const d = (row.cells[1].textContent || '').trim();
                if (d) document.getElementById('billDate').value = d;
            }
        } catch (e) { /* ignore */ }

        loadCustomerDetails();

        if (cartId) {
            fetchCartItems(cartId);
        } else {
            cart.length = 0;
            renderCart();
            recalcGrandTotal();
            updateDebugInfo('No cart ID provided for editing');
        }

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
        const cartId = document.getElementById('cartId').value;
        const discount = parseFloat(document.getElementById('discount').value) || 0;

        if (!accountNo || !cartId) {
            alert('Please select a customer and ensure cart exists!');
            return;
        }
        if (!billDate) {
            alert('Please select a date for the bill');
            return;
        }

        const sum = cart.reduce((acc, it) => acc + (Number(it.lineTotal) || 0), 0);
        const totalAmount = sum - (sum * discount / 100);

        const bill = { billId, billDate, accountNo, cartId, discount: Math.round(discount), totalAmount };

        updateDebugInfo('Updating bill: ' + JSON.stringify(bill));

        const xhr = new XMLHttpRequest();
        xhr.open('PUT', BASE + '/BillModel', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'updated') {
                    updateDebugInfo('Bill updated successfully');
                    alert('Bill Updated Successfully!');
                    window.location.reload();
                } else {
                    updateDebugInfo('Failed to update bill. Status: ' + xhr.status + ' Response: ' + xhr.responseText);
                    alert('Error updating bill!');
                }
            }
        };
        xhr.send(JSON.stringify(bill));
    }

    function deleteBill(billId) {
        if (!confirm('Are you sure you want to delete bill ' + billId + '?')) return;

        updateDebugInfo('Deleting bill: ' + billId);

        const xhr = new XMLHttpRequest();
        xhr.open('DELETE', BASE + '/BillModel?bill_id=' + encodeURIComponent(billId), true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'deleted') {
                    updateDebugInfo('Bill deleted successfully');
                    alert('Bill Deleted Successfully!');
                    window.location.reload();
                } else {
                    updateDebugInfo('Failed to delete bill. Status: ' + xhr.status + ' Response: ' + xhr.responseText);
                    alert('Error deleting bill!');
                }
            }
        };
        xhr.send();
    }

    function openBillItemsModal() {
        const modal = document.getElementById('billItemsModal');
        if (!modal) return;
        modal.style.display = 'flex';
    }
    function closeBillItemsModal() {
        const modal = document.getElementById('billItemsModal');
        if (!modal) return;
        modal.style.display = 'none';
    }

    function renderBillItemsModal(items, billId, cartId, itemMap) {
        const tbody = document.getElementById('billItemsTbody');
        const info = document.getElementById('billItemsInfo');
        const title = document.getElementById('billItemsModalTitle');
        if (title) title.innerHTML = '<i class="fas fa-eye"></i> Bill Items - ' + billId;
        if (info) info.textContent = 'Cart ID: ' + (cartId || '-') + '  •  Items: ' + (Array.isArray(items) ? items.length : 0);

        if (!tbody) return;
        tbody.innerHTML = '';
        if (!Array.isArray(items) || items.length === 0) {
            const tr = document.createElement('tr');
            tr.innerHTML = '<td colspan="5" style="text-align:center;color:#858796">No items found for this bill</td>';
            tbody.appendChild(tr);
            return;
        }
        items.forEach(ci => {
            const id = ci.itemId || '';
            const qty = Number(ci.qty) || 0;
            const price = Number(ci.unitPrice) || (itemMap && itemMap[id] ? Number(itemMap[id].price) : 0);
            const name = (itemMap && itemMap[id] ? itemMap[id].name : '') || '';
            const line = Number(ci.lineTotal) || (qty * price);
            const tr = document.createElement('tr');
            tr.innerHTML = '\n                <td>' + id + '</td>\n                <td>' + name + '</td>\n                <td>' + qty + '</td>\n                <td>Rs. ' + price.toFixed(2) + '</td>\n                <td>Rs. ' + line.toFixed(2) + '</td>\n            ';
            tbody.appendChild(tr);
        });
    }

    function viewBill(billId, cartId) {
        if (!cartId) {
            alert('This bill does not have a cart.');
            return;
        }
        const tbody = document.getElementById('billItemsTbody');
        if (tbody) tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;color:#858796">Loading...</td></tr>';
        const info = document.getElementById('billItemsInfo');
        if (info) info.textContent = '';
        openBillItemsModal();

        const xhr = new XMLHttpRequest();
        xhr.open('GET', BASE + '/CartItemModel?cart_id=' + encodeURIComponent(cartId), true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    let cartItems = [];
                    try {
                        cartItems = JSON.parse(xhr.responseText || '[]');
                    } catch (e) {
                        updateDebugInfo('Failed to parse cart items for view: ' + e.message);
                        renderBillItemsModal([], billId, cartId, {});
                        return;
                    }
                    const xhrItems = new XMLHttpRequest();
                    xhrItems.open('GET', BASE + '/ItemModel', true);
                    xhrItems.onreadystatechange = function () {
                        if (xhrItems.readyState === 4) {
                            let itemMap = {};
                            if (xhrItems.status === 200) {
                                try {
                                    const allItems = JSON.parse(xhrItems.responseText || '[]');
                                    allItems.forEach(it => { itemMap[it.itemId] = { name: it.name || 'Unknown Item', price: Number(it.price) || 0 }; });
                                } catch (e) {
                                    updateDebugInfo('Failed to parse items for view: ' + e.message);
                                }
                            }
                            renderBillItemsModal(cartItems, billId, cartId, itemMap);
                        }
                    };
                    xhrItems.send();
                } else {
                    updateDebugInfo('Failed to fetch cart items for view. Status: ' + xhr.status);
                    renderBillItemsModal([], billId, cartId, {});
                }
            }
        };
        xhr.send();
    }

    (function() {
        const closeBtn = document.getElementById('billItemsModalClose');
        const okBtn = document.getElementById('billItemsModalOk');
        const modal = document.getElementById('billItemsModal');
        if (closeBtn) closeBtn.addEventListener('click', closeBillItemsModal);
        if (okBtn) okBtn.addEventListener('click', closeBillItemsModal);
        if (modal) modal.addEventListener('click', function(evt){
            if (evt.target === modal) closeBillItemsModal();
        });
    })();

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

    function loadCartItemsByCartId(cartId) {
        if (!cartId) {
            cartId = prompt('Enter Cart ID to load:');
        }
        if (cartId) {
            document.getElementById('cartId').value = cartId;
            fetchCartItems(cartId);
        }
    }

    function refreshCartItems() {
        const cartId = document.getElementById('cartId').value;
        if (cartId) {
            updateDebugInfo('Refreshing cart items for: ' + cartId);
            fetchCartItems(cartId);
        } else {
            alert('No cart ID set');
        }
    }

    document.getElementById('searchInput').addEventListener('keyup', function() {
        applyTableFilters();
    });

    document.getElementById('billDateFilter').addEventListener('change', function() {
        applyTableFilters();
    });

    loadIdDate();
    updateDebugInfo('Page initialized');
</script>
</body>
</html>