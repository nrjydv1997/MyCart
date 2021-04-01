package com.learn.mycart.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.learn.mycart.dao.UserDao;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");  
        PrintWriter out=response.getWriter();
        
        try {
			
        	String email = request.getParameter("email");
        	String password = request.getParameter("password");
        	
        	//validation
        	
        	
        	//aurhenticating user
        	UserDao userDao = new UserDao(FactoryProvider.getFactory());
        	User user = userDao.getUserByEmailAndPassword(email, password);
        	
        	//out.println(user);
        	
        	HttpSession session = request.getSession();
        	
        	
        	if(user==null) {
        		out.println("<h1>Invalid details</h1>");
        		session.setAttribute("message", "Invalid details !! Try with another one..");
        		response.sendRedirect("login.jsp");
        		return;
        	}else {
        		out.println("<h1>Welcome " +user.getUserName() +"</h1>");
        		
        		session.setAttribute("current-user", user);
        		
        		if(user.getUserType().equals("admin")) {
        			response.sendRedirect("admin.jsp");
        		}else if (user.getUserType().equals("normal")) {
        			response.sendRedirect("normal.jsp");
        		}else {
        			out.println("<h1>We have not identified user type.</h1>");
        		}
        	}
        	
		} catch (Exception e) {
			e.printStackTrace();
		}
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
