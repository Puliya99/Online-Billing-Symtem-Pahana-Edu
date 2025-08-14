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
    String role = null;
    Object roleAttr = session.getAttribute("role");
    if (roleAttr != null) {
        role = roleAttr.toString();
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

    /* Dark mode extensions for app UI */
    .dark-mode .container {
        color: #e0e0e0;
    }
    .dark-mode .section-header {
        border-bottom-color: #3a3a3a;
    }
    .dark-mode .section-header h2 {
        color: #e0e0e0;
    }
    .dark-mode .section-header p {
        color: #b0b0b0;
    }
    /* Cards and panels */
    .dark-mode .stat-card,
    .dark-mode .form-card,
    .dark-mode .data-card,
    .dark-mode .card {
        background: #2b2b2b;
        color: #e0e0e0;
        box-shadow: 0 0.15rem 1.75rem 0 rgba(0, 0, 0, 0.3);
        border-color: #3a3a3a;
    }
    .dark-mode .stat-info p { color: #b0b0b0; }
    .dark-mode .stat-card:hover { box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,0.4); }

    /* Tables */
    .dark-mode .table { color: #e0e0e0; }
    .dark-mode .table th,
    .dark-mode .table td { border-color: #3a3a3a; }
    .dark-mode .table tbody tr:hover { background-color: rgba(78, 115, 223, 0.08); }

    /* Forms */
    .dark-mode .form-control {
        background-color: #1f1f1f;
        color: #e0e0e0;
        border-color: #3a3a3a;
    }
    .dark-mode .form-control:focus {
        border-color: #4e73df;
        box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        outline: none;
    }
    .dark-mode .input-group-text {
        background-color: #262626;
        color: #d0d0d0;
        border-color: #3a3a3a;
    }

    /* Buttons - keep brand color but tweak hover shadow */
    .dark-mode .btn:hover { box-shadow: 0 4px 15px rgba(78, 115, 223, 0.35); }

    /* Alerts */
    .dark-mode .alert {
        color: #e0e0e0;
        background-color: #2b2b2b;
        border-color: #3a3a3a;
    }
    .dark-mode .alert-warning {
        color: #ffe08a;
        background-color: rgba(255, 193, 7, 0.15);
        border-color: rgba(255, 193, 7, 0.3);
    }

    /* Accordion */
    .dark-mode .accordion-button {
        background-color: #262626;
        border-color: #3a3a3a;
        color: #e0e0e0;
    }
    .dark-mode .accordion-button:hover { background-color: rgba(78, 115, 223, 0.15); }
    .dark-mode .accordion-content {
        background-color: #1f1f1f;
        border-color: #3a3a3a;
        color: #dcdcdc;
    }

    /* Responsive menu */
    .menu-toggle {
        display: none;
        background: none;
        border: none;
        color: #4e73df;
        font-size: 1.4rem;
        cursor: pointer;
        padding: 0.25rem 0.5rem;
        border-radius: 0.35rem;
    }
    .menu-toggle:focus { outline: 2px solid rgba(78,115,223,0.4); }

    @media (max-width: 768px) {
        .menu-toggle { display: block; }
        .nav-list {
            display: none;
            position: absolute;
            top: 60px;
            left: 0;
            right: 0;
            flex-direction: column;
            background: #ffffff;
            padding: 0.5rem 0;
            gap: 0;
            border-bottom: 1px solid #e3e6f0;
            box-shadow: 0 0.5rem 1.5rem rgba(58, 59, 69, 0.15);
        }
        .nav-list.show { display: flex; }
        .nav-list li { border-top: 1px solid #e3e6f0; }
        .nav-list li:first-child { border-top: none; }
        .nav-link { border-radius: 0; padding: 0.75rem 1rem; }
        .user-logo { margin: 0.5rem 1rem 0.25rem auto; }
    }

    .dark-mode @media (max-width: 768px) { /* not valid syntax, so override below */ }
    @media (max-width: 768px) {
        .dark-mode .nav-list {
            background: #2d2d2d;
            border-bottom-color: #3a3a3a;
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.3);
        }
        .dark-mode .nav-list li { border-top-color: #3a3a3a; }
    }
</style>
<nav class="navbar">
    <div style="display: flex; align-items: center;">
        <img src="frontend/assets/logo.png" alt="Logo" class="nav-logo">
        <span class="brand-name">Pahana Edu</span>
    </div>
    <button class="menu-toggle" aria-label="Toggle menu" onclick="toggleMenu()"><i class="fas fa-bars"></i></button>
    <ul id="mainNav" class="nav-list">
        <li><a id="dashboard" class="nav-link" href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i>Dashboard</a></li>
        <li><a id="customer" class="nav-link" href="customer.jsp"><i class="fas fa-users"></i>Customer</a></li>
        <li><a id="item" class="nav-link" href="item.jsp"><i class="fas fa-box-open"></i>Item</a></li>
        <li><a id="vendor" class="nav-link" href="vendor.jsp"><i class="fas fa-truck"></i>Vendor</a></li>
        <li><a id="bill" class="nav-link" href="bill.jsp"><i class="fas fa-file-invoice-dollar"></i>Bill</a></li>
        <% if (role != null && role.equalsIgnoreCase("admin")) { %>
        <li><a id="user" class="nav-link" href="user.jsp"><i class="fas fa-user"></i>User</a></li>
        <% } %>
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
    window.CURRENT_USERNAME = '<%= username %>';
    window.CURRENT_USER_ROLE = '<%= role != null ? role : "" %>';

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

        const dropdown = document.querySelector('.user-dropdown');
        if (dropdown) dropdown.style.display = 'none';
    }

    function disableDeleteForNonAdmin() {
        try {
            const role = (window.CURRENT_USER_ROLE || '').toLowerCase();
            if (role === 'admin') return;
            const deleteControls = document.querySelectorAll('.btn-danger, [data-action="delete"], .delete-button');
            deleteControls.forEach(el => {
                el.style.opacity = '0.6';
                el.style.cursor = 'not-allowed';
                el.setAttribute('title', 'Delete is allowed only for Admins');
                // Disable form controls if possible
                if (typeof el.disabled !== 'undefined') {
                    el.disabled = true;
                }
                el.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    alert('You do not have permission to delete. Please contact an administrator.');
                    return false;
                }, { capture: true });
            });
        } catch (e) { /* noop */ }
    }

    function toggleMenu() {
        const nav = document.getElementById('mainNav');
        if (nav) nav.classList.toggle('show');
    }

    function closeMenu() {
        const nav = document.getElementById('mainNav');
        if (nav) nav.classList.remove('show');
    }

    window.onload = function() {
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme === 'dark') {
            document.body.classList.add('dark-mode');
        }

        disableDeleteForNonAdmin();

        document.addEventListener('click', function(event) {
            const dropdown = document.querySelector('.user-dropdown');
            const userLogo = document.querySelector('.user-logo');
            if (dropdown && userLogo && !userLogo.contains(event.target)) {
                dropdown.style.display = 'none';
            }
            // Close mobile menu when clicking outside the navbar
            const navbar = document.querySelector('.navbar');
            const nav = document.getElementById('mainNav');
            if (nav && navbar && !navbar.contains(event.target)) {
                closeMenu();
            }
        });

        document.querySelectorAll('#mainNav .nav-link, #mainNav .dropdown-item').forEach(function(a){
            a.addEventListener('click', function(){
                closeMenu();
            });
        });

        window.addEventListener('resize', function(){
            if (window.innerWidth > 768) {
                closeMenu();
            }
        });
    };
</script>