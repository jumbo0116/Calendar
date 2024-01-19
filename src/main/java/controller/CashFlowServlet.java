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
        
        int cashExpense = expense(targetYear, targetMonth,username,1);
        int cardExpense = expense(targetYear, targetMonth,username,2);
        int bankExpense = expense(targetYear, targetMonth,username,3);
        
        int cashIncome = income(targetYear, targetMonth,username,1);
        int bankIncome = income(targetYear, targetMonth,username,2);
        
        Map<String,Integer> result = new LinkedHashMap<>();
        result.put("cashExpense", cashExpense);
        result.put("bankExpense", bankExpense);
        result.put("cardExpense", cardExpense);        
        result.put("cashIncome", cashIncome);
        result.put("bankIncome", bankIncome);

        System.out.println("cashExpense: " + cashExpense);
        System.out.println("bankExpense: " + bankExpense);
        System.out.println("cardExpense: " + cardExpense);       
        System.out.println("cashIncome: " + cashIncome);
        System.out.println("bankIncome: " + bankIncome);
        
        ObjectMapper objectMapper = new ObjectMapper();
        
        String jsonData = objectMapper.writeValueAsString(result);
        response.getWriter().write(jsonData);
    }
	
	public static int expense(int targetYear, int targetMonth,String username,int accountType){
		int expense = 0;
		
		try (Connection connection = JndiUtils.getConnection()) {
            String sql = "SELECT SUM(CASE WHEN type IN (101, 102, 103, 104, 105, 106, 107, 108) THEN CAST(description AS SIGNED) ELSE 0 END) AS total_amount " +
                    "FROM calendar.diary " +
                    "WHERE YEAR(date) = ? AND MONTH(date) = ? AND Id=? AND account=?";

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, targetYear);
                statement.setInt(2, targetMonth);
                statement.setString(3, username);
                statement.setInt(4, accountType);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        expense = resultSet.getInt("total_amount");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return expense;
    }
	
	public static int income(int targetYear, int targetMonth,String username,int accountType){
		int income = 0;
		
		try (Connection connection = JndiUtils.getConnection()) {
            String sql = "SELECT SUM(CASE WHEN type IN (201, 202, 203, 204) THEN CAST(description AS SIGNED) ELSE 0 END) AS total_amount " +
                    "FROM calendar.diary " +
                    "WHERE YEAR(date) = ? AND MONTH(date) = ? AND Id=? AND account=?";

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, targetYear);
                statement.setInt(2, targetMonth);
                statement.setString(3, username);
                statement.setInt(4, accountType);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                    	income = resultSet.getInt("total_amount");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return income;
    }
	
}
