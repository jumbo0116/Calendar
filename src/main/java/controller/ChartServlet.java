package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;

import model.chart.Chart;

@WebServlet("/Chart")
public class ChartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int targetYear = Integer.parseInt(request.getParameter("year"));
        int targetMonth = Integer.parseInt(request.getParameter("month"));

        response.setContentType("application/json");

        // 使用 Jackson 將數據轉換為 JSON 格式的字符串
        String jsonData = convertDataToJson(data(targetYear, targetMonth));
        response.getWriter().write(jsonData);
    }

    public static List<Double> data(int targetYear, int targetMonth) {
        List<Double> chart = new ArrayList<>();

        try (Connection connection = JndiUtils.getConnection()) {
            String sql = "SELECT type, SUM(description) AS total_amount " +
                    "FROM calendar.diary " +
                    "WHERE YEAR(date) = ? AND MONTH(date) = ? " +
                    "GROUP BY type";

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, targetYear);
                statement.setInt(2, targetMonth);

                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        double totalAmount = resultSet.getDouble("total_amount");
                        chart.add(totalAmount);
                    }

                    while (chart.size() < 1) {
                        chart.add((double) 0);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return chart;
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


