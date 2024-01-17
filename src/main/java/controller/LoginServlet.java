package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet(value = "/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String username = req.getParameter("username");

		String password = req.getParameter("password");

		String dbPassowrd = getUserPassword(username);
		
		// 預設用戶：username=user,password=123($2a$10$OOxBDZsn455tNHFuwwZY4.lKk21m9wr4UxVKtsLWa9O6lU2M1ZNLa)
		if (!"".equals(dbPassowrd) && BCrypt.checkpw(password,dbPassowrd)) {
			// 設定 Http Session 資料
			HttpSession session = req.getSession();
			session.setAttribute("isLogin", true);
			session.setAttribute("username", username);
			session.setMaxInactiveInterval(60 * 60 * 1); // 1小時：如果在指定的一段時間內，沒有任何的請求進來，session會失效。
			resp.sendRedirect("/Calendar/calendar/Home.jsp");
			return;
		}

		// 處理驗證沒有過的時候，要怎麼處理
		req.setAttribute("error", "帳號或密碼輸入錯誤!");
		RequestDispatcher rd = req.getRequestDispatcher("/calendar/login.jsp");
		rd.forward(req, resp);

	}

	private String getUserPassword(String username) {
		try (Connection connection = JndiUtils.getConnection()) {
			String sql = "SELECT password FROM calendar.accounts WHERE Id = ?";
			try (PreparedStatement statement = connection.prepareStatement(sql)) {
				statement.setString(1, username);
				try (ResultSet resultSet = statement.executeQuery()) {
					if (resultSet.next()) {
						return resultSet.getString("password");
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return "";
		}
		return "";
	}
}
