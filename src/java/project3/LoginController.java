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
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

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
            UserBean userBean = (UserBean) session.getAttribute("userBean");
            
            if(userBean==null){userBean = new UserBean();}
            
            if(userBean.isLoggedIn())
            {
                response.sendRedirect("Welcome.jsp?message="+URLEncoder.encode("Already logged in", "utf-8"));
                return;
            }
            else
            {
                String username = request.getParameter("username").trim();
                String password = request.getParameter("pw");
                String permissions = DBManip.testLogin(username, password);
                if(!permissions.equals("x"))
                {
                   userBean = new UserBean();
                   userBean.setUsername(username);
                   userBean.setPermissions(Integer.parseInt(permissions));
                   userBean.setLoggedIn(true);
                   session.setAttribute("userBean", userBean);
                   response.sendRedirect("Welcome.jsp?message="+URLEncoder.encode("Login Successful", "utf-8"));
                }
                else
                {
                    response.sendRedirect("Login.jsp?message="+URLEncoder.encode("Incorrect username and password", "utf-8"));
                    return;
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
