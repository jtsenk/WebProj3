<%-- 
    Document   : Checkout
    Created on : Apr 5, 2018, 10:13:58 AM
    Author     : JTS
--%>

<%@page import="project3.UserBean"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <title>Checkout</title>
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
                </ul>
            </div>
        </nav>
        <br />
        <div class="container">
            <div class="jumbotron">
                <% 
                    if (session.isNew()) {
                        out.print("<h2>Welcome to Project 3, " + ((UserBean)session.getAttribute("userBean")).getUsername()   + "!</h2>");
                        out.print("<h3>Please Login or Register as a new user to shop</h3>");
                        out.print("</div>");
                        out.print("<div class='row'>");
                        out.print("<div class='col-sm-4' align='center'><a href='Register.jsp' class='btn btn-primary btn-lg'>Register</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='Login.jsp' class='btn btn-primary btn-lg'>Login</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='#' class='btn btn-primary btn-lg disabled'>Log Out</a></div>");
                        out.print("</div>");
                    } else {
                        out.print("<h2>Welcome back to Project 3, " + ((UserBean)session.getAttribute("userBean")).getFirstName()   + "!</h2>");
                        out.print("<h3>Continue to Inventory below to start shopping</h3>");
                        out.print("</div>");
                        out.print("<div class='row'>");
                        out.print("<div class='col-sm-4' align='center'><a href='Inventory.jsp' class='btn btn-primary btn-lg'>Inventory</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='Cart.jsp' class='btn btn-primary btn-lg'>View Cart</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='Logout.jsp' class='btn btn-primary btn-lg'>Log Out</a></div>");
                        out.print("</div>");
                    }
                %>
        </div>      
    </body>
</html>