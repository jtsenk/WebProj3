package project3;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Transactions {
	private int id;
	private String d;
	private int u_id;
	private int i_id;
	private int q;
	
	public Transactions(int n){
		id = n;
		String sql = "SELECT date,user_id,item_id,quantity From Transactions " + "WHERE transaction_id = ?";
		try (Connection conn = DriverManager.getConnection(DBManip.url);
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			
					d = rs.getString("date");
					u_id = rs.getInt("user_id");
					i_id = rs.getInt("item_id");
					q = rs.getInt("quantity");
					

			
		} catch(SQLException e){
			System.out.println(e.getMessage());
		}
	}
	
	public String getDate(){
		return d;		
	}
	public int getUser(){
		return u_id;
	}
	public int getItem(){
		return i_id;
	}
	public int getQuantity(){
		return q;
	}

}
