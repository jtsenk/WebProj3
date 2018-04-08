<%-- 
    Document   : ItemPage
    Created on : Apr 5, 2018, 10:14:27 AM
    Author     : JTS
--%>

<%@page import="java.net.URLDecoder"%>
<%@page import="project3.*"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <title>Item Page</title>
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
                    <li><a href="Logout.jsp">Log Out</a></li>
                    <li class="active"><a href="ItemPage.jsp">Item Page</a></li>
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
                    } else {
                        if(request.getParameter("id")!=null) {
                            String sql = "SELECT * FROM Inventory WHERE item_id=" + URLDecoder.decode(request.getParameter("id"), "utf-8");
                            try {
                                Connection conn = DriverManager.getConnection(DBManip.url);
                                PreparedStatement pstmt = conn.prepareStatement(sql);
                                ResultSet rs = pstmt.executeQuery();
                                out.print("<h2>Item: " + rs.getString("name") + "</h2>");
                                out.print("<h3>Logged in as: " + ((UserBean)session.getAttribute("userBean")).getUsername() + "</h3>");
                                out.print("</div>");
                                out.print("<div class='well'>");
                                out.print("<form action='AddToCart' method='GET'>");
                                    out.print("<div class='form-group'>");
                                        out.print("<label for='itemName'>Item: </label>");
                                        out.print("<select name='itemName' id='itemName' />");
                                                out.print("<option>" + rs.getString("name") + "</option>");
                                        out.print("</select>");
                                    out.print("</div>");
                                    out.print("<div class='form-group'>");
                                        out.print("<label for='itemQuantity'>Select Quantity for " + rs.getString("name") + ": </label>");
                                        out.print("<select name='itemQuantity' id='itemQuantity' />");
                                            for (int i=0; i<Integer.parseInt(rs.getString("quantity")); i++) {
                                                out.print("<option>" + (i+1) + "</option>");
                                            }
                                        out.print("</select>");
                                    out.print("</div>");
                                    out.print("<button type='submit' class='btn btn-default'>Add to Cart</button>");
                                out.print("</form>");
                                out.print("<br /><a href='Inventory.jsp' class='btn btn-default'>Cancel</a>");
                            out.print("</div>");
                            conn.close();
                            } catch(Exception e){
                                System.out.println("Invenotry get error: " + e.getMessage());
                            }
                        }
                        else
                        {
                            out.print("<div class='alert alert-danger'><strong>ERROR: </strong>No item ID specified</div>");
                        }
                    }
                %>
        </div>      
    </body>
</html>