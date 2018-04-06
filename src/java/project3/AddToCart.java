/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package project3;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author stephen mottram
 */
@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession();
            CartBean cartBean = (CartBean) session.getAttribute("cartBean");
            UserBean userBean = (UserBean) session.getAttribute("userBean");
            
            if(cartBean==null) {cartBean = new CartBean();}
            if(userBean==null) {userBean = new UserBean();}
            
            if(!userBean.isLoggedIn())
            {
                response.sendRedirect("Inventory.jsp?message="+URLEncoder.encode("Please log in to add things to your cart", "utf-8"));
            }
            
            String itemName = request.getParameter("itemName");
            int itemQuantity = Integer.parseInt(request.getParameter("itemQuantity"));
            
            if (itemQuantity>0) {
                cartBean.addToCart(new Item(itemName, itemQuantity));
                session.setAttribute("cartBean", cartBean);
                response.sendRedirect("Inventory.jsp?message="+URLEncoder.encode("Item added to cart", "utf-8"));
            }
            else
            {
                response.sendRedirect("Inventory.jsp?message="+URLEncoder.encode("Please choose at least one item", "utf-8"));   
            }
        }
                
            
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
