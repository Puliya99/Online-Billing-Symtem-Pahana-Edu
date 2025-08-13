# 📚 Pahana Edu Billing System

![Java](https://img.shields.io/badge/Backend-Java%20EE-blue?style=for-the-badge&logo=java)
![MySQL](https://img.shields.io/badge/Database-MySQL-orange?style=for-the-badge&logo=mysql)
![License](https://img.shields.io/github/license/Puliya99/Online-Billing-Symtem-Pahana-Edu?style=for-the-badge)

---

## 🌐 Overview

**Pahana Edu Billing System** is a full-stack web application built for **Pahana Edu**, a bookstore in Colombo. It streamlines customer account management, inventory tracking, and billing operations.

The system is developed using **Java EE, MySQL, and JDBC**, following **MVC**, **DAO**, and **Singleton** design patterns to ensure modular, maintainable, and scalable architecture.

---

## 🚀 Features

- 🔐 **User Authentication** – Secure login with username and password
- 👤 **Customer Management** – Add, update, delete, and view customer details
- 📦 **Item Management** – Manage inventory (add, update, delete)
- 🧾 **Bill Generation** – Calculate and print bills based on units consumed
- 🆘 **Help Section** – Usage instructions for new users
- 🚪 **Logout** – Secure session termination
- 🖥 **Responsive UI** – Clean and intuitive UI using Bootstrap & SweetAlert2
- ✅ **Validation** – Input validation for customer and item data

---

## 🛠️ Technologies Used

| Layer         | Technology                          |
|---------------|--------------------------------------|
| **Backend**   | Java EE, JDBC, MySQL                 |
| **Frontend**  | HTML, CSS, Bootstrap, JavaScript, jQuery |
| **Patterns**  | MVC, DAO, Singleton                  |
| **Testing**   | JUnit (backend), Selenium (frontend) |
| **Server**    | Apache Tomcat                        |
| **Versioning**| Git, GitHub                          |

---

## 📂 Project Structure

```
PahanaEduBillingSystem/
├── backend/              # ⚙️ Java backend logic
│   ├── controller/       # 🎯 Servlet controllers (e.g., CustomerController.java)
│   ├── db/               # 🗄 DAO classes and DB connection (e.g., DBConnection.java)
│   ├── dto/              # 📦 Data Transfer Objects (e.g., CustomerDTO.java)
│   └── util/             # 🛠 Utility classes (e.g., CrudUtil.java)
│
├── frontend/             # 🎨 Frontend static files
│   ├── assets/           # 📁 CSS, JS
│   ├── model/            # 🧩 JavaScript models
│   ├── controller/       # 🎛 JS Controllers
│   └── index.html        # 🏠 Main frontend HTML
│
├── webapp/               # 🌍 Deployment files
│   ├── META-INF/         # ⚙️ Application context (context.xml)
│   └── WEB-INF/          # 🔧 Servlet config (web.xml)
```

---

## 🧪 Testing

- ✅ **JUnit**: For unit testing DTOs and backend logic
- ✅ **Selenium**: For automated UI testing (login, bill generation)

### 🧾 Sample Test Data

| Entity   | Sample Data |
|----------|-------------|
| Customer | `C001`, Nimal, Colombo, `0712345678`, `100` |
| Item     | `I001`, Book, `500`, `10` |
| Bill     | `B001`, `C001`, `10000`, `2025-07-25` |

---

## 🧰 Installation Guide

### 🔁 Clone the Repository

```bash
git clone https://github.com/Puliya99/Online-Billing-Symtem-Pahana-Edu.git
cd PahanaEduBillingSystem
```

### 🛢️ Setup MySQL Database

```sql
CREATE DATABASE PahanaEduBillingSystem;
USE PahanaEduBillingSystem;

CREATE TABLE users (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'User')
);

CREATE TABLE customers (
    account_no VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    telephone VARCHAR(15),
    units_consumed INT
);

CREATE TABLE items (
    item_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    price DOUBLE,
    qty INT
);

CREATE TABLE vendor (
    grn_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    item_id VARCHAR(10),
    description VARCHAR(255),
    qty INT,
    buying_price DOUBLE,
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

CREATE TABLE bills (
    bill_id VARCHAR(10) PRIMARY KEY,
    account_no VARCHAR(10),
    item_id VARCHAR(10),
    qty INT,
    unit_price DOUBLE,
    discount INT,
    total_amount DOUBLE,
    bill_date DATE,
    FOREIGN KEY (account_no) REFERENCES customers(account_no),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);
```

### ⚙️ Configure Database Connection

Edit `webapp/META-INF/context.xml` with your MySQL credentials:

```xml
<Resource name="jdbc/pahana_edu" auth="Container" type="javax.sql.DataSource"
          maxTotal="10" maxIdle="8" maxWaitMillis="-1"
          username="root" password="your_password"
          driverClassName="com.mysql.cj.jdbc.Driver"
          url="jdbc:mysql://localhost:3306/PahanaEduBillingSystem"/>
```

### 🚀 Deploy to Apache Tomcat

1. Copy the project folder to the `webapps/` directory
2. Start the Tomcat server:

```bash
./startup.sh   # Linux / Mac
startup.bat    # Windows
```

3. Access the application at:
   ```
   http://localhost:8080/PahanaEduBillingSystem
   ```

---

## 🔓 Default Login

```text
Username: admin
Password: admin123
```

---

## 🎯 UML Diagrams

- 📌 **Use Case Diagram**: Admin → Login, Manage Customers, Generate Bills, etc.
- 📌 **Class Diagram**: Relationships between DTOs, DAO, Controllers
- 📌 **Sequence Diagram**: Flows for login, customer CRUD, bill generation

*(Available in `/docs/` folder or included in the project report)*

---

## 🔄 Version Control

- 📍 **Repository**: [GitHub Link](https://github.com/Puliya99/Online-Billing-Symtem-Pahana-Edu)
- 🌿 **Branch**: `main`
- 📝 **Commits**: Descriptive and incremental (e.g., "Add CustomerController.java")

---

## 🤝 Contributing

```bash
# Clone and contribute
git checkout -b feature/your-feature
# Make changes
git commit -m "Add your feature"
git push origin feature/your-feature
```

Then open a **Pull Request** 💬

---

## 🧾 License

This project is licensed under the **MIT License**

---

## 📬 Contact

📧 **Email**: [st20343553@outlook.cardiffmet.ac.uk](mailto:st20343553@outlook.cardiffmet.ac.uk)

> ✨ _“Built for better education management — fast, secure, and user-friendly.”_
