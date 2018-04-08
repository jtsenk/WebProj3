<%-- 
    Document   : Inventory
    Created on : Apr 5, 2018, 10:15:13 AM
    Author     : JTS
--%>

<%@page import="java.net.URLDecoder"%>
<%@page import="project3.*, java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <title>Inventory</title>
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
                    <li class="active"><a href="Inventory.jsp">Inventory</a></li>
                    <li><a href="Cart.jsp">View Cart</a></li>
                    <li><a href="Logout.jsp">Log Out</a></li>
                </ul>
            </div>
        </nav>
        <br />
        <div class="container">
            <div class="jumbotron">
                <% 
                    if (session.isNew() || (session.getAttribute("userBean") == null) || (((UserBean)session.getAttribute("userBean")).getUsername().equals("Guest"))) {
                        out.print("<h2>Hi, " + ((UserBean)session.getAttribute("userBean")).getUsername() + ", you are not currently logged in</h2>");
                        out.print("<h3>Please Login or Register as a new user to shop</h3>");
                        out.print("</div>");
                        out.print("<div class='row'>");
                        out.print("<div class='col-sm-4' align='center'><a href='Register.jsp' class='btn btn-primary btn-lg'>Register</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='Login.jsp' class='btn btn-primary btn-lg'>Login</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='#' class='btn btn-primary btn-lg disabled'>Log Out</a></div>");
                        out.print("</div>");
                    } else {
                        out.print("<h2>Inventory</h2>");
                        out.print("<h3>Logged in as: " + ((UserBean)session.getAttribute("userBean")).getUsername() + "</h3>");
                        out.print("</div>");
                        
                        if (request.getParameter("message") != null) {
                        out.print("<br /><div class='alert alert-info'>" + URLDecoder.decode(request.getParameter("message"), "utf-8") + "</div>");
                        }
                        
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
                                    out.print("<th>Add Item to Cart</th>");
                                out.print("</tr></thead>");
                            while(rs.next()) {
                                out.print("<tr>");
                                    out.print("<td>" + rs.getString("item_id") + "</td>");
                                    out.print("<td>" + rs.getString("name") + "</td>");
                                    out.print("<td>$" + rs.getString("price") + "</td>");
                                    out.print("<td>" + rs.getString("quantity") + "</td>");
                                    out.print("<td>" + rs.getString("description") + "</td>");
                                    out.print("<td><a href='ItemPage.jsp?id=" + rs.getString("item_id") + "' class='btn btn-primary btn-md'>Add to Cart</a></td>");
                                out.print("</tr>");
                            }
                            conn.close();
                            out.print("</table>");
			
                        } catch(Exception e){
                            System.out.println("Inventory get error: " + e.getMessage());
                        }
                        
                        
                    }
                %>
        </div>      
    </body>
</html>