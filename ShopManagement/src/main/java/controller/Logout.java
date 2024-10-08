package controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class Logout extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		PrintWriter pw = resp.getWriter();
		HttpSession session = req.getSession();
		if (session != null) {
			session.invalidate();
			RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
			rd.include(req, resp);
			pw.print("<h3 color='red'>Logged Out<h3>");
			System.out.println("Logged Out---------------------------------------");
		} else {
			pw.print("<h3 color='red'>Session Time Out<h3>");
		}
	}
}