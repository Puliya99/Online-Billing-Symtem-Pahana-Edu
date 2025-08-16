<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 3:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.example.pahanaedubillingsystem.backend.dto.CustomerDTO, com.example.pahanaedubillingsystem.backend.dto.ItemDTO, com.example.pahanaedubillingsystem.backend.dto.BillDTO, com.example.pahanaedubillingsystem.backend.bo.BOFactory, com.example.pahanaedubillingsystem.backend.bo.custom.CustomerBO, com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO, com.example.pahanaedubillingsystem.backend.bo.custom.BillBO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.bo.custom.VendorBO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.dto.VendorDTO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.bo.custom.UserBO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.dto.UserDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <title>Pahana Edu Billing System - Dashboard</title>
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
        .stats-row {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: white;
            border-radius: 0.35rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            padding: 1.5rem;
            flex: 1;
            min-width: 250px;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            border-left: 0.25rem solid transparent;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.1);
        }
        .stat-card.customers { border-left-color: #4e73df; }
        .stat-card.items { border-left-color: #36b9cc; }
        .stat-card.bills { border-left-color: #1cc88a; }
        .stat-card.vendors { border-left-color: #f6c23e; }
        .stat-card.users { border-left-color: #e74a3b; }
        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.5rem;
            color: white;
        }
        .stat-card.customers .stat-icon { background-color: #4e73df; }
        .stat-card.items .stat-icon { background-color: #36b9cc; }
        .stat-card.bills .stat-icon { background-color: #1cc88a; }
        .stat-card.vendors .stat-icon { background-color: #f6c23e; }
        .stat-card.users .stat-icon { background-color: #e74a3b; }
        .stat-info h3 {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }
        .stat-info p {
            color: #858796;
            margin-bottom: 0;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<%@ include file="nav.jsp" %>
<div class="container">
    <div class="section-header">
        <h2><i class="fas fa-tachometer-alt"></i> Dashboard</h2>
        <p>Overview of your billing system</p>
    </div>
    <div class="stats-row">
        <%
            CustomerBO customerBO = (CustomerBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.CUSTOMER);
            ItemBO itemBO = (ItemBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.ITEM);
            VendorBO vendorBO = (VendorBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.VENDOR);
            BillBO billBO = (BillBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.BILL);
            List<CustomerDTO> customers = customerBO.getAllCustomers();
            List<ItemDTO> items = itemBO.getAllItems();
            List<VendorDTO> vendors = vendorBO.getAllVendors();
            List<BillDTO> bills = billBO.getAllBills();
            UserBO userBO = (UserBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.USER);
            List<UserDTO> users = userBO.getAllUsers();
        %>
        <div class="stat-card customers">
            <div class="stat-icon"><i class="fas fa-users"></i></div>
            <div class="stat-info">
                <h3><%= customers.size() %></h3>
                <p>Customers</p>
            </div>
        </div>
        <div class="stat-card items">
            <div class="stat-icon"><i class="fas fa-box-open"></i></div>
            <div class="stat-info">
                <h3><%= items.size() %></h3>
                <p>Items</p>
            </div>
        </div>
        <div class="stat-card vendors">
            <div class="stat-icon"><i class="fas fa-truck"></i></div>
            <div class="stat-info">
                <h3><%= vendors.size() %></h3>
                <p>Vendors</p>
            </div>
        </div>
        <div class="stat-card bills">
            <div class="stat-icon"><i class="fas fa-file-invoice-dollar"></i></div>
            <div class="stat-info">
                <h3><%= bills.size() %></h3>
                <p>Bills Today</p>
            </div>
        </div>
        <div class="stat-card users">
            <div class="stat-icon"><i class="fas fa-user-shield"></i></div>
            <div class="stat-info">
                <h3><%= users.size() %></h3>
                <p>Users</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
