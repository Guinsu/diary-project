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

	String diaryDate =  request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String weather =  request.getParameter("weather");
	String content = request.getParameter("content");
	String feeling = request.getParameter("emojis"); 
	
	//디버깅
	//System.out.println(diaryDate);
	//System.out.println(title);
	//System.out.println(weather);
	//System.out.println(content);
	
	String sql1 = "INSERT INTO diary (diary_date, feeling, title, weather, content, update_date, create_date) VALUES (?,?,?,?,?,NOW(),NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt =	conn.prepareStatement(sql1);
	
	stmt.setString(1, diaryDate);
	stmt.setString(2, feeling);
	stmt.setString(3, title);
	stmt.setString(4, weather);
	stmt.setString(5, content);
	
	int row = 0;
	
	 row = stmt.executeUpdate();
	 
	 if(row > 0){
		 response.sendRedirect("./diary.jsp");
	}else{
		response.sendRedirect("./addDiaryForm.jsp");
	}
 
%>