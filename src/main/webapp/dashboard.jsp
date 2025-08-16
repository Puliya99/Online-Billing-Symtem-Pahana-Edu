<%--
  Created by IntelliJ IDEA.
  User: lmarcho
  Date: 8/8/25
  Time: 3:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Date, com.example.pahanaedubillingsystem.backend.dto.CustomerDTO, com.example.pahanaedubillingsystem.backend.dto.ItemDTO, com.example.pahanaedubillingsystem.backend.dto.BillDTO, com.example.pahanaedubillingsystem.backend.bo.BOFactory, com.example.pahanaedubillingsystem.backend.bo.custom.CustomerBO, com.example.pahanaedubillingsystem.backend.bo.custom.ItemBO, com.example.pahanaedubillingsystem.backend.bo.custom.BillBO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.bo.custom.VendorBO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.dto.VendorDTO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.bo.custom.UserBO" %>
<%@ page import="com.example.pahanaedubillingsystem.backend.dto.UserDTO" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.temporal.TemporalAdjusters" %>
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
        .stat-card.today { border-left-color: #4e73df; }
        .stat-card.week { border-left-color: #36b9cc; }
        .stat-card.month { border-left-color: #f6c23e; }
        .stat-card.year { border-left-color: #e74a3b; }
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
        .stat-card.today .stat-icon { background-color: #4e73df; }
        .stat-card.week .stat-icon { background-color: #36b9cc; }
        .stat-card.month .stat-icon { background-color: #f6c23e; }
        .stat-card.year .stat-icon { background-color: #e74a3b; }
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
                <p>GRN</p>
            </div>
        </div>
        <div class="stat-card bills">
            <div class="stat-icon"><i class="fas fa-file-invoice-dollar"></i></div>
            <div class="stat-info">
                <h3><%= bills.size() %></h3>
                <p>Bills</p>
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

    <div class="section-header">
        <h2><i class="fas fa-coins"></i> Sales</h2>
        <p>Sum of Bill Total Amounts over selected periods</p>
    </div>
    <div class="stats-row">
        <%
            java.util.function.Function<Date, LocalDate> toLocalSales = (Date d) -> {
                if (d == null) return null;
                return Instant.ofEpochMilli(d.getTime()).atZone(ZoneId.systemDefault()).toLocalDate();
            };

            LocalDate todayS = LocalDate.now(ZoneId.systemDefault());
            LocalDate startOfWeekS = todayS.with(java.time.DayOfWeek.MONDAY);
            LocalDate endOfWeekS = startOfWeekS.plusDays(6);
            LocalDate startOfMonthS = todayS.with(TemporalAdjusters.firstDayOfMonth());
            LocalDate endOfMonthS = todayS.with(TemporalAdjusters.lastDayOfMonth());
            LocalDate startOfYearS = todayS.with(TemporalAdjusters.firstDayOfYear());
            LocalDate endOfYearS = todayS.with(TemporalAdjusters.lastDayOfYear());

            double salToday = 0.0;
            double salWeek = 0.0;
            double salMonth = 0.0;
            double salYear = 0.0;

            for (BillDTO b : bills) {
                Date bd = b.getBillDate();
                LocalDate ld = toLocalSales.apply(bd);
                if (ld == null) continue;
                double amt = b.getTotalAmount();
                if (ld.isEqual(todayS)) salToday += amt;
                if ((ld.isEqual(startOfWeekS) || ld.isAfter(startOfWeekS)) && (ld.isEqual(endOfWeekS) || ld.isBefore(endOfWeekS))) salWeek += amt;
                if ((ld.isEqual(startOfMonthS) || ld.isAfter(startOfMonthS)) && (ld.isEqual(endOfMonthS) || ld.isBefore(endOfMonthS))) salMonth += amt;
                if ((ld.isEqual(startOfYearS) || ld.isAfter(startOfYearS)) && (ld.isEqual(endOfYearS) || ld.isBefore(endOfYearS))) salYear += amt;
            }

            String sToday = String.format("Rs. %.2f", salToday);
            String sWeek = String.format("Rs. %.2f", salWeek);
            String sMonth = String.format("Rs. %.2f", salMonth);
            String sYear = String.format("Rs. %.2f", salYear);
        %>
        <div class="stat-card today">
            <div class="stat-icon"><i class="far fa-calendar-day"></i></div>
            <div class="stat-info">
                <h3><%= sToday %></h3>
                <p>Today</p>
            </div>
        </div>
        <div class="stat-card week">
            <div class="stat-icon"><i class="far fa-calendar"></i></div>
            <div class="stat-info">
                <h3><%= sWeek %></h3>
                <p>This Week</p>
            </div>
        </div>
        <div class="stat-card month">
            <div class="stat-icon"><i class="far fa-calendar-alt"></i></div>
            <div class="stat-info">
                <h3><%= sMonth %></h3>
                <p>This Month</p>
            </div>
        </div>
        <div class="stat-card year">
            <div class="stat-icon"><i class="far fa-calendar-check"></i></div>
            <div class="stat-info">
                <h3><%= sYear %></h3>
                <p>This Year</p>
            </div>
        </div>
    </div>

    <div class="section-header">
        <h2><i class="fas fa-chart-line"></i> Cost of Sales</h2>
        <p>Sum of GRN Qty × Buying Price over selected periods</p>
    </div>
    <div class="stats-row">
        <%
            java.util.function.Function<Date, LocalDate> toLocal = (Date d) -> {
                if (d == null) return null;
                return Instant.ofEpochMilli(d.getTime()).atZone(ZoneId.systemDefault()).toLocalDate();
            };

            LocalDate today = LocalDate.now(ZoneId.systemDefault());
            LocalDate startOfWeek = today.with(java.time.DayOfWeek.MONDAY);
            LocalDate endOfWeek = startOfWeek.plusDays(6);
            LocalDate startOfMonth = today.with(TemporalAdjusters.firstDayOfMonth());
            LocalDate endOfMonth = today.with(TemporalAdjusters.lastDayOfMonth());
            LocalDate startOfYear = today.with(TemporalAdjusters.firstDayOfYear());
            LocalDate endOfYear = today.with(TemporalAdjusters.lastDayOfYear());

            double cosToday = 0.0;
            double cosWeek = 0.0;
            double cosMonth = 0.0;
            double cosYear = 0.0;

            for (VendorDTO v : vendors) {
                Date gd = v.getGrnDate();
                LocalDate ld = toLocal.apply(gd);
                if (ld == null) continue;
                double line = (double) v.getQty() * v.getBuyingPrice();
                if (ld.isEqual(today)) cosToday += line;
                if ((ld.isEqual(startOfWeek) || ld.isAfter(startOfWeek)) && (ld.isEqual(endOfWeek) || ld.isBefore(endOfWeek))) cosWeek += line;
                if ((ld.isEqual(startOfMonth) || ld.isAfter(startOfMonth)) && (ld.isEqual(endOfMonth) || ld.isBefore(endOfMonth))) cosMonth += line;
                if ((ld.isEqual(startOfYear) || ld.isAfter(startOfYear)) && (ld.isEqual(endOfYear) || ld.isBefore(endOfYear))) cosYear += line;
            }

            String fmtToday = String.format("Rs. %.2f", cosToday);
            String fmtWeek = String.format("Rs. %.2f", cosWeek);
            String fmtMonth = String.format("Rs. %.2f", cosMonth);
            String fmtYear = String.format("Rs. %.2f", cosYear);
        %>
        <div class="stat-card today">
            <div class="stat-icon"><i class="far fa-calendar-day"></i></div>
            <div class="stat-info">
                <h3><%= fmtToday %></h3>
                <p>Today</p>
            </div>
        </div>
        <div class="stat-card week">
            <div class="stat-icon"><i class="far fa-calendar"></i></div>
            <div class="stat-info">
                <h3><%= fmtWeek %></h3>
                <p>This Week</p>
            </div>
        </div>
        <div class="stat-card month">
            <div class="stat-icon"><i class="far fa-calendar-alt"></i></div>
            <div class="stat-info">
                <h3><%= fmtMonth %></h3>
                <p>This Month</p>
            </div>
        </div>
        <div class="stat-card year">
            <div class="stat-icon"><i class="far fa-calendar-check"></i></div>
            <div class="stat-info">
                <h3><%= fmtYear %></h3>
                <p>This Year</p>
            </div>
        </div>
    </div>

    <div class="section-header">
        <h2><i class="fas fa-hand-holding-usd"></i> Gross Profit</h2>
        <p>Gross Profit = Sales − Cost of Sales</p>
    </div>
    <div class="stats-row">
        <%
            java.util.function.Function<Date, LocalDate> toLocalGP = (Date d) -> {
                if (d == null) return null;
                return Instant.ofEpochMilli(d.getTime()).atZone(ZoneId.systemDefault()).toLocalDate();
            };

            LocalDate todayGP = LocalDate.now(ZoneId.systemDefault());
            LocalDate startOfWeekGP = todayGP.with(java.time.DayOfWeek.MONDAY);
            LocalDate endOfWeekGP = startOfWeekGP.plusDays(6);
            LocalDate startOfMonthGP = todayGP.with(TemporalAdjusters.firstDayOfMonth());
            LocalDate endOfMonthGP = todayGP.with(TemporalAdjusters.lastDayOfMonth());
            LocalDate startOfYearGP = todayGP.with(TemporalAdjusters.firstDayOfYear());
            LocalDate endOfYearGP = todayGP.with(TemporalAdjusters.lastDayOfYear());

            double salTodayGP = 0.0, salWeekGP = 0.0, salMonthGP = 0.0, salYearGP = 0.0;
            for (BillDTO b : bills) {
                LocalDate ld = toLocalGP.apply(b.getBillDate());
                if (ld == null) continue;
                double amt = b.getTotalAmount();
                if (ld.isEqual(todayGP)) salTodayGP += amt;
                if ((ld.isEqual(startOfWeekGP) || ld.isAfter(startOfWeekGP)) && (ld.isEqual(endOfWeekGP) || ld.isBefore(endOfWeekGP))) salWeekGP += amt;
                if ((ld.isEqual(startOfMonthGP) || ld.isAfter(startOfMonthGP)) && (ld.isEqual(endOfMonthGP) || ld.isBefore(endOfMonthGP))) salMonthGP += amt;
                if ((ld.isEqual(startOfYearGP) || ld.isAfter(startOfYearGP)) && (ld.isEqual(endOfYearGP) || ld.isBefore(endOfYearGP))) salYearGP += amt;
            }

            double cosTodayGP = 0.0, cosWeekGP = 0.0, cosMonthGP = 0.0, cosYearGP = 0.0;
            for (VendorDTO v : vendors) {
                LocalDate ld = toLocalGP.apply(v.getGrnDate());
                if (ld == null) continue;
                double line = (double) v.getQty() * v.getBuyingPrice();
                if (ld.isEqual(todayGP)) cosTodayGP += line;
                if ((ld.isEqual(startOfWeekGP) || ld.isAfter(startOfWeekGP)) && (ld.isEqual(endOfWeekGP) || ld.isBefore(endOfWeekGP))) cosWeekGP += line;
                if ((ld.isEqual(startOfMonthGP) || ld.isAfter(startOfMonthGP)) && (ld.isEqual(endOfMonthGP) || ld.isBefore(endOfMonthGP))) cosMonthGP += line;
                if ((ld.isEqual(startOfYearGP) || ld.isAfter(startOfYearGP)) && (ld.isEqual(endOfYearGP) || ld.isBefore(endOfYearGP))) cosYearGP += line;
            }

            double gpToday = salTodayGP - cosTodayGP;
            double gpWeek = salWeekGP - cosWeekGP;
            double gpMonth = salMonthGP - cosMonthGP;
            double gpYear = salYearGP - cosYearGP;

            String gpTodayS = String.format("Rs. %.2f", gpToday);
            String gpWeekS = String.format("Rs. %.2f", gpWeek);
            String gpMonthS = String.format("Rs. %.2f", gpMonth);
            String gpYearS = String.format("Rs. %.2f", gpYear);
        %>
        <div class="stat-card today">
            <div class="stat-icon"><i class="far fa-calendar-day"></i></div>
            <div class="stat-info">
                <h3><%= gpTodayS %></h3>
                <p>Today</p>
            </div>
        </div>
        <div class="stat-card week">
            <div class="stat-icon"><i class="far fa-calendar"></i></div>
            <div class="stat-info">
                <h3><%= gpWeekS %></h3>
                <p>This Week</p>
            </div>
        </div>
        <div class="stat-card month">
            <div class="stat-icon"><i class="far fa-calendar-alt"></i></div>
            <div class="stat-info">
                <h3><%= gpMonthS %></h3>
                <p>This Month</p>
            </div>
        </div>
        <div class="stat-card year">
            <div class="stat-icon"><i class="far fa-calendar-check"></i></div>
            <div class="stat-info">
                <h3><%= gpYearS %></h3>
                <p>This Year</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
