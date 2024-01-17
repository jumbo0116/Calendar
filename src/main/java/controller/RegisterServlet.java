package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.mysql.cj.Session;
import com.mysql.cj.protocol.Message;

import model.register.Register;
import model.register.RegisterDao;
import model.register.RegisterDaoMySQL;

@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {

	private RegisterDao registerDao = new RegisterDaoMySQL();

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 取得所有紀錄
		List<Register> registers = registerDao.readAll();

		// 重導到 /webapp/calendar/Register.jsp
		RequestDispatcher rd = req.getRequestDispatcher("/Calendar/calendar/Register.jsp");
		req.setAttribute("registers", registers);
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String comfirm = req.getParameter("comfirm");

		if (password.equals(comfirm)) {

			if (isUsernameTaken(username)) {
				req.setAttribute("error", "帳號重複");
				RequestDispatcher rd = req.getRequestDispatcher("/calendar/Register.jsp");
				rd.forward(req, resp);

			} else {
				Register register = new Register();
				register.setId(username);
				String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());  // 加密
				register.setPassword(hashedPassword);

				registerDao.create(register);
				RequestDispatcher rd = req.getRequestDispatcher("/calendar/login.jsp");
				rd.forward(req, resp);
			}

		} else {
			req.setAttribute("error", "兩次密碼輸入不相符");
			RequestDispatcher rd = req.getRequestDispatcher("/calendar/Register.jsp");
			rd.forward(req, resp);
		}

	}

	// 確認帳號是否重複

	private boolean isUsernameTaken(String username) {
		try (Connection connection = JndiUtils.getConnection()) {
			String sql = "SELECT * FROM calendar.accounts WHERE Id = ?";
			try (PreparedStatement statement = connection.prepareStatement(sql)) {
				statement.setString(1, username);
				try (ResultSet resultSet = statement.executeQuery()) {
					if(resultSet.next()) {
						return true;
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}

}
