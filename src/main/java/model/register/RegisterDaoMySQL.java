package model.register;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.tomcat.jdbc.pool.ConnectionPool;


public class RegisterDaoMySQL implements RegisterDao {
	private Connection conn;
	
	public RegisterDaoMySQL() {
		// 透過 JNDI 來查找資源
		
		try {
			InitialContext ctx = new InitialContext(); // 初始環境
			Context envContext = (Context)ctx.lookup("java:comp/env"); // 取得環境物件
			DataSource ds = (DataSource)envContext.lookup("jdbc/calendar"); // 透過環境物件取得指定資源
			
			conn = ds.getConnection(); // 取得資源連線
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		/*
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/web?serverTimezone=Asia/Taipei";
			String username = "web";
			String password = "12345678";
			conn = DriverManager.getConnection(url, username, password);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		*/
	}
	
	@Override
	protected void finalize() throws Throwable {
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void create(Register register) {
		String sql = "insert into calendar.accounts(Id, password) values(?, ?)";
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			// 配置 sql ? 資料
			pstmt.setString(1, register.getId());
			pstmt.setString(2, register.getPassword());
			// 提交送出
			int rowcount = pstmt.executeUpdate();
			System.out.println("rowcount(異動筆數) = " + rowcount);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Register> readAll() {
		String sql = "select id, password from calendar.accounts";
		List<Register> registers = new ArrayList<>();
		try(Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql) ) {
			
			// 將 rs 的資料逐筆注入到 register 物件中
			while (rs.next()) {
				Register register = new Register();
				register.setNum(rs.getInt("num"));
				register.setId(rs.getString("Id"));
				register.setPassword(rs.getString("password"));
				// 加入到 guestbooks 集合中
				registers.add(register);
			}
			
		}catch (SQLException e) {
				e.printStackTrace();
		}
			
		return registers;
	}
	
	//以下測試中
	/*
	private static DataSource dataSource;
	
	public static Connection getConnection() throws SQLException{
		return dataSource.getConnection();
	}
	*/
}
