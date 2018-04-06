package project3;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Users {
	private int id;
	private String uname;
	private String fname;
	private String lname;
	private int p;
	
	public Users(int n){
		id = n;
		String sql = "SELECT username,first_name,last_name,permissions From Users " + "WHERE user_id = ?";
		try (Connection conn = DriverManager.getConnection(DBManip.url);
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			
					uname = rs.getString("username");
					fname = rs.getString("first_name");
					lname = rs.getString("last_name");
					p = rs.getInt("permissions");
					

			
		} catch(SQLException e){
			System.out.println(e.getMessage());
		}
	}
	
	public String getUsername(){
		return uname;		
	}
	public String getFirstName(){
		return fname;
	}
	public String getLastName(){
		return lname;
	}
	public int getPermissions(){
		return p;
	}

}
