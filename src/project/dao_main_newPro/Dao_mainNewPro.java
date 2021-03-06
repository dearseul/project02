package project.dao_main_newPro;
//project.dao_main_newPro.Dao_mainNewPro
import java.sql.*;
import java.util.ArrayList;

import project.vo_main_newPro.groupProducts;

public class Dao_mainNewPro {
	
	private Connection con;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public void setCon() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String info = "jdbc:oracle:thin:@localhost:1521:xe";
		
		try {
			con = DriverManager.getConnection(info, "scott", "tiger");
			System.out.println("접속 O");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}
//=========================================신상품 가져오기===================================================================
	
	public ArrayList<groupProducts> getNewPro() {
		ArrayList<groupProducts> list = new ArrayList<groupProducts>();
		try {
			setCon();
			String sql = "SELECT rownum, p.* from(\r\n"
					+ "	SELECT * from products \r\n"
					+ "	ORDER BY PRODUCT_ID DESC\r\n"
					+ ")p\r\n"
					+ "WHERE rownum BETWEEN 1 AND 4";
//			public groupProducts(String product_name, String product_category, int product_price, String product_img_src)
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				groupProducts p =new groupProducts(rs.getString("Product_name"),
								  rs.getString("product_category"),
								  rs.getInt("product_price"),
								  rs.getString("product_img_src"));
				list.add(p);
			}

			rs.close();
			pstmt.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return list;
	}
//=========================================인기상품 가져오기===================================================================
	
	public ArrayList<groupProducts> getPopPro() {
		ArrayList<groupProducts> list = new ArrayList<groupProducts>();
		try {
			setCon();
			String sql = "SELECT rownum, p.* from(\r\n"
					+ "	SELECT * FROM products\r\n"
					+ "	ORDER BY product_rate DESC\r\n"
					+ "	)p\r\n"
					+ "	WHERE rownum BETWEEN 1 AND 4";
//			public groupProducts(String product_name, String product_category, int product_price, String product_img_src)
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				groupProducts p =new groupProducts(rs.getString("Product_name"),
								  rs.getString("product_category"),
								  rs.getInt("product_price"),
								  rs.getString("product_img_src"));
				list.add(p);
			}

			rs.close();
			pstmt.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return list;
	}
	
	
	public static void main(String[] args) {

	}
}
