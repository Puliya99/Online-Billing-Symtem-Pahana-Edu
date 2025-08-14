<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
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
    .user-logo {
        height: 40px;
        width: 40px;
        background-color: #4e73df;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        cursor: pointer;
        margin-right: 10px;
        position: relative;
    }
    .user-dropdown {
        display: none;
        position: absolute;
        top: 100%;
        right: 0;
        background-color: white;
        box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        border-radius: 0.35rem;
        min-width: 150px;
        z-index: 1001;
        margin-top: 5px;
    }
    .user-logo:hover .user-dropdown {
        display: block;
    }
    .dropdown-item {
        color: #858796;
        font-weight: 600;
        padding: 0.5rem 1rem;
        text-decoration: none;
        display: block;
        transition: all 0.3s ease;
    }
    .dropdown-item:hover {
        color: #4e73df;
        background-color: rgba(78, 115, 223, 0.1);
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
    /* Dark mode styles */
    body.dark-mode {
        background-color: #1a1a1a;
        color: #e0e0e0;
    }
    .dark-mode .navbar {
        background-color: #2d2d2d;
        box-shadow: 0 0.15rem 1.75rem 0 rgba(0, 0, 0, 0.3);
    }
    .dark-mode .brand-name {
        color: #4e73df;
    }
    .dark-mode .nav-link {
        color: #b0b0b0;
    }
    .dark-mode .nav-link:hover, .dark-mode .nav-link.active {
        color: #4e73df;
        background-color: rgba(78, 115, 223, 0.2);
    }
    .dark-mode .user-logo {
        background-color: #6c757d;
    }
    .dark-mode .user-dropdown {
        background-color: #2d2d2d;
        box-shadow: 0 0.15rem 1.75rem 0 rgba(0, 0, 0, 0.3);
    }
    .dark-mode .dropdown-item {
        color: #b0b0b0;
    }
    .dark-mode .dropdown-item:hover {
        color: #4e73df;
        background-color: rgba(78, 115, 223, 0.2);
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
        <div class="user-logo" onclick="toggleDropdown(event)">
            <%= username.charAt(0) %>
            <div class="user-dropdown">
                <a class="dropdown-item" href="#" onclick="toggleTheme(event)">Theme</a>
                <a class="dropdown-item" href="logout.jsp">Logout</a>
            </div>
        </div>
    </ul>
</nav>

<script>
    function toggleDropdown(event) {
        if (event.target.closest('.dropdown-item')) {
            return;
        }
        event.preventDefault();
        const container = event.currentTarget;
        const dropdown = container.querySelector('.user-dropdown');
        if (dropdown) {
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }
    }

    function toggleTheme(event) {
        event.preventDefault();
        const body = document.body;
        const isDarkMode = body.classList.contains('dark-mode');

        if (isDarkMode) {
            body.classList.remove('dark-mode');
            localStorage.setItem('theme', 'light');
        } else {
            body.classList.add('dark-mode');
            localStorage.setItem('theme', 'dark');
        }

        // Hide dropdown after action
        const dropdown = document.querySelector('.user-dropdown');
        if (dropdown) dropdown.style.display = 'none';
    }

    // Load saved theme on page load
    window.onload = function() {
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme === 'dark') {
            document.body.classList.add('dark-mode');
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', function(event) {
            const dropdown = document.querySelector('.user-dropdown');
            const userLogo = document.querySelector('.user-logo');
            if (dropdown && !userLogo.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
    };
</script>