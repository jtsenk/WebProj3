package project3;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Inventory {
	private int id;
	private String n;
	private double p;
	private String des;
	private int q;
	
	public Inventory(int num){
		id = num;
		String sql = "SELECT name,price,quantity, description From Inventory " + "WHERE item_id = ?";
		try (Connection conn = DriverManager.getConnection(DBManip.url);
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			
					n = rs.getString("name");
					p = rs.getDouble("price");
					q = rs.getInt("quantity");
					des = rs.getString("description");

			
		} catch(SQLException e){
			System.out.println(e.getMessage());
		}
	}
	
	public String getName(){
		return n;		
	}
	public double getPrice(){
		return p;
	}
	public String getDescription(){
		return des;
	}
	public int getQuantity(){
		return q;
	}

}
