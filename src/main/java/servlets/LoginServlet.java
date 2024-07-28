package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DAO;
import com.dao.TaskDAO;

import models.Task;
import models.Users;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	DAO dao = new DAO();
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String Username = request.getParameter("username");
		String Password = request.getParameter("password");
		
//		Users login = new Users();
//		
//		login.setUsername(Username);
//		login.setPassword(Password);
		
		Users validate = dao.validate(Username , Password);
		try {
			if(("Admin").equals(validate.getRole())) {
				HttpSession session = request.getSession();
				session.setAttribute("Admin", validate);
//				session.setAttribute("user",login);
				request.setAttribute("Username", Username);
				
				
//				response.sendRedirect("AdminDashboard.jsp");
				request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
			}
			else if(("Associate").equals(validate.getRole())) {
				HttpSession session = request.getSession();
				session.setAttribute("Associate", validate);
				request.setAttribute("Username", Username);
				response.sendRedirect("AssociateDashboard.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

}
