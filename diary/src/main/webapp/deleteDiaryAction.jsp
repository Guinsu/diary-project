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
	
	String sql2 = "DELETE FROM diary WHERE diary_date = ?";
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	PreparedStatement stmt2 = null;
	stmt2 =	conn.prepareStatement(sql2);
	stmt2.setString(1, diaryDate);
	int row = stmt2.executeUpdate();
	
	if(row > 0){
		response.sendRedirect("./diary.jsp");
	}else{
		response.sendRedirect("./diaryOne.jsp?diaryDate="+diaryDate);
	}
%>