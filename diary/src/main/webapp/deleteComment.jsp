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
	String commentNo = request.getParameter("commentNo");
	
	String sql = "DELETE FROM comment WHERE diary_date =? AND comment_no = ?";
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://13.124.239.48:3306/diary", "root", "1q2w3e4r!!");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, commentNo);
	int row= stmt.executeUpdate();

	if(row > 0){
		response.sendRedirect("./diaryOne.jsp?diaryDate="+diaryDate);
	}else{
		response.sendRedirect("./diaryOne.jsp?diaryDate="+diaryDate);
	}
%>