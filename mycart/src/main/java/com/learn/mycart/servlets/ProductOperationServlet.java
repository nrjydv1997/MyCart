package com.learn.mycart.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.helper.FactoryProvider;

/**
 * Servlet implementation class ProductOperationServlet
 */
@WebServlet("/ProductOperationServlet")
@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductOperationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String operation = request.getParameter("operation");
		
		if(operation.trim().equals("addcategory")) {
			
			//fetching add category data
			
			String title =  request.getParameter("catTitle");
			String description  = request.getParameter("catDescription");
			
			Category category = new Category();
			category.setCategoryTitle(title);
			category.setCategoryDescription(description);
			
			CategoryDao catDao= new CategoryDao(FactoryProvider.getFactory());
			int catId = catDao.saveCategory(category);
//			out.println("category saved" + catId);
			HttpSession session = request.getSession();
			session.setAttribute("message", "Category added successfully : "+catId);
			response.sendRedirect("admin.jsp");
			return;
		}
		else if (operation.trim().equals("addproduct")) {
			//fetching add product data
			
			String pName = request.getParameter("pName");
			String pDesc = request.getParameter("pDesc");
			int pPrice = Integer.parseInt(request.getParameter("pPrice"));
			int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
			int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
			int catId = Integer.parseInt(request.getParameter("catId"));
			
			Part part = request.getPart("pPic");
			
			Product p = new Product();
			p.setpName(pName);
			p.setpDesc(pDesc);
			p.setpPrice(pPrice);
			p.setpDiscount(pDiscount);
			p.setpQuantity(pQuantity);
			p.setpPhoto(part.getSubmittedFileName());
			
			
			//getCategory by id
			CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
			Category category = catDao.getCategoryById(catId);
			
			p.setCategory(category);
			
			//pic upload
			//find out the path to upload photo
			String path = request.getRealPath("img")+File.separator+"products"+File.separator+part.getSubmittedFileName();
			
			//uploading code
			try {
				FileOutputStream fos = new FileOutputStream(path);
				InputStream is = part.getInputStream();
				byte[] data = new byte[is.available()];
				is.read(data);
				
				//writing img data
				fos.write(data);
				fos.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//save product...
			ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
			boolean f = pDao.saveProduct(p);
			
			HttpSession session = request.getSession();
			
			if(true) {
				session.setAttribute("message", "Product added successfully");
				response.sendRedirect("admin.jsp");
				return;
			}
			
			
			
			
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
