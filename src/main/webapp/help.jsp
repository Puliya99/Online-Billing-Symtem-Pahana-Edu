<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 5:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <title>Pahana Edu Billing System - Help</title>
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
    .card {
      background: white;
      border-radius: 0.35rem;
      box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
      padding: 1.5rem;
    }
    .help-content h4 {
      color: #5a5c69;
      font-weight: 700;
      margin-bottom: 1rem;
    }
    .accordion-item {
      margin-bottom: 1rem;
    }
    .accordion-button {
      background-color: #f8f9fc;
      border: 1px solid #e3e6f0;
      padding: 1rem;
      width: 100%;
      text-align: left;
      font-weight: 600;
      color: #5a5c69;
      cursor: pointer;
    }
    .accordion-button:hover {
      background-color: rgba(78, 115, 223, 0.1);
    }
    .accordion-content {
      display: none;
      padding: 1rem;
      border: 1px solid #e3e6f0;
      border-top: none;
    }
    .accordion-content.show {
      display: block;
    }
  </style>
</head>
<body>
<%@ include file="nav.jsp" %>
<div class="container">
  <div class="section-header">
    <h2><i class="fas fa-question-circle"></i> Help Center</h2>
    <p>Get assistance with using the system</p>
  </div>
  <div class="card">
    <div class="help-content">
      <h4>Welcome to Pahana Edu Billing System</h4>
      <p>This system allows you to manage customers, items, and bills efficiently. Below you'll find guidance on how to use each feature.</p>
      <div class="accordion">
        <div class="accordion-item">
          <button class="accordion-button" onclick="toggleAccordion(this)">Login System</button>
          <div class="accordion-content">
            <p>Use your username and password to access the system. Contact your administrator if you've forgotten your credentials.</p>
            <ul>
              <li>Username: Your assigned username (usually your email)</li>
              <li>Password: Case-sensitive password</li>
            </ul>
          </div>
        </div>
        <div class="accordion-item">
          <button class="accordion-button" onclick="toggleAccordion(this)">Customer Management</button>
          <div class="accordion-content">
            <p>Manage all your customer information in one place:</p>
            <ul>
              <li><strong>Add Customer</strong>: Fill in all fields and click Save</li>
              <li><strong>Edit Customer</strong>: Select a customer, make changes, and click Update</li>
              <li><strong>Delete Customer</strong>: Select a customer and click Delete</li>
            </ul>
          </div>
        </div>
        <div class="accordion-item">
          <button class="accordion-button" onclick="toggleAccordion(this)">Item Management</button>
          <div class="accordion-content">
            <p>Manage your inventory items:</p>
            <ul>
              <li><strong>Add Item</strong>: Fill in item details and click Save</li>
              <li><strong>Edit Item</strong>: Select an item, make changes, and click Update</li>
              <li><strong>Delete Item</strong>: Select an item and click Delete</li>
            </ul>
          </div>
        </div>
        <div class="accordion-item">
          <button class="accordion-button" onclick="toggleAccordion(this)">Billing System</button>
          <div class="accordion-content">
            <p>Generate and manage customer bills:</p>
            <ul>
              <li><strong>Select Customer</strong>: Choose from the dropdown to auto-fill details</li>
              <li><strong>Generate Bill</strong>: Click the button to create the bill</li>
              <li><strong>View History</strong>: See all previous bills in the table below</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
  function toggleAccordion(button) {
    const content = button.nextElementSibling;
    const isOpen = content.classList.contains('show');
    document.querySelectorAll('.accordion-content').forEach(item => item.classList.remove('show'));
    if (!isOpen) {
      content.classList.add('show');
    }
  }
</script>
</body>
</html>
