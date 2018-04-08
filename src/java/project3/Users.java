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
		this.id = n;
		String sql = "SELECT username,first_name,last_name,permissions From Users " + "WHERE user_id = ?";
		try (Connection conn = DriverManager.getConnection(DBManip.url);
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setInt(1, this.id);
			ResultSet rs = pstmt.executeQuery();
			
					this.uname = rs.getString("username");
					this.fname = rs.getString("first_name");
					this.lname = rs.getString("last_name");
					this.p = rs.getInt("permissions");
					

			
		} catch(SQLException e){
			System.out.println(e.getMessage());
		}
	}
	
	public String getUsername(){
		return this.uname;		
	}
	public String getFirstName(){
		return this.fname;
	}
	public String getLastName(){
		return this.lname;
	}
	public int getPermissions(){
		return this.p;
	}
        public int getID() {
            return this.id;
        }

}
