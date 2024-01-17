package model.display;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


import controller.JndiUtils;

import model.display.Display;
public class DisplayDaoMySQL {
	private Connection conn;

	public DisplayDaoMySQL() {
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
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public List<Display> data() {
		List<Display> display = new ArrayList<>();

		try (Connection connection = JndiUtils.getConnection()) {
			String sql = "SELECT Id, date, name, description, type FROM calendar.diary";
			try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
				try (ResultSet resultSet = preparedStatement.executeQuery()) {
					while (resultSet.next()) {
						String Id = resultSet.getString("Id");
						String date = resultSet.getString("date");
						String name = resultSet.getString("name");
						String type = resultSet.getString("type");
						String description = "$"+"&nbsp"+resultSet.getString("description")+"&nbsp"+"元";
						
						if("101".equals(type)) {
							String color = "#fd7808";
							Display datalist = new Display(Id, date, name, type, description,color);
							display.add(datalist);
						}else if("102".equals(type)){
							String color = "#30bdfd";
							Display datalist = new Display(Id, date, name, type, description,color);
							display.add(datalist);
						}else if("103".equals(type)){
							String color = "#30fd80";
							Display datalist = new Display(Id, date, name, type, description,color);
							display.add(datalist);
						}else if("104".equals(type)){
							String color = "#f9f137";
							Display datalist = new Display(Id, date, name, type, description,color);
							display.add(datalist);
						}else if("105".equals(type)){
							String color = "#e31717";
							Display datalist = new Display(Id, date, name, type, description,color);
							display.add(datalist);
						}else if("106".equals(type)){
							String color = "#c642f3";
							Display datalist = new Display(Id, date, name, type, description,color);
							display.add(datalist);
						}else if("107".equals(type)){
							String color = "#FFBDE7";
							Display datalist = new Display(Id, date, name, type, description,color);
							display.add(datalist);
						}else if("108".equals(type)){
							String color = "#afa2a9";
							Display datalist = new Display(Id, date, name, type, description,color);
							display.add(datalist);
						}
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		 // 将数据转换为 JSON 字符串并打印
	    String jsonDisplay = convertListToJson(display);
	    System.out.println("JSON Display List: " + jsonDisplay);
		return display;
	}
	
	public static String convertListToJson(List<Display> displayList) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(displayList);            
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }
	
	
	
}
