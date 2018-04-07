<%-- 
    Document   : Register
    Created on : Apr 5, 2018, 10:14:52 AM
    Author     : JTS
--%>

<%@page import="java.net.URLDecoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="project3.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <title>Register User</title>
    </head>
    <body>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="Welcome.jsp">Project 3</a>
                </div>
                 <ul class="nav navbar-nav">
                    <li><a href="Welcome.jsp">Welcome</a></li>
                    <li class="active"><a href="Register.jsp">Register</a></li>
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
                        out.print("<h2>Register New User</h2>");
                        out.print("<h3>Please fill out the form below to register</h3>");
                        out.print("</div>");
                        out.print("<div class='well'>");
                            out.print("<form action='RegisterController' method='POST'>");
                                out.print("<div class='form-group'>");
                                    out.print("<label for='firstName'>First Name:</label>");
                                    out.print("<input class='form-control' type='text' name='firstName' id='firstName' />");
                                out.print("</div>");
                                out.print("<div class='form-group'>");
                                    out.print("<label for='lastName'>Last Name:</label>");
                                    out.print("<input class='form-control' type='text' name='lastName' id='lastName' />");
                                out.print("</div>");
                                out.print("<div class='form-group'>");
                                    out.print("<label for='username'>Username:</label>");
                                    out.print("<input class='form-control' type='text' name='username' id='username' />");
                                out.print("</div>");
                                out.print("<div class='form-group'>");
                                    out.print("<label for='pw1'>Password:</label>");
                                    out.print("<input class='form-control' type='password' name='pw1' id='pw1' />");
                                out.print("</div>");
                                out.print("<div class='form-group'>");
                                    out.print("<label for='pw2'>Verify Password:</label>");
                                    out.print("<input class='form-control' type='password' name='pw2' id='pw2' />");
                                out.print("</div>");
                                out.print("<button type='submit' class='btn btn-default'>Register</button>");
                            out.print("</form>");
                        out.print("</div>");
                    } else {
                        out.print("<h2>Currently Logged in as " + ((UserBean)session.getAttribute("userBean")).getUsername() + "</h2>");
                        out.print("<h3>Log out if you want to register a new user, or continue as " + ((UserBean)session.getAttribute("userBean")).getUsername() + "</h3>");
                        out.print("</div>");
                        out.print("<div class='row'>");
                        out.print("<div class='col-sm-4' align='center'><a href='Logout.jsp' class='btn btn-primary btn-lg'>Log Out</a></div>");
                        out.print("<div class='col-sm-4' align='center'><a href='Inventory.jsp' class='btn btn-primary btn-lg'>Continue to Inventory</a></div>");
                        out.print("<div class='col-sm-4' align='center'></div>");
                        out.print("</div>");
                    }
                    
                    if (request.getParameter("message") != null) {
                        out.print("<div class='alert alert-danger'><strong>ERROR: </strong>" + URLDecoder.decode(request.getParameter("message"), "utf-8") + "</div>");
                    }

                %>
        </div>      
    </body>
</html>