<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/13/25
  Time: 5:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.example.pahanaedubillingsystem.backend.dto.UserDTO, com.example.pahanaedubillingsystem.backend.bo.BOFactory, com.example.pahanaedubillingsystem.backend.bo.custom.UserBO" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String _role = null;
    Object _roleAttr = session.getAttribute("role");
    if (_roleAttr != null) {
        _role = _roleAttr.toString();
    }
    if (_role == null || !_role.equalsIgnoreCase("admin")) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <title>Pahana Edu Billing System - User</title>
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
        <h2><i class="fas fa-user"></i> User Management</h2>
        <p>Manage your users and their details</p>
    </div>

    <!-- User Form -->
    <div class="form-card">
        <h4><i class="fas fa-user-edit"></i> User Form</h4>
        <div class="alert alert-warning" style="display: none;" id="deleteWarning">
            <strong>Note:</strong> Users with associated activities cannot be deleted. Please resolve all associated activities first.
        </div>
        <form id="user-form">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" class="form-control" id="username" placeholder="Enter Username">
                </div>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control" id="password" placeholder="Enter Password">
                </div>
            </div>
            <div class="form-group">
                <label for="userRole">Role</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user-tag"></i></span>
                    <input type="text" class="form-control" id="userRole" placeholder="e.g., Admin">
                </div>
            </div>
            <div class="buttons">
                <button type="button" class="btn btn-primary" onclick="saveUser()"><i class="fas fa-save"></i> Save</button>
                <button type="button" class="btn btn-success" onclick="updateUser()"><i class="fas fa-sync"></i> Update</button>
                <button type="button" class="btn btn-danger" onclick="deleteUser()"><i class="fas fa-trash"></i> Delete</button>
                <button type="reset" class="btn btn-warning" onclick="resetForm()"><i class="fas fa-eraser"></i> Clear</button>
            </div>
        </form>
    </div>

    <!-- User List -->
    <div class="data-card">
        <h4><i class="fas fa-list"></i> User List</h4>

        <!-- Search Bar -->
        <div style="margin-bottom: 1rem; display: flex; gap: 0.5rem;">
            <input type="text" id="searchInput" class="form-control" placeholder="Search by User Name" style="flex: 1;">
            <button type="button" class="btn btn-primary" onclick="searchUser()">
                <i class="fas fa-search"></i> Search
            </button>
        </div>

        <!-- Scrollable Table -->
        <div style="max-height: 400px; overflow-y: auto; border: 1px solid #e3e6f0; border-radius: 0.35rem;">
            <table class="table">
                <thead>
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Role</th>
                </tr>
                </thead>
                <tbody id="userTable">
                <%
                    UserBO userBO = (UserBO) BOFactory.getBoFactory().getBO(BOFactory.BOTypes.USER);
                    List<UserDTO> users = userBO.getAllUsers();
                    for (UserDTO user : users) {
                %>
                <tr onclick="selectUser('<%= user.getUsername() %>', '<%= user.getPassword() %>', '<%= user.getRole() %>')">
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getPassword() %></td>
                    <td><%= user.getRole() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    let rowIndex = null;

    function checkValidation(username, password, role) {
        if (!/^[a-zA-Z0-9_]{4,20}$/.test(username)) {
            alert('Please enter a valid username (4-20 characters, letters, numbers, and underscores only)!');
            return false;
        }
        if (!/^[a-zA-Z0-9!@#$%^&*]{6,20}$/.test(password)) {
            alert('Please enter a valid password (6-20 characters, letters, numbers, and special characters)!');
            return false;
        }
        if (!/^[a-zA-Z\s]{2,20}$/.test(role)) {
            alert('Please enter a valid role (e.g., Admin, Staff)!');
            return false;
        }
        return true;
    }

    function saveUser() {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        const role = document.getElementById('userRole').value;

        if (!checkValidation(username, password, role)) return;

        const user = { username, password, role };
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'http://localhost:8081/PahanaEduBillingSystem/UserModel', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'saved') {
                    alert('User Saved Successfully!');
                    window.location.reload();
                } else {
                    alert('Error saving user! Please check if the username already exists.');
                }
            }
        };
        xhr.send(JSON.stringify(user));
    }

    function selectUser(username, password, role) {
        console.log('Selecting user:', username, password, role);

        document.getElementById('username').value = username;
        document.getElementById('password').value = password;
        document.getElementById('userRole').value = role;

        document.getElementById('deleteWarning').style.display = 'none';

        const tableRows = document.getElementById('userTable').getElementsByTagName('tr');
        rowIndex = null;
        for (let i = 0; i < tableRows.length; i++) {
            if (tableRows[i].cells[0].innerText === username) {
                rowIndex = i;
                break;
            }
        }

        console.log('User selected, rowIndex:', rowIndex, 'User Name field value:', document.getElementById('username').value);
    }

    function updateUser() {
        if (rowIndex === null) {
            alert('Please select a user to update!');
            return;
        }
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        const role = document.getElementById('userRole').value;

        if (!checkValidation(username, password, role)) return;

        const user = { username, password, role };
        const xhr = new XMLHttpRequest();
        xhr.open('PUT', 'http://localhost:8081/PahanaEduBillingSystem/UserModel', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'updated') {
                    alert('User Updated Successfully!');
                    window.location.reload();
                } else {
                    alert('Error updating user!');
                }
            }
        };
        xhr.send(JSON.stringify(user));
    }

    function deleteUser() {
        // Block delete for non-admins at function level
        if ((window.CURRENT_USER_ROLE || '').toLowerCase() !== 'admin') {
            alert('You do not have permission to delete. Please contact an administrator.');
            return;
        }
        if (rowIndex === null) {
            alert('Please select a user to delete!');
            return;
        }

        const username = document.getElementById('username').value;

        if (!username || username.trim() === '') {
            alert('Please select a valid user to delete!');
            return;
        }

        if (!confirm('Are you sure you want to delete this user?\n\nNote: Users with associated activities cannot be deleted.')) {
            return;
        }

        console.log('Attempting to delete user with ID:', username);

        const xhr = new XMLHttpRequest();
        const url = 'http://localhost:8081/PahanaEduBillingSystem/UserModel?username=' + encodeURIComponent(username);
        console.log('DELETE URL:', url);

        xhr.open('DELETE', url, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                console.log('Response status:', xhr.status, 'Response text:', xhr.responseText);
                if (xhr.status === 200 && xhr.responseText === 'deleted') {
                    alert('User Deleted Successfully!');
                    window.location.reload();
                } else if (xhr.status === 200 && xhr.responseText === 'not deleted') {
                    document.getElementById('deleteWarning').style.display = 'block';
                    alert('Cannot delete user!\n\nThis user has associated activities. Please resolve all associated activities first before attempting to delete the user.');
                } else {
                    alert('Error deleting user! Status: ' + xhr.status);
                }
            }
        };
        xhr.send();
    }

    function resetForm() {
        document.getElementById('user-form').reset();
        document.getElementById('deleteWarning').style.display = 'none';
        rowIndex = null;
    }

    function searchUser() {
        const filter = document.getElementById('searchInput').value.toLowerCase();
        const table = document.getElementById('userTable');
        const rows = table.getElementsByTagName('tr');

        for (let i = 0; i < rows.length; i++) {
            const username = rows[i].cells[0].innerText.toLowerCase();
            if (username.includes(filter)) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }
    }

    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchUser();
        }
    });
</script>
</body>
</html>