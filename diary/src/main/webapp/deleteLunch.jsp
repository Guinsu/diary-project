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
	
	String selectedMenu = request.getParameter("selectedMenu");
	String checkDate = request.getParameter("checkedDate");
	
	System.out.println(selectedMenu);
	
	String sql2 = "DELETE FROM lunch WHERE lunch_date = ? AND menu =?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://13.124.239.48:3306/diary", "root", "1q2w3e4r!!");

	stmt2 =	conn.prepareStatement(sql2);
	stmt2.setString(1, checkDate);
	stmt2.setString(2, selectedMenu);
	
	int row = stmt2.executeUpdate();
	
	if(row > 0){
		response.sendRedirect("./lunchOne.jsp");
	}else{
		response.sendRedirect("./lunchOne.jsp");
	}
	
%>