<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 3:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <title>Pahana Edu Billing System - Login</title>
    <style>
        body {
            background-color: #f8f9fc;
            color: #333;
            line-height: 1.6;
            font-family: Arial, sans-serif;
            overflow-x: hidden;
            overflow-y: hidden;
        }
        .login-section {
            min-height: 100vh;
            padding: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 2.5rem;
            width: 100%;
            max-width: 450px;
        }
        .login-header {
            margin-bottom: 2rem;
            text-align: center;
        }
        .login-logo {
            height: 80px;
            margin-bottom: 1rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-control {
            height: 50px;
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 0 15px;
            width: 100%;
            transition: all 0.3s ease;
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
            border: 1px solid #ddd;
            border-right: none;
            padding: 0 10px;
            height: 50px;
            display: flex;
            align-items: center;
        }
        .btn {
            height: 50px;
            border-radius: 8px;
            background-color: #4e73df;
            color: white;
            border: none;
            font-weight: 600;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(78, 115, 223, 0.3);
        }
    
        /* Dark mode overrides */
        body.dark-mode {
            background-color: #121212;
            color: #e0e0e0;
        }
        .dark-mode .login-card {
            background: #1f1f1f;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
        }
        .dark-mode .form-control {
            background-color: #262626;
            color: #e0e0e0;
            border-color: #3a3a3a;
        }
        .dark-mode .form-control:focus {
            border-color: #4e73df;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
        }
        .dark-mode .input-group-text {
            background-color: #262626;
            border-color: #3a3a3a;
            color: #d0d0d0;
        }
        .dark-mode .btn:hover {
            box-shadow: 0 4px 15px rgba(78, 115, 223, 0.35);
        }
    </style>
</head>
<body>
<section class="login-section">
    <div class="login-card">
        <div class="login-header">
            <img src="frontend/assets/logo.png" alt="Logo" class="login-logo">
            <h2>Pahana Edu Billing</h2>
            <p style="color: #858796;">Sign in to your account</p>
        </div>
        <form id="login-form">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" class="form-control" id="username" placeholder="Enter username">
                </div>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control" id="password" placeholder="Enter password">
                </div>
            </div>
            <button type="button" class="btn" onclick="login()">Login</button>
        </form>
    </div>
</section>
<script>
    (function(){
        try {
            const savedTheme = localStorage.getItem('theme');
            if (savedTheme === 'dark') {
                document.body.classList.add('dark-mode');
            }
        } catch (e) {
        }
    })();
    function login() {
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        if (!username || !password) {
            alert('Please enter username and password!');
            return;
        }

        const user = { username, password };
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'http://localhost:8081/PahanaEduBillingSystem/AuthModel', true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200 && xhr.responseText === 'valid') {
                    window.location.href = 'dashboard.jsp';
                } else {
                    alert('Invalid username or password!');
                }
            }
        };
        xhr.send(JSON.stringify(user));
    }
</script>
</body>
</html>
