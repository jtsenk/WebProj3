<%-- 
    Document   : Welcome
    Created on : Apr 4, 2018, 5:51:24 PM
    Author     : JTS
--%>

<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" import="project3.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <title>Welcome Page</title>
    </head>
    <body>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="Welcome.jsp">Project 3</a>
                </div>
                <ul class="nav navbar-nav">
                    <li class="active"><a href="Welcome.jsp">Welcome</a></li>
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
                    if (session.isNew() || (session.getAttribute("userBean") == null) || (((UserBean)session.getAttribute("userBean")).getUsername().equals("Guest"))) {
                        UserBean userBean = new UserBean();
                        session.setAttribute("userBean", userBean);
                        out.print("<h2>Welcome to Project 3, " + ((UserBean)session.getAttribute("userBean")).getUsername() + "!</h2>");
                        out.print("<h3>Please Login or Register as a new user to shop</h3>");
                        out.print("</div>");
                        out.print("<div class='row'>");
                        out.print("<div class='col-sm-4' align='center'><a href='Register.jsp' class='btn btn-primary btn-lg'>Register</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='Login.jsp' class='btn btn-primary btn-lg'>Login</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='#' class='btn btn-primary btn-lg disabled'>Log Out</a></div>");
                        out.print("</div>");
                    } else {
                        out.print("<h2>Welcome back to Project 3, " + ((UserBean)session.getAttribute("userBean")).getUsername() + "!</h2>");
                        out.print("<h3>Continue to Inventory below to start shopping</h3>");
                        out.print("</div>");
                        out.print("<div class='row'>");
                        out.print("<div class='col-sm-4' align='center'><a href='Inventory.jsp' class='btn btn-primary btn-lg'>Inventory</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='Cart.jsp' class='btn btn-primary btn-lg'>View Cart</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='Logout.jsp' class='btn btn-primary btn-lg'>Log Out</a></div>");
                        out.print("</div>");
                    }
                    
                    if (request.getParameter("message") != null) {
                        out.print("<div class='alert alert-info'>" + URLDecoder.decode(request.getParameter("message"), "utf-8") + "</div>");
                    }
                %>
        </div>      
    </body>
</html>