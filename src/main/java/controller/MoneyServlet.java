package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * http://localhost:8080/Calendar/Money?year=2024&month=1
 */
@WebServlet("/Money")
public class MoneyServlet extends HttpServlet{

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int targetYear = Integer.parseInt(request.getParameter("year"));
        int targetMonth = Integer.parseInt(request.getParameter("month"));
        
        int totalExpense = expense(targetYear, targetMonth);
        int totalIncome = income(targetYear, targetMonth);
        
        Map<String,Integer> result = new LinkedHashMap<>();
        result.put("totalExpense", totalExpense);
        result.put("totalIncome", totalIncome);
        
        System.out.println("Total Expense: " + totalExpense);
        System.out.println("Total Income: " + totalIncome);
        
        ObjectMapper objectMapper = new ObjectMapper();
        
        String jsonData = objectMapper.writeValueAsString(result);
        response.getWriter().write(jsonData);
    }
//	
//	protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        int targetYear = Integer.parseInt(request.getParameter("year"));
//        int targetMonth = Integer.parseInt(request.getParameter("month"));
//        
//        int totalExpense = expense(targetYear, targetMonth);
//        int totalIncome = income(targetYear, targetMonth);
//        System.out.println("Total Expense: " + totalExpense);
//        System.out.println("Total Income: " + totalIncome);
//        
//        request.setAttribute("totalIncome", totalIncome);
//        request.setAttribute("totalExpense", totalExpense);
//        request.getRequestDispatcher("/calendar/Chart.jsp").forward(request, response);
//    }
	
	public static int expense(int targetYear, int targetMonth){
		int totalExpense = 0;
		
		try (Connection connection = JndiUtils.getConnection()) {
            String sql = "SELECT SUM(CASE WHEN type IN (101, 102, 103, 104, 105, 106, 107, 108) THEN description ELSE 0 END) AS total_amount " +
                    "FROM calendar.diary " +
                    "WHERE YEAR(date) = ? AND MONTH(date) = ?";

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, targetYear);
                statement.setInt(2, targetMonth);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        totalExpense = resultSet.getInt("total_amount");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalExpense;
    }
	
	public static int income(int targetYear, int targetMonth){
		int totalIncome = 0;
		
		try (Connection connection = JndiUtils.getConnection()) {
            String sql = "SELECT SUM(CASE WHEN type IN (201, 202, 203, 204) THEN description ELSE 0 END) AS total_amount " +
                    "FROM calendar.diary " +
                    "WHERE YEAR(date) = ? AND MONTH(date) = ?";

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, targetYear);
                statement.setInt(2, targetMonth);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                    	totalIncome = resultSet.getInt("total_amount");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalIncome;
    }
	
}
