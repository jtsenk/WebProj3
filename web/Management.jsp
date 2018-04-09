<%-- 
    Document   : Management
    Created on : Apr 5, 2018, 10:14:10 AM
    Author     : JTS
--%>

<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="project3.*"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <title>Management</title>
    </head>
    <body>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="Welcome.jsp">Project 3</a>
                </div>
                 <ul class="nav navbar-nav">
                    <li><a href="Welcome.jsp">Welcome</a></li>
                    <li><a href="Register.jsp">Register</a></li>
                    <li><a href="Login.jsp">Login</a></li>
                    <li><a href="Inventory.jsp">Inventory</a></li>
                    <li><a href="Cart.jsp">View Cart</a></li>
                    <li><a href="Logout">Log Out</a></li>
                    <li class="active"><a href="Management.jsp">Management</a></li>
                </ul>
            </div>
        </nav>
        <br />
        <div class="container">
            <div class="jumbotron">
                <% 
                    if (session.isNew() || (session.getAttribute("userBean") == null) || (((UserBean)session.getAttribute("userBean")).getUsername().equals("Guest"))) {
                        out.print("<h2>Hi, " + ((UserBean)session.getAttribute("userBean")).getFirstName()   + ", you are not currently logged in</h2>");
                        out.print("<h3>Please Login or Register as a new user to shop</h3>");
                        out.print("</div>");
                        out.print("<div class='row'>");
                        out.print("<div class='col-sm-4' align='center'><a href='Register.jsp' class='btn btn-primary btn-lg'>Register</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='Login.jsp' class='btn btn-primary btn-lg'>Login</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='#' class='btn btn-primary btn-lg disabled'>Log Out</a></div>");
                        out.print("</div>");
                    } else if (((UserBean)session.getAttribute("userBean")).getPermissions()==1){
                        out.print("<h2>Management Page</h2>");
                        out.print("<h3>Logged in as: " + ((UserBean)session.getAttribute("userBean")).getUsername()   + "</h3>");
                        out.print("</div>");
                        if (request.getParameter("message") != null) {
                            out.print("<br /><div class='alert alert-info'>" + URLDecoder.decode(request.getParameter("message"), "utf-8") + "</div>");
                        }
                        out.print("<div class='well'>");
                        out.print("<h3>Current Inventory</h3>");
                            String sql = "SELECT * FROM Inventory";
                        try {
                            Connection conn = DriverManager.getConnection(DBManip.url);
                            PreparedStatement pstmt = conn.prepareStatement(sql);
                            ResultSet rs = pstmt.executeQuery();
                            out.print("<table class='table table-striped'>");
                                out.print("<thead><tr>");
                                    out.print("<th>Item ID</th>");
                                    out.print("<th>Name</th>");
                                    out.print("<th>Price</th>");
                                    out.print("<th>Qty</th>");
                                    out.print("<th>Description</th>");
                                out.print("</tr></thead>");
                            while(rs.next()) {
                                out.print("<tr>");
                                    out.print("<td>" + rs.getString("item_id") + "</td>");
                                    out.print("<td>" + rs.getString("name") + "</td>");
                                    out.print("<td>$" + rs.getString("price") + "</td>");
                                    out.print("<td>" + rs.getString("quantity") + "</td>");
                                    out.print("<td>" + rs.getString("description") + "</td>");
                                out.print("</tr>");
                            }
                           
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            out.print("</table>");
                            out.print("<h4>Adjust Item Quantity</h4>");
                            out.print("<form action='UpdateItem' method='GET'>");
                                    out.print("<div class='form-group'>");
                                        out.print("<label for='itemName'>Item: </label>");
                                        out.print("<select name='itemName' id='itemName' />");
                                                while(rs.next()) {
                                                    out.print("<option>" + rs.getString("name") + "</option>");
                                                }
                                        out.print("</select>");
                                    out.print("</div>");
                                    out.print("<div class='form-group'>");
                                        out.print("<label for='newQuantity'>Enter New Quantity</label>");
                                        out.print("<input type='text' name='newQuantity' id='newQuantity' />");
                                    out.print("</div>");
                                    out.print("<button type='submit' class='btn btn-default'>Update Quantity</button>");
                                out.print("</form>");
                            out.print("<br />"); 
                            out.print("<h4>Add Item to Inventory</h4>");
                            out.print("<form action='AddItem' method='GET'>");
                                    out.print("<div class='form-group'>");
                                        out.print("<label for='itemName'>Item Name:</label>");
                                        out.print("<input class='form-control' type='text' name='itemName' id='itemName' />");
                                    out.print("</div>");
                                    out.print("<div class='form-group'>");
                                        out.print("<label for='itemPrice'>Item Price:</label>");
                                        out.print("<input class='form-control' type='text' name='itemPrice' id='itemPrice' />");
                                    out.print("</div>");
                                      out.print("<div class='form-group'>");
                                        out.print("<label for='itemQuantity'>Item Quantity:</label>");
                                        out.print("<input class='form-control' type='text' name='itemQuantity' id='itemQuantity' />");
                                    out.print("</div>");
                                    out.print("<div class='form-group'>");
                                        out.print("<label for='itemDesc'>Item Description:</label>");
                                        out.print("<input class='form-control' type='text' name='itemDesc' id='itemDesc' />");
                                    out.print("</div>");
                                    out.print("<button type='submit' class='btn btn-default'>Add Item</button>");
                                out.print("</form>");
                            out.print("</div>");
                            conn.close();
                        } catch(Exception e){
                            System.out.println("Inventory get error: " + e.getMessage());
                        }
                        
                        out.print("<div class='well'>");
                        out.print("<h3>Transaction History</h3>");
                        sql = "SELECT * FROM Transactions";
                        try {
                            Connection conn = DriverManager.getConnection(DBManip.url);
                            PreparedStatement pstmt = conn.prepareStatement(sql);
                            ResultSet rs = pstmt.executeQuery();
                            out.print("<table class='table table-striped'>");
                                out.print("<thead><tr>");
                                    out.print("<th>Transaction ID</th>");
                                    out.print("<th>Date</th>");
                                    out.print("<th>User ID</th>");
                                    out.print("<th>Item ID</th>");
                                    out.print("<th>Quantity</th>");
                                out.print("</tr></thead>");
                            while(rs.next()) {
                                out.print("<tr>");
                                    out.print("<td>" + rs.getString("transaction_id") + "</td>");
                                    out.print("<td>" + rs.getString("date") + "</td>");
                                    out.print("<td>" + rs.getString("user_id") + "</td>");
                                    out.print("<td>" + rs.getString("item_id") + "</td>");
                                    out.print("<td>" + rs.getString("quantity") + "</td>");
                                out.print("</tr>");
                            }
                           
                            conn.close();
                            out.print("</table></div>");
                            
                        } catch(Exception e){
                            System.out.println("Transaction get error: " + e.getMessage());
                        }
                    }
                    else
                    {
                        response.sendRedirect("Welcome.jsp?message="+URLEncoder.encode("Unauthorized Access", "utf-8"));
                        return;
                    }
                %>
        </div>      
    </body>
</html>
