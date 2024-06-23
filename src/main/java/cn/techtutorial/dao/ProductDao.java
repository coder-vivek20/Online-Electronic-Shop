package cn.techtutorial.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.model.*;

public class ProductDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	public ProductDao(Connection con) {
		super();
		this.con = con;
	}
	public List<String> getAllCategories() {
	    List<String> categories = new ArrayList<>();
	    try (Connection con = this.con) {
	        String query = "SELECT DISTINCT category FROM products";
	        try (PreparedStatement pst = con.prepareStatement(query);
	             ResultSet rs = pst.executeQuery()) {
	            while (rs.next()) {
	                categories.add(rs.getString("category"));
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return categories;
	}



	public List<Product> getProductsByCategory(String category) {
	    List<Product> products = new ArrayList<>();
	    try {
	        query = "SELECT * FROM products WHERE category = ?";
	        pst = this.con.prepareStatement(query);
	        pst.setString(1, category);
	        rs = pst.executeQuery();
	        while (rs.next()) {
	            Product row = new Product();
	            row.setId(rs.getInt("id"));
	            row.setName(rs.getString("name"));
	            row.setCategory(rs.getString("category"));
	            row.setPrice(rs.getDouble("price"));
	            row.setImage(rs.getString("image"));
	            products.add(row);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return products;
	}

	
	
	public List<Product> getAllProducts(){
		List<Product> products =new ArrayList<Product>();
		try {
			query="select * from products";
			pst=this.con.prepareStatement(query);
			rs=pst.executeQuery();
			while(rs.next())
			{
				Product row=new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
				row.setImage(rs.getString("image"));
				
			      products.add(row);
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return products;
				}
	public List<Cart> getCartProducts(ArrayList<Cart> cartList){
		List<Cart> products = new ArrayList<Cart>();
		
		try{
			if (cartList.size() > 0) {
                for (Cart item : cartList) {
                	query = "select * from products where id=?";
                	pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        Cart row = new Cart();
                        row.setId(rs.getInt("id"));
                        row.setName(rs.getString("name"));
                        row.setCategory(rs.getString("category"));
                        row.setPrice(rs.getDouble("price")*item.getQuantity());
                        row.setQuantity(item.getQuantity());
                        products.add(row);
                    }
                }
                }
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return products;
}
	public Product getSingleProduct(int id) {
		 Product row = null;
	        try {
	            query = "select * from products where id=? ";

	            pst = this.con.prepareStatement(query);
	            pst.setInt(1, id);
	            rs = pst.executeQuery();

	            while (rs.next()) {
	            	row = new Product();
	                row.setId(rs.getInt("id"));
	                row.setName(rs.getString("name"));
	                row.setCategory(rs.getString("category"));
	                row.setPrice(rs.getDouble("price"));
	                row.setImage(rs.getString("image"));
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            
	        }

	        return row;
	    }
	public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    query = "select price from products where id=?";
                    pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        sum+=rs.getDouble("price")*item.getQuantity();
                    }

                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return sum;
}

}
