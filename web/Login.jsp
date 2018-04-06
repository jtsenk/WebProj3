<%-- 
    Document   : Login
    Created on : Apr 5, 2018, 9:27:57 AM
    Author     : JTS
--%>

<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"  import="project3.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <title>Login</title>
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
                    <li class="active"><a href="Login.jsp">Login</a></li>
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
                        out.print("<h2>Login</h2>");
                        out.print("<h3>Please enter Username and Password below</h3>");
                        out.print("</div>");
                        out.print("<div class='well'>");
                            out.print("<form action='LoginController' method='POST'>");
                                out.print("<div class='form-group'>");
                                    out.print("<label for='username'>Username:</label>");
                                    out.print("<input class='form-control' type='text' name='username' id='username' />");
                                out.print("</div>");
                                out.print("<div class='form-group'>");
                                    out.print("<label for='pw'>Password:</label>");
                                    out.print("<input class='form-control' type='password' name='pw' id='pw' />");
                                out.print("</div>");
                                out.print("<button type='submit' class='btn btn-default'>Submit</button>");
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
                    
                    if (URLDecoder.decode(request.getParameter("message"), "utf-8") != null) {
                        out.print("<div class='alert alert-danger'><strong>ERROR: </strong>" + URLDecoder.decode(request.getParameter("message"), "utf-8") + "</div>");
                    }

                %>
        </div>      
    </body>
</html>