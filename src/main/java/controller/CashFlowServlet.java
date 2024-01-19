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
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/CashFlow")
public class CashFlowServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	// 取得登入者的 username
    	HttpSession session = request.getSession();
    	String username = (String)session.getAttribute("username");
		
        int targetYear = Integer.parseInt(request.getParameter("year"));
        int targetMonth = Integer.parseInt(request.getParameter("month"));
        
        int cashExpense = cashexpense(targetYear, targetMonth,username);
        int bankExpense = bankexpense(targetYear, targetMonth,username);
        int cardExpense = cardexpense(targetYear, targetMonth,username);

        
        Map<String,Integer> result = new LinkedHashMap<>();
        result.put("cashExpense", cashExpense);
        result.put("bankExpense", bankExpense);
        result.put("cardExpense", cardExpense);

        System.out.println("cashExpense: " + cashExpense);
        System.out.println("bankExpense: " + bankExpense);
        System.out.println("cardExpense: " + cardExpense);
        
        ObjectMapper objectMapper = new ObjectMapper();
        
        String jsonData = objectMapper.writeValueAsString(result);
        response.getWriter().write(jsonData);
    }
	
	public static int cashexpense(int targetYear, int targetMonth,String username){
		int cashExpense = 0;
		
		try (Connection connection = JndiUtils.getConnection()) {
            String sql = "SELECT SUM(CASE WHEN type IN (101, 102, 103, 104, 105, 106, 107, 108) AND account = '1' THEN CAST(description AS SIGNED) ELSE 0 END) AS total_amount " +
                    "FROM calendar.diary " +
                    "WHERE YEAR(date) = ? AND MONTH(date) = ? AND Id=?";

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, targetYear);
                statement.setInt(2, targetMonth);
                statement.setString(3, username);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        cashExpense = resultSet.getInt("total_amount");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cashExpense;
    }
	
	public static int cardexpense(int targetYear, int targetMonth,String username){
		int cardExpense = 0;
		
		try (Connection connection = JndiUtils.getConnection()) {
            String sql = "SELECT SUM(CASE WHEN type IN (101, 102, 103, 104, 105, 106, 107, 108) AND account = '2'　THEN CAST(description AS SIGNED) ELSE 0 END) AS total_amount " +
                    "FROM calendar.diary " +
                    "WHERE YEAR(date) = ? AND MONTH(date) = ? AND Id=?";

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, targetYear);
                statement.setInt(2, targetMonth);
                statement.setString(3, username);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                    	cardExpense = resultSet.getInt("total_amount");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cardExpense;
    }
	
	public static int bankexpense(int targetYear, int targetMonth,String username){
		int bankExpense = 0;
		
		try (Connection connection = JndiUtils.getConnection()) {
            String sql = "SELECT SUM(CASE WHEN type IN (101, 102, 103, 104, 105, 106, 107, 108) AND account = '3'　THEN CAST(description AS SIGNED) ELSE 0 END) AS total_amount " +
                    "FROM calendar.diary " +
                    "WHERE YEAR(date) = ? AND MONTH(date) = ? AND Id=?";

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, targetYear);
                statement.setInt(2, targetMonth);
                statement.setString(3, username);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        bankExpense = resultSet.getInt("total_amount");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bankExpense;
    }
}
