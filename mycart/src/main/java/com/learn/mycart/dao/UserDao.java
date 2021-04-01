package com.learn.mycart.dao;


import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.learn.mycart.entities.User;

public class UserDao {

	private SessionFactory factory;

	public UserDao(SessionFactory factory) {
		super();
		this.factory = factory;
	}
	
	//Get user by email and password
	
	@SuppressWarnings("unchecked")
	public User getUserByEmailAndPassword(String email, String password) {
		
		User user=null;
		
		try {
			
			Session session = this.factory.openSession();
			Query<User> q =session.createQuery("from User where userEmail=:n and userPassword=:p");
		    q.setParameter("n", email);
			q.setParameter("p", password);
			
			 user=(User)q.uniqueResult();
			
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
}
