package com.learn.mycart.servlets;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;



/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
			String userName = request.getParameter("user_name");
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			String userPhone = request.getParameter("user_phone");
			String userAddress = request.getParameter("user_address");
			String userPic = "default.jpg";
			String userType = "normal";
			//validation
			if(userName.isEmpty()) {
				out.println("Name is blank");
				return;
			}
			
			//creating user object to store data
		
		  User user =	new User( userName, userEmail, userPassword, userPhone, userPic, userAddress,userType);
		  
		 Session hibernateSession =  FactoryProvider.getFactory().openSession();
		 Transaction tx = hibernateSession.beginTransaction();
		 
		 int userId = (Integer) hibernateSession.save(user);
		
		 tx.commit();
		 hibernateSession.close();
		 
		HttpSession session= request.getSession();
		session.setAttribute("message", "Registration successfull !! User id is :  "+userId);
		response.sendRedirect("register.jsp");
		 return;
		 
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
