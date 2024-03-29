<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	//session 로그인 여부 확인
	String loginMember = (String)(session.getAttribute("loginMember"));
	if(loginMember == null){
		String errMsg =  URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
	}
	
	String diaryDate = request.getParameter("diaryDate");
	String memo = request.getParameter("memo");
	
	String sql = "INSERT INTO comment (diary_date, memo, update_date, create_date) VALUES (?,?,NOW(),NOW())";
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	PreparedStatement stmt = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, memo);
	
	int row = stmt.executeUpdate();
	
	if(row > 0){
		response.sendRedirect("./diaryOne.jsp?diaryDate="+diaryDate);
	}else{
		response.sendRedirect("./diaryOne.jsp?diaryDate="+diaryDate);
	}
	
%>
