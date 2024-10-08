
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<%
String email = (String) session.getAttribute("email");
String password = (String) session.getAttribute("password");

if (email == null || password == null) {
    RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
    request.setAttribute("error", "Logged Out");
    rd.forward(request, response);
} else {
    try {
        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/shopkeeper?user=postgres&password=root");
        PreparedStatement ps = con.prepareStatement("select * from users where user_email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            String dbPassword = rs.getString("user_password");
            if (password.equals(dbPassword)) {

%>
<!DOCTYPE html>
<html>
<head>
<title>Remove Data</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
}

.admin-container {
	max-width: 1200px;
	margin: 40px auto;
	padding: 20px;
	background-color: #fff;
	border: 1px solid #ddd;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.admin-header {
	background-color: #337ab7;
	color: #fff;
	padding: 30px 10px;
	text-align: center;
	border-bottom: 1px solid #337ab7;
	position: relative;
}

.admin-header h1 {
	margin-top: 0;
	font-size: 24px;
}

.logout-button {
	position: absolute;
	top: 10px;
	right: 10px;
	background-color: #e74c3c;
	color: #fff;
	padding: 10px 20px;
	border: none;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.logout-button:hover {
	background-color: #c0392b;
}

.data-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.data-table th, .data-table td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: left;
}

.data-table th {
	background-color: #337ab7;
	color: #fff;
}

.data-table tr:nth-child(even) {
	background-color: #f9f9f9;
}

.data-table tr:hover {
	background-color: #f2f2f2;
}

.remove-button {
	background-color: #e74c3c;
	color: #fff;
	padding: 10px 20px;
	border: none;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.remove-button:hover {
	background-color: #c0392b;
}

.admin-footer {
	background-color: #f0f0f0;
	padding: 10px;
	text-align: center;
	clear: both;
	border-top: 1px solid #ddd;
}

.admin-footer p {
	margin-bottom: 0;
	font-size: 14px;
}

.btn {
	padding: 10px 20px;
	border-radius: 10px;
	border: none;
	color: white;
	cursor: pointer;
	background-color: #4CAF50;
	width: 48%;
	font-size: 16px;
	margin: 10px;
}

.btn:hover {
	background-color: #3e8e41;
}
</style>
</head>
<body>
	<div class="admin-container">
		<div class="admin-header">
			<h1>Remove Data</h1>
			<p>This page allows you to remove data from the database.</p>
			<a href="logout" class="logout-button">Logout</a>
		</div>
		<table class="data-table">
			<tr>
				<th>ID</th>
				<th>Product Name</th>
				<th>Quantity/Size</th>
				<th>Price</th>
				<th>Product Image</th>
				<th>Remove</th>
			</tr>
			<tr>
				<td>1</td>
				<td>Apple iPhone 13</td>
				<td>64GB</td>
				<td>$999.99</td>
				<td><img src="https://example.com/iphone13.jpg" width="100"
					height="100"></td>
				<td><button class="remove-button">Remove</button></td>
			</tr>
			<tr>
				<td>2</td>
				<td>Samsung Galaxy S22</td>
				<td>128GB</td>
				<td>$899.99</td>
				<td><img src="https://example.com/galaxys22.jpg" width="100"
					height="100"></td>
				<td><button class="remove-button">Remove</button></td>
			</tr>
			<tr>
				<td>3</td>
				<td>Google Pixel 6</td>
				<td>256GB</td>
				<td>$799.99</td>
				<td><img src="https://example.com/pixel6.jpg" width="100"
					height="100"></td>
				<td><button class="remove-button">Remove</button></td>
			</tr>
		</table>


		<button class="btn" onclick="location.href='adminHome.jsp'"><%="<"%></button>
		<button class="btn" onclick="location.href='removeData.jsp'">&#10227;</button>

		<div class="admin-footer">
			<p>Made With ❤ &copy; 2024 GloceryNow</p>
		</div>
	</div>
</body>
</html>

<%
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
                request.setAttribute("error", "Invalid email or password");
                rd.forward(request, response);
            }
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
            request.setAttribute("error", "Invalid email or password");
            rd.forward(request, response);
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }
}
%>