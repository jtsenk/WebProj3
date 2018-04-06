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
@WebServlet(name = "ManagementLoginController", urlPatterns = {"/ManagementLoginController"})
public class ManagementLoginController extends HttpServlet {

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
                if(userBean.getPermissions()==1)
                {
                    response.sendRedirect("Management.jsp");
                }
                else
                {
                    response.sendRedirect("Index.jsp");
                }
            }
            else
            {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String permissions = DBManip.testLogin(username, password);
                if(!permissions.equals("x"))
                {
                   if (Integer.parseInt(permissions) == 1)
                   {
                       userBean = new UserBean(DBManip.userFind(username));
                       session.setAttribute("userBean", userBean);
                       response.sendRedirect("Management.jsp?message="+URLEncoder.encode("Successfully logged in", "utf-8"));
                   }
                }
                else
                {
                    response.sendRedirect("ManagementLogin.jsp?message="+URLEncoder.encode("Incorrect username and password", "utf-8"));
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
