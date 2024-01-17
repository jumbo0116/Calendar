package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.record.Record;
import model.record.RecordDao;
import model.record.RecordDaoMySQL;

@WebServlet("/Record")
public class RecordServlet extends HttpServlet {

	private RecordDao recordDao = new RecordDaoMySQL();

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 取得所有留言紀錄
		List<Record> records = recordDao.readAll();

		// 重導到 /webapp/calendar/Home.jsp
		RequestDispatcher rd = req.getRequestDispatcher("/calendar/Home.jsp");
		req.setAttribute("records", records);
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		String dateStr = req.getParameter("datepicker");
		String itemName = req.getParameter("name_bar_a");
		String type1 = req.getParameter("type_dropdown");
		String type2 = req.getParameter("type_dropdown_2");
		String amountStr = req.getParameter("amount_bar_a");
		String account = req.getParameter("account_dropdown");
		String note = req.getParameter("note_bar_a");		

		if (itemName != null && dateStr != null && amountStr != null && account != null
				&& ((type1 != null) || (type2 != null)) && !itemName.trim().isEmpty() && !dateStr.trim().isEmpty()
				&& !amountStr.trim().isEmpty() && !account.trim().isEmpty()
				&& ((!type1.trim().isEmpty()) || (!type2.trim().isEmpty()))) {
			Record record = new Record();

			if (isInteger(amountStr)) {
				try {
					SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy"); // 日期格式根據實際情況調整
					Date date = (Date) dateFormat.parse(dateStr);
					record.setDate(new java.sql.Date(date.getTime()));
				} catch (ParseException e) {
					e.printStackTrace(); // 或其他適當的錯誤處理
				}
				
				Integer amount = Integer.parseInt(amountStr);
				record.setId((String) session.getAttribute("username"));
				record.setItemName(itemName);
				record.setType((type1 + type2).trim());
				record.setAmount(amount);
				record.setAccount(account);
				record.setNote(note.trim());

				recordDao.create(record);

				RequestDispatcher rd = req.getRequestDispatcher("/calendar/Record.jsp");
				rd.forward(req, resp);

				System.out.println("成功");
			} else {
				req.setAttribute("error", "Amount欄位請填數字");
				RequestDispatcher rd = req.getRequestDispatcher("/calendar/Record.jsp");
				rd.forward(req, resp);
				
				System.out.println("失敗");
				System.out.println("失敗: amount需為數字");
			}
		} else {
			req.setAttribute("error", "除了Note欄位，其餘皆需輸入資料");
			RequestDispatcher rd = req.getRequestDispatcher("/calendar/Record.jsp");
			rd.forward(req, resp);
			
			System.out.println("失敗");
			System.out.println("失敗: 某些參數為空");
			System.out.println("itemName: " + itemName);
			System.out.println("dateStr: " + dateStr);
			System.out.println("amountStr: " + amountStr);
			System.out.println("account: " + account);
			System.out.println("type1: " + type1);
			System.out.println("type2: " + type2);
		}
	}

	private boolean isInteger(String str) {
		try {
			Integer.parseInt(str);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}
}
