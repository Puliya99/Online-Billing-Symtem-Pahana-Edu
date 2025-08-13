<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<style>
    .navbar {
        background-color: white;
        box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        padding: 0.5rem 1rem;
        position: sticky;
        top: 0;
        z-index: 1000;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .nav-logo {
        height: 40px;
        margin-right: 10px;
    }
    .brand-name {
        font-weight: 800;
        color: #4e73df;
        font-size: 1.2rem;
    }
    .nav-list {
        list-style: none;
        display: flex;
        gap: 0.5rem;
        margin: 0;
        padding: 0;
    }
    .nav-link {
        color: #858796;
        font-weight: 600;
        padding: 0.5rem 1rem;
        border-radius: 0.35rem;
        text-decoration: none;
        display: flex;
        align-items: center;
        transition: all 0.3s ease;
    }
    .nav-link:hover, .nav-link.active {
        color: #4e73df;
        background-color: rgba(78, 115, 223, 0.1);
    }
    .nav-link i {
        font-size: 0.9rem;
        margin-right: 0.5rem;
    }
</style>
<nav class="navbar">
    <div style="display: flex; align-items: center;">
        <img src="frontend/assets/logo.png" alt="Logo" class="nav-logo">
        <span class="brand-name">Pahana Edu</span>
    </div>
    <ul class="nav-list">
        <li><a id="dashboard" class="nav-link" href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i>Dashboard</a></li>
        <li><a id="customer" class="nav-link" href="customer.jsp"><i class="fas fa-users"></i>Customer</a></li>
        <li><a id="vendor" class="nav-link" href="vendor.jsp"><i class="fas fa-truck"></i>Vendor</a></li>
        <li><a id="item" class="nav-link" href="item.jsp"><i class="fas fa-box-open"></i>Item</a></li>
        <li><a id="bill" class="nav-link" href="bill.jsp"><i class="fas fa-file-invoice-dollar"></i>Bill</a></li>
        <li><a id="user" class="nav-link" href="user.jsp"><i class="fas fa-user"></i>User</a></li>
        <li><a id="help" class="nav-link" href="help.jsp"><i class="fas fa-question-circle"></i>Help</a></li>
        <li><a id="logout" class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt"></i>Logout</a></li>
    </ul>
</nav>