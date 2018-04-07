package project3;
import java.sql.*;

public class DBManip {
	static String url = "jdbc:sqlite:D:/GitHub/WebProj3/Project3.db";       //change to your local directory
        
        public static void initDB() {
            try {
                Class.forName("org.sqlite.JDBC");
            }
            catch (ClassNotFoundException e){System.out.println(e.getException());}
        }
        
	public static String testLogin(String one, String two) {  
        initDB();
        String sql = "SELECT username, password, permissions FROM Users";
        try (Connection conn = DriverManager.getConnection(url);
             Statement stmt  = conn.createStatement();
             ResultSet rs    = stmt.executeQuery(sql)){
            // loop through the result set
            while (rs.next()) {
                if(rs.getString("username").equals(one) && rs.getString("password").equals(two)){
                	return ""+rs.getInt("permissions"); //return permission if login credentials are valid
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return "x"; //return x if credentials are invalid
    }
	
	//id will have to be generated somewhere
	public static void createUser(String u, String p, String d, String f, String l, int id) {
        initDB();
        String sql = "INSERT INTO Users(username,password,permissions,first_name,last_name,user_id) VALUES(?,?,?,?,?,?)";
        if(testLogin(u,p).equals("x")){ //tests to see that user does not exist
	        try (Connection conn = DriverManager.getConnection(url);
	                PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            pstmt.setString(1, u);
	            pstmt.setString(2, p);
	            pstmt.setString(3, d);
	            pstmt.setString(4, f);
	            pstmt.setString(5, l);
	            pstmt.setNull(6, 0);
	            pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println(e.getMessage());
	        }
        }
    }

	public static void createTrans(int t_id,String d, int u_id, int i_id, int q){
                initDB();
		String sql2 = "INSERT INTO Transactions(transaction_id,date,user_id,item_id,quantity) VALUES(?,?,?,?,?)";
		 try (Connection conn = DriverManager.getConnection(url);
	                PreparedStatement pstmt = conn.prepareStatement(sql2)) {
			 	pstmt.setNull(1, 0);
	            pstmt.setString(2, d);
	            pstmt.setInt(3, u_id);
	            pstmt.setInt(4, i_id);
	            pstmt.setInt(5, q);
	            pstmt.executeUpdate();
	  
	        } catch (SQLException e) {
	            System.out.println(e.getMessage());
	        }
	}
	
	public static void createInventory(int i_id,String n, double p, int q, String d){
		initDB();
                String sql2 = "INSERT INTO Inventory(item_id,name,price,quantity,description) VALUES(?,?,?,?,?)";
		 try (Connection conn = DriverManager.getConnection(url);
	                PreparedStatement pstmt = conn.prepareStatement(sql2)) {
			 	pstmt.setNull(1, 0);
	            pstmt.setString(2, n);
	            pstmt.setDouble(3,p);
	            pstmt.setInt(4, q);
	            pstmt.setString(5, d);
	            pstmt.executeUpdate();
	  
	        } catch (SQLException e) {
	            System.out.println(e.getMessage());
	        }
	}
	
	public static boolean unameCheck(String u){
		initDB();
                String sql = "SELECT username FROM Users";
	        
	        try (Connection conn = DriverManager.getConnection(url);
	             Statement stmt  = conn.createStatement();
	             ResultSet rs    = stmt.executeQuery(sql)){
	            
	            // loop through the result set
	            while (rs.next()) {
	                if(rs.getString("username").equals(u)){
	                	return false; //return permission if user name does not exist
	                }
	            }
	        } catch (SQLException e) {
	            System.out.println(e.getMessage());
	        }
			return true; //return if user name is taken
	    }
	
	public static Inventory itemFind(String n){
		initDB();
                String sql = "SELECT item_id From Inventory " + "WHERE name = ?";
		int id = -1;
		try (Connection conn = DriverManager.getConnection(DBManip.url);
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, n);
			ResultSet rs = pstmt.executeQuery();
					id = rs.getInt("item_id");
					Inventory temp = new Inventory(id);
					return temp;
		} catch(SQLException e){
			System.out.println(e.getMessage());
		Inventory fail = new Inventory(-1);
		return fail;
		}
	}
	
	public static Users userFind(String u){
		initDB();
                String sql = "SELECT user_id From Users " + "WHERE username = ?";
		int id = -1;
		try (Connection conn = DriverManager.getConnection(DBManip.url);
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, u);
			ResultSet rs = pstmt.executeQuery();
					id = rs.getInt("item_id");
					Users temp = new Users(id);
					return temp;
		} catch(SQLException e){
			System.out.println(e.getMessage());
		Users fail = new Users(-1);
		return fail;
		}
	}
	
}
