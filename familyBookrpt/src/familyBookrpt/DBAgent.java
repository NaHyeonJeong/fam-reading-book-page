package familyBookrpt;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//import hslibrary.Book;

public class DBAgent {

	static Connection con = null;
	public Statement stmt = null;
	
	static String dbUrl = "jdbc:mysql://localhost:3306/bookrptdb?characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
		
	public static boolean loadConnect() {
		try { // 드라이버 로딩
			Class.forName("com.mysql.jdbc.Driver");
		} catch ( java.lang.ClassNotFoundException e ) {
			System.err.println("DB Driver load error in loadConnect(): " + e.getMessage() );
			e.printStackTrace();
		}

		try { // 연결하기
			con = DriverManager.getConnection(dbUrl, "bookrpt_user", "1234");  
			System.out.println("<< for debug >> 연결 성공: db에 연결됨");
			
			return true;
		} catch( SQLException ex ) {
			System.err.println("DB Connection error in loadConnect(): " + ex.getMessage() );
			ex.printStackTrace();
		}	   
		return false;
	}
	
	public static Connection getCon() throws SQLException{
		return con;
	}
	
	public static ResultSet getAllIsbnRS(String isbn) {
		try {                      
			// SQL 질의문을 수행한다.
			String sql = "select * from book where isbn = '" + isbn + "';" ;
			System.out.println("\n  << for debug >> SQL : " + sql + "\n");

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);  

			return rs;
			
		} catch( SQLException ex ) {             
			System.err.println("\n  ??? SQL exec error in getAllMenuRS(): " + ex.getMessage() );
		}

		return null;
	}
	
	public static ResultSet getAllResauthorRS(String author) {
		try {                      
			// SQL 질의문을 수행한다.
			String sql = "select * from book where author like '%" + author + "%';" ;
			System.out.println("\n  << for debug >> SQL : " + sql + "\n");

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);  

			return rs;
			
		} catch( SQLException ex ) {             
			System.err.println("\n  ??? SQL exec error in getAllMenuRS(): " + ex.getMessage() );
		}

		return null;
	}
	
	public static ResultSet getAllResTitleRS(String title) {
		try {                      
			// SQL 질의문을 수행한다.
			String sql = "select * from book where title like '%" + title + "%';" ;
			System.out.println("\n  << for debug >> SQL : " + sql + "\n");

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);  

			return rs;
			
		} catch( SQLException ex ) {             
			System.err.println("\n  ??? SQL exec error in getAllMenuRS(): " + ex.getMessage() );
		}

		return null;
	}
	
	public static ResultSet getAllResPublisherRS(String publisher) {
		try {                      
			// SQL 질의문을 수행한다.
			String sql = "select * from book where publisher like '%" + publisher + "%';" ;
			System.out.println("\n  << for debug >> SQL : " + sql + "\n");

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);  

			return rs;
			
		} catch( SQLException ex ) {             
			System.err.println("\n  ??? SQL exec error in getAllMenuRS(): " + ex.getMessage() );
		}

		return null;
	}
	
	public static int changeBState(int bno) {
		int updateCnt = 0;

		try {                      
			// SQL 질의문을 수행한다.
	
			String sql = "update book set bstate = '대출중', rstate = '예약가능' where bno = " + bno + ";";
			
			System.out.println("\n  << for debug >> SQL : " + sql + "\n");
			
			PreparedStatement prStmt = con.prepareStatement(sql);
			
			updateCnt = prStmt.executeUpdate();  		
		} catch( SQLException ex ) {

			System.err.println("\n  ??? SQL exec error in DeliveryCancel(): " + ex.getMessage() );
		}

		return updateCnt;
	}
	
	public static int changeRState(int bno) {
		int updateCnt = 0;

		try {                      
			// SQL 질의문을 수행한다.
	
			String sql = "update book set rstate = '예약가능' where bno = " + bno + ";";
			
			System.out.println("\n  << for debug >> SQL : " + sql + "\n");
			
			PreparedStatement prStmt = con.prepareStatement(sql);
			
			updateCnt = prStmt.executeUpdate();  		
		} catch( SQLException ex ) {

			System.err.println("\n  ??? SQL exec error in DeliveryCancel(): " + ex.getMessage() );
		}

		return updateCnt;
	}
}