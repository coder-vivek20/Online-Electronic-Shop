package cn.techtutorial.dao;
import java.sql.*;

import cn.techtutorial.model.User;
public class UserDao {
private Connection con;
private String query;
private PreparedStatement pst;
private ResultSet rs;

public UserDao(Connection con) {
	this.con = con;
}
public boolean registerUser(String name, String email, String password, String address) {
    try {
        query = "INSERT INTO users (name, email, password, address) VALUES (?, ?, ?, ?)";
        pst = this.con.prepareStatement(query);
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, password);
        pst.setString(4, address);
        int rowsAffected = pst.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}


public User userLogin(String email,String password) {
	User user=null;
	
	try {
		query="select * from users where email=? and password=?";
		pst=this.con.prepareStatement(query);
		pst.setString(1, email);
		pst.setString(2, password);
		rs=pst.executeQuery();
		
		if(rs.next()) {
			user= new User();
			user.setId(rs.getInt("id"));
			user.setName(rs.getString("name"));
			user.setEmail(rs.getString("email"));
			
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
		System.out.println(e.getMessage());
	}
	return user;
}

}
