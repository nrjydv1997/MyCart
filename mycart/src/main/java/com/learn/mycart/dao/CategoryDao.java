package com.learn.mycart.dao;

import java.util.List;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.learn.mycart.entities.Category;

public class CategoryDao {

	private SessionFactory factory;

	public CategoryDao(SessionFactory factory) {
		super();
		this.factory = factory;
	}
	
	//save category to db
	public int saveCategory(Category cat) {
		 Session session = this.factory.openSession();
		 Transaction tx = session.beginTransaction();
		int catId = (Integer) session.save(cat);
		 tx.commit();
		 session.close();
		 
		 return catId;
	}
	
	public List<Category> getCategories(){
		Session session = this.factory.openSession();
		Query<Category>  query =  session.createQuery("from Category");
		List<Category> list = query.list();
		return list;
	}
	
	public Category getCategoryById(int catId) {
		Category category = null;
		try {
			Session session = this.factory.openSession();
			category = session.get(Category.class, catId);
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return category;
	}
	
}
