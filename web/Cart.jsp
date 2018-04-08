<%-- 
    Document   : Cart
    Created on : Apr 5, 2018, 10:15:33 AM
    Author     : JTS
--%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="project3.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <title>View Cart</title>
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
                    <li class="active"><a href="Cart.jsp">View Cart</a></li>
                    <li><a href="Logout.jsp">Log Out</a></li>
                </ul>
            </div>
        </nav>
        <br />
        <div class="container">
            <div class="jumbotron">
                <% 
                     if (request.getParameter("message") != null) {
                        out.print("<br /><div class='alert alert-info'>" + URLDecoder.decode(request.getParameter("message"), "utf-8") + "</div>");
                    }

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
                        out.print("<h2>Cart</h2>");
                        out.print("<h3>Logged in as: " + ((UserBean)session.getAttribute("userBean")).getUsername() + "</h3>");
                        out.print("</div>");
                        CartBean cartBean = (CartBean) session.getAttribute("cartBean");
                        out.print("<div class='well'>"); 
                        if(cartBean==null) {
                            System.out.println("cartBean is null");
                            cartBean = new CartBean();
                            out.print("Cart is Empty");
                            out.print("</div>");
                        } else {
                            ArrayList cart = cartBean.getCart();
                            out.print("<table class='table table-striped'>");
                                    out.print("<thead><tr>");
                                        out.print("<th>Item</th>");
                                        out.print("<th>Qty</th>");
                                        out.print("<th>Subtotal</th>");
                                        out.print("<th>Remove Item from Cart</th>");
                                    out.print("</tr></thead>");
                                    double grandTotal = 0.0;
                                    double subTotal = 0.0;
                                    DecimalFormat df = new DecimalFormat("#.00");
                                    for (int i=0; i<cart.size(); i++) {
                                        Item currItem = (Item)cart.get(i);
                                        String currName = currItem.getName();
                                        int currQty = currItem.getQuantity();
                                        String sql = "SELECT * FROM Inventory WHERE name=\'" + currName + "\'";
                                        try {
                                            Connection conn = DriverManager.getConnection(DBManip.url);
                                            PreparedStatement pstmt = conn.prepareStatement(sql);
                                            ResultSet rs = pstmt.executeQuery();
                                            out.print("<tr>");
                                                out.print("<td>" + rs.getString("name") + "</td>");
                                                out.print("<td>" + currQty + "</td>");
                                                subTotal = currQty*Double.parseDouble(rs.getString("price"));
                                                grandTotal += subTotal;
                                                out.print("<td>$" + df.format(subTotal) + "</td>");
                                                out.print("<td><a href='#' class='btn btn-primary btn-md'>Remove</a></td>");
                                            out.print("</tr>");
                                        } catch(Exception e){
                                            System.out.println("Cart get error: " + e.getMessage());
                                        }
                                    }
                                    out.print("</table></div>");
                                    out.print("<div class='well row'>");
                                    out.print("<div class='col-sm-6'><a href='CheckoutPage.jsp' class='btn btn-primary btn-lg'>Checkout</a></div>");
                                    out.print("<div class='col-sm-6'><h2>Grand Total: $" + df.format(grandTotal) + "</h2></div></div>");
                            }
                    }
                %>
        </div>      
    </body>
</html>