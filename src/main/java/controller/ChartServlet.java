package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;

import model.chart.Chart;

@WebServlet("/Chart")
public class ChartServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 取得登入者的 username
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");

		int targetYear = Integer.parseInt(request.getParameter("year"));
		int targetMonth = Integer.parseInt(request.getParameter("month"));

		response.setContentType("application/json");

		// 使用 Jackson 將數據轉換為 JSON 格式的字符串
		String jsonData = convertDataToJson(data(targetYear, targetMonth, username));
		response.getWriter().write(jsonData);
	}

	public static List<Double> data(int targetYear, int targetMonth, String username) {

		List<Chart> charts = new ArrayList<>();

		String sql = "SELECT type, SUM(description) AS total_amount " + "FROM calendar.diary "
				+ "WHERE YEAR(date) = ? AND MONTH(date) = ? AND id=?" + "GROUP BY type";

		try (Connection connection = JndiUtils.getConnection();
				PreparedStatement statement = connection.prepareStatement(sql)) {
			statement.setInt(1, targetYear);
			statement.setInt(2, targetMonth);
			statement.setString(3, username);
			try (ResultSet resultSet = statement.executeQuery()) {
				while (resultSet.next()) {
					String type = resultSet.getString("type");
					double totalAmount = resultSet.getDouble("total_amount");

					Chart chart = new Chart();
					chart.setType(type);
					chart.setDescription(String.valueOf(totalAmount));
					charts.add(chart);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		Double[] chartValues = new Double[8];
		Arrays.fill(chartValues, 0.0);
		for (Chart chart : charts) {
			String type = chart.getType();
			String description = chart.getDescription();
			if (type.startsWith("1")) {
				int index = Integer.parseInt(type.substring(type.length() - 1));
				chartValues[index-1] = Double.valueOf(description);
			}
		}
		
		//System.out.println(Arrays.asList(chartValues));
		
		return Arrays.asList(chartValues);
	}

	private String convertDataToJson(List<Double> chartData) throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		ArrayNode arrayNode = objectMapper.createArrayNode();

		for (Double value : chartData) {
			arrayNode.add(value);
		}

		return objectMapper.writeValueAsString(arrayNode);
	}
}
