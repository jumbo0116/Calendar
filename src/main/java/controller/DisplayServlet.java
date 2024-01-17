package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.display.Display;
import model.display.DisplayDaoMySQL;


@WebServlet("/Display")
public class DisplayServlet extends HttpServlet {
	
	private static DisplayDaoMySQL displayDao = new DisplayDaoMySQL();
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	// 取得登入者的 username
    	HttpSession session = request.getSession();
    	String username = (String)session.getAttribute("username");
    	
        List<Display> eventList = displayDao.data(username);

        String jsonEventList = DisplayDaoMySQL.convertListToJson(eventList);

        response.setContentType("application/json");

        PrintWriter out = response.getWriter();
        out.print(jsonEventList);
        out.flush();
    }
}