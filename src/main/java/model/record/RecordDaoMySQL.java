package model.record;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import model.register.Register;

public class RecordDaoMySQL implements RecordDao {
	private Connection conn;

	public RecordDaoMySQL() {
		// 透過 JNDI 來查找資源

		try {
			InitialContext ctx = new InitialContext(); // 初始環境
			Context envContext = (Context) ctx.lookup("java:comp/env"); // 取得環境物件
			DataSource ds = (DataSource) envContext.lookup("jdbc/calendar"); // 透過環境物件取得指定資源

			conn = ds.getConnection(); // 取得資源連線

		} catch (Exception e) {
			e.printStackTrace();
		}
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

	public void create(Record record) {
		String sql = "insert into calendar.diary(Id,date,name,type,description,account,note) values(?,?,?,?,?,?,?)";
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			// 配置 sql ? 資料
			pstmt.setString(1, record.getId());
			pstmt.setDate(2, record.getDate());
			pstmt.setString(3, record.getItemName());
			pstmt.setString(4, record.getType());
			pstmt.setInt(5, record.getAmount());
			pstmt.setString(6, record.getAccount());
			pstmt.setString(7, record.getNote());
			// 提交送出
			int rowcount = pstmt.executeUpdate();
			System.out.println("rowcount(異動筆數) = " + rowcount);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public List<Record> readAll() {
		String sql = "select Id, date, name, type, note, account, description from calendar.diary";
		List<Record> records = new ArrayList<>();
		try(Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql) ) {
			
			// 將 rs 的資料逐筆注入到 record 物件中
			while (rs.next()) {
				Record record = new Record();
				record.setId(rs.getString("Id"));
				record.setDate(rs.getDate("date"));
				record.setItemName(rs.getString("name"));
				record.setType(rs.getString("type"));
				record.setAmount(rs.getInt("description"));
				record.setAccount(rs.getString("account"));
				record.setNote(rs.getString("note"));
				// 加入到 records 集合中
				records.add(record);
			}
			
		}catch (SQLException e) {
				e.printStackTrace();
		}
			
		return records;
	}
	
}
