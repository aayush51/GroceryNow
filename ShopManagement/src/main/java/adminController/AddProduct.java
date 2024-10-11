package adminController;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Product;

@WebServlet("/addProduct")
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String productName = req.getParameter("productName");
			int quantity = Integer.parseInt(req.getParameter("quantity"));
			String quantityUnit = req.getParameter("quantity-unit");
			double price = Double.parseDouble(req.getParameter("price"));
			String category = req.getParameter("category");
			String productImage = req.getParameter("productImage");
			
			System.out.println(productName + " " + quantity + " " + quantityUnit + " " + price + " " + category + " " + productImage);
			
			RequestDispatcher rd = req.getRequestDispatcher("addData.jsp");
			
			if(productName.isEmpty() || productImage.isEmpty() || category.isEmpty() || Integer.toString(quantity).isBlank() || Double.toString(price).isBlank()) {
				req.setAttribute("error", "Please Fill The Fields");
			}
			else {
				if(quantity<0){
					req.setAttribute("error", "Enter Valid Quantity");
				}
				if(price<0){
					req.setAttribute("error", "Enter Valid Price");
				}
				if(productImage.indexOf(".")<0){
					req.setAttribute("error", "Enter Valid Product Image URL");
				}
			}
			
			try {
				HttpSession session = req.getSession();
				String email = (String)session.getAttribute("email");
				String password = (String)session.getAttribute("password");
				Class.forName("org.postgresql.Driver");
				Connection con = DriverManager
						.getConnection("jdbc:postgresql://localhost:5432/shopkeeper?user=postgres&password=root");
				PreparedStatement ps = con.prepareStatement("select * from users where user_email=?");
				ps.setString(1, email);
				ResultSet rs = ps.executeQuery();
				if (rs.next()) {
						String adminpass = rs.getString("user_password");
						if (adminpass.equals(password)) {
							EntityManagerFactory emf = Persistence.createEntityManagerFactory("shop");
							EntityManager em = emf.createEntityManager();
							EntityTransaction et = em.getTransaction();
							Product product = new Product();
							int id = 100 ;
							@SuppressWarnings("unchecked")
							List<Integer> ids = em.createQuery("select p.id from Product p").getResultList();
							for (Integer integer : ids) {
								if((int)integer==id) {
									id =(int)(Math.random() * 900) + 100 ;
									break;
								}
							}
								
							product.setId(id);
							product.setName(productName);
							product.setPrice(price);
							product.setQuantity(quantity);
							product.setQuantityUnit(quantityUnit);
							product.setCategory(category);
							product.setImage(productImage);
							et.begin();
							em.persist(product);
							et.commit();
							System.out.println("Data Saved !");
							req.setAttribute("operation", "Product Has Been Added !");
							
						} else {
							req.setAttribute("error", "Facing Problem While Inserting Data");
						}
					
				} else {
					req.setAttribute("error", "Facing Problem While Inserting Data");
				}
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
			rd.include(req, resp);
			
		}catch(

	Exception e)
	{
		e.printStackTrace();
//			RequestDispatcher rd = req.getRequestDispatcher("addData.jsp");
//			req.setAttribute("error", "Please Fill The Fields");
//			rd.include(req, resp);
	}

}}