# 📚 Pahana Edu Billing System

![Java](https://img.shields.io/badge/Backend-Java%20EE-blue?style=for-the-badge&logo=java)
![MySQL](https://img.shields.io/badge/Database-MySQL-orange?style=for-the-badge&logo=mysql)
![License](https://img.shields.io/github/license/Puliya99/Online-Billing-Symtem-Pahana-Edu?style=for-the-badge)

---

## 🌐 Overview

**Pahana Edu Billing System** is a full-stack Java web application for **Pahana Edu**, a bookstore in Colombo, providing customer management, inventory, vendor GRNs, and billing with real-time stock tracking.

Recent updates bring a business-focused dashboard (Sales, Cost of Sales, Gross Profit cards for Today/Week/Month/Year), an “Items Sold” line chart, a Sri Lanka local-time greeting, dark mode, improved billing UX (date picker, read-only bill items modal), vendor GRN date + export, and stock/consumption consistency across bill/cart/vendor operations.

Built with **Java EE (JSP/Servlets)**, **MySQL (JDBC)**, and **layered** patterns for maintainability and scalability.

---

## 🚀 Features

- 🔐 User Authentication and role awareness
- 👤 Customer Management (CRUD) with unitsConsumed tracking
- 📦 Item Management (CRUD) with automatic stock adjustments
- 🧾 Billing
  - Bill Date picker
  - Add-to-cart with stock validation against available item qty
  - Read-only View (👁️) modal to inspect bill’s cart items
  - Print, Edit, Delete; updates cascade to stock and customer units
- 🛒 Carts & Cart Items persisted server-side
- 🚚 Vendor GRNs
  - GRN Date field (date picker)
  - Table date filter
  - CSV export including grn_date
  - Vendor save/update/delete adjusts item quantities (with clamps to prevent negatives)
- 📊 Dashboard
  - Sales, Cost of Sales, Gross Profit cards for today/week/month/year
  - Items Sold line chart (Chart.js) with horizontal scroll
  - Sri Lanka local-time greeting to the signed-in user
- 🌙 Dark Mode with chart + UI theming
- 💡 Built-in Tips panel highlighting new features

---

## 🛠️ Technologies Used

| Layer         | Technology                                                          |
|---------------|---------------------------------------------------------------------|
| Backend       | Java EE (JSP/Servlets), JDBC, MySQL, Jackson (JSON), SLF4J (logging) |
| Frontend      | JSP, HTML, CSS, Vanilla JavaScript, Font Awesome, Chart.js          |
| Patterns      | Layered, Singleton                       |
| Build/Server  | Maven, Apache Tomcat                                                |
| Testing       | JUnit (backend)                                                     |
| Versioning    | Git, GitHub                                                         |

---

## 📂 Project Structure

Maven layout (key folders only):

```
PahanaEduBillingSystem/
├── pom.xml
└── src/
    ├── main/
    │   ├── java/
    │   │   └── com/example/pahanaedubillingsystem/backend/
    │   │       ├── controller/      # Servlets (e.g., BillController, VendorExportController)
    │   │       ├── bo/              # Business layer (interfaces + impl)
    │   │       ├── dao/             # DAO interfaces/impl + SQLUtil/DBConnection
    │   │       ├── dto/             # Data Transfer Objects
    │   │       └── entity/          # Entities
    │   └── webapp/
    │       ├── META-INF/            # context.xml (DataSource)
    │       ├── WEB-INF/             # web.xml
    │       ├── dashboard.jsp        # Dashboard with charts/cards
    │       ├── bill.jsp             # Billing page (date picker, view modal)
    │       ├── vendor.jsp           # Vendor GRN (GRN date + filters)
    │       ├── customer.jsp, item.jsp, user.jsp
    │       └── nav.jsp              # Navigation, Dark Mode, Tips, etc.
    └── test/
        └── java/                    # JUnit tests (if any)
```

---

## 🧪 Testing

- ✅ **JUnit**: DTOs and backend logic

### 🧾 Sample Test Data

- Customers
  - C001, Nimal, Colombo, 0712345678, units_consumed=100
  - C002, Lesandul, Galle, 0771234567, units_consumed=0
- Items
  - I001, “Anils Ghost”, price=1000.00, qty=50
  - I002, “Maths Book”, price=750.00, qty=25
- Vendors (GRNs)
  - G010, 2025-08-16, name=ABC Traders, item_id=I001, qty=10, buying_price=500.00
  - G011, 2025-08-16, name=XYZ Publishers, item_id=I002, qty=20, buying_price=1000.00
- Carts & Cart Items
  - CART013 with I001 qty=20 unit_price=1000.00 line_total=20000.00
- Bills
  - B005, bill_date=2025-08-16, account_no=C002, cart_id=CART013, discount=0, total_amount=20000.00

Use these as a starting point; adjust to your environment.

---

## 🧰 Installation Guide

### 🔁 Clone the Repository

```bash
git clone https://github.com/Puliya99/Online-Billing-Symtem-Pahana-Edu.git
cd PahanaEduBillingSystem
```

### 🛢️ Setup MySQL Database

```sql
CREATE DATABASE IF NOT EXISTS PahanaEduBillingSystem;
USE PahanaEduBillingSystem;

-- Users
CREATE TABLE IF NOT EXISTS users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    email    VARCHAR(255),
    role     VARCHAR(20) -- e.g., 'admin' or 'user'
);

-- Customers
CREATE TABLE IF NOT EXISTS customers (
    account_no      VARCHAR(10) PRIMARY KEY,
    name            VARCHAR(100),
    address         VARCHAR(255),
    telephone       VARCHAR(15),
    units_consumed  INT DEFAULT 0
);

-- Items
CREATE TABLE IF NOT EXISTS items (
    item_id VARCHAR(10) PRIMARY KEY,
    name    VARCHAR(100),
    price   DOUBLE,
    qty     INT DEFAULT 0
);

-- Vendors (GRN)
CREATE TABLE IF NOT EXISTS vendors (
    grn_id       VARCHAR(10) PRIMARY KEY,
    grn_date     DATE,
    name         VARCHAR(100),
    item_id      VARCHAR(10),
    description  VARCHAR(255),
    qty          INT,
    buying_price DOUBLE,
    CONSTRAINT fk_vendors_item FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Carts and Cart Items
CREATE TABLE IF NOT EXISTS carts (
    cart_id     VARCHAR(10) PRIMARY KEY,
    description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS cart_items (
    cart_id     VARCHAR(10) NOT NULL,
    item_id     VARCHAR(10) NOT NULL,
    qty         INT NOT NULL,
    unit_price  DOUBLE NOT NULL,
    line_total  DOUBLE NOT NULL,
    PRIMARY KEY (cart_id, item_id),
    CONSTRAINT fk_cart_items_cart FOREIGN KEY (cart_id) REFERENCES carts(cart_id),
    CONSTRAINT fk_cart_items_item FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Bills (header-level; lines come from cart_items via cart_id)
CREATE TABLE IF NOT EXISTS bills (
    bill_id      VARCHAR(10) PRIMARY KEY,
    account_no   VARCHAR(10),
    cart_id      VARCHAR(10),
    discount     INT,
    total_amount DOUBLE,
    bill_date    DATE,
    CONSTRAINT fk_bills_customer FOREIGN KEY (account_no) REFERENCES customers(account_no),
    CONSTRAINT fk_bills_cart FOREIGN KEY (cart_id) REFERENCES carts(cart_id)
);
```

### ⚙️ Configure Database Connection

Edit `src/main/webapp/META-INF/context.xml` with your MySQL credentials:

```xml
<Resource name="jdbc/pahana_edu" auth="Container" type="javax.sql.DataSource"
          maxTotal="10" maxIdle="8" maxWaitMillis="-1"
          username="root" password="your_password"
          driverClassName="com.mysql.cj.jdbc.Driver"
          url="jdbc:mysql://localhost:3306/PahanaEduBillingSystem"/>
```

### 🚀 Run / Deploy

Prerequisites:
- Java 11 (JDK 11)
- Maven 3.8+
- Apache Tomcat 9.x (javax servlet)

Build the WAR:
- Run: `mvn clean package -DskipTests`
- Output: `target/PahanaEduBillingSystem-1.0-SNAPSHOT.war`

Deploy to Tomcat (standalone):
- Copy the WAR to `$TOMCAT_HOME/webapps/`
  - Or use Tomcat Manager App to deploy the WAR
- Start Tomcat:
  - Linux/Mac: `$TOMCAT_HOME/bin/startup.sh`
  - Windows: `%TOMCAT_HOME%\bin\startup.bat`
- Access the app:
  - Default: `http://localhost:8080/PahanaEduBillingSystem/login.jsp`
  - If your Tomcat is configured to 8081: `http://localhost:8081/PahanaEduBillingSystem/login.jsp`

Run from IDE (IntelliJ IDEA/Eclipse):
- Configure a Tomcat 9 server with JDK 11
- Add artifact: "PahanaEduBillingSystem: war exploded"
- Set application context: `/PahanaEduBillingSystem`
- Run the server and open the URL as above

Notes:
- Ensure `src/main/webapp/META-INF/context.xml` has correct DB credentials (see section above)

---

## 🔓 Default Login

```text
Username: admin
Password: admin123
```

---

## 🎯 UML Diagrams

- Use Case Diagram: https://drive.google.com/file/d/1_Oj-9n_ml0gXQaQhWOV6w4XZYQxX-StE/view?usp=sharing
- Class Diagram: https://drive.google.com/file/d/19O7kZw0kIejuqp-7bD3ddlAJCU7pNeg2/view?usp=sharing
- Sequence Diagram: https://app.eraser.io/workspace/g1WFMfvpHRdA7CuR59Y4?origin=share

Note: Viewing permission is not required to access links. Only viewing and commenting is possible.

---

## 🔄 Version Control

- 📍 Repository: https://github.com/Puliya99/Online-Billing-Symtem-Pahana-Edu
- 🌿 Branching: `main` for stable; feature branches `dev, bill-management, user-auth-module, vendor-management, customer-management, item-management` for changes
- 📝 Commits: Conventional, descriptive (e.g., `feat(dashboard): add gross profit cards` or `fix(bill): clamp negative stock`)
- 🔁 PRs: Use Pull Requests for code reviews and CI integration

---

## 🤝 Contributing

```bash
# Create a dev branch
git checkout -b dev/your-feature
# Commit your changes
git commit -m "feat: add your feature"
# Push and open a PR
git push origin dev/your-feature
```

---

## 🧾 License

This project is licensed under the **MIT License**.

---

## 📬 Contact

📧 **Email**: [st20343553@outlook.cardiffmet.ac.uk](mailto:st20343553@outlook.cardiffmet.ac.uk)

> ✨ _“Built for better education management — fast, secure, and user-friendly.”_

---

## 📎 Additional Resources

- UI Interface – https://drive.google.com/drive/folders/1dwDx3gMoqZl113xNgCl4usoeoOA4i3fK?usp=drive_link
- Test Resources– https://drive.google.com/drive/folders/1sU5tvjM8pKmjypa-Zp9MhqO2gGf-PsRF?usp=drive_link
- Video – https://drive.google.com/drive/folders/1O_41OTMnAN2aKIoIAYZZJKDsLUl3W1Nv?usp=drive_link
