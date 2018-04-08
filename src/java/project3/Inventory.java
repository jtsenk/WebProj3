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
		this.id = num;
		String sql = "SELECT name,price,quantity, description From Inventory " + "WHERE item_id = ?";
		try (Connection conn = DriverManager.getConnection(DBManip.url);
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setInt(1, this.id);
			ResultSet rs = pstmt.executeQuery();
			
					this.n = rs.getString("name");
					this.p = rs.getDouble("price");
					this.q = rs.getInt("quantity");
					this.des = rs.getString("description");

			
		} catch(SQLException e){
			System.out.println(e.getMessage());
		}
	}
        	
	public String getName(){
		return this.n;		
	}
	public double getPrice(){
		return this.p;
	}
	public String getDescription(){
		return this.des;
	}
	public int getQuantity(){
		return this.q;
	}
        public int getID() {
            return this.id;
        }

}
