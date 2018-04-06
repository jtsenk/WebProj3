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
 * @author stephen mottram
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession();
            UserBean userBean = (UserBean) session.getAttribute("userBean");
            if(userBean==null){userBean = new UserBean();}
                        
            if(userBean.isLoggedIn()) {
                response.sendRedirect("index.jsp?message="+URLEncoder.encode("Already logged in", "utf-8"));
            }
            else {
                String firstname = request.getParameter("firstName").trim();
                String lastname = request.getParameter("lastName").trim();
                String username = request.getParameter("username").trim();
                String password = request.getParameter("pw1").trim();
                String confirmPassword = request.getParameter("pw2").trim();
                
                if(firstname==null || firstname.isEmpty() || lastname==null || lastname.isEmpty() 
                        || username==null || username.isEmpty() || password==null || password.isEmpty() 
                        || confirmPassword==null || confirmPassword.isEmpty()) {
                    response.sendRedirect("Register.jsp?message="+URLEncoder.encode("Please fill out all fields", "utf-8"));
                }
                
                if(password.equals(confirmPassword)) {
                    if(password.matches("\\w{8,24}")) {
                        if(!DBManip.unameCheck(username)) { //TRUE means username is taken
                            DBManip.createUser(username, password, "0", firstname, lastname, 0);
                            response.sendRedirect("Index.jsp?message="+URLEncoder.encode("Registration successful", "utf-8"));
                        }
                        else {
                            response.sendRedirect("Register.jsp?message="+URLEncoder.encode("Username is already taken", "utf-8"));
                        }
                    }
                    else {
                        response.sendRedirect("Register.jsp?message="+URLEncoder.encode("Password must be between 8 and 24 characters", "utf-8"));
                    }
                }
                else {
                    response.sendRedirect("Register.jsp?message="+URLEncoder.encode("Passwords don't match", "utf-8"));
                }
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
