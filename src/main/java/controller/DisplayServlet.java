package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.display.Display;
import model.display.DisplayDaoMySQL;


@WebServlet("/Display")
public class DisplayServlet extends HttpServlet {
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DisplayDaoMySQL displayDao = new DisplayDaoMySQL();

        List<Display> eventList = displayDao.data();

        String jsonEventList = DisplayDaoMySQL.convertListToJson(eventList);

        response.setContentType("application/json");

        PrintWriter out = response.getWriter();
        out.print(jsonEventList);
        out.flush();
    }
}