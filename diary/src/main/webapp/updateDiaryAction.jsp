<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>

<%
//인증 분기
	String sql1 = "SELECT my_session mySession FROM login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 =	conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	String mySession = request.getParameter("mySession");
	
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	
	if(mySession.equals("OFF")){
		String errMsg =  URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
	
		// 자원 반납
		rs1.close();
		stmt1.close();
		conn.close();
	
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼 때 return 사용
	}
	
	rs1.close();
	stmt1.close();
		

	String diaryDate =  request.getParameter("diaryDate");
	String title = request.getParameter("title");
	String weather =  request.getParameter("weather");
	String content = request.getParameter("content");
	
	String sql2 = "UPDATE diary SET title= ?, weather= ?, content= ? WHERE diary_date = ?" ;
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,  title);
	stmt2.setString(2, weather);
	stmt2.setString(3, content);
	stmt2.setString(4, diaryDate);
	
	//System.out.println(stmt2);
	
	int row=  stmt2.executeUpdate();
	
	if(row > 0){
		response.sendRedirect("./diaryOne.jsp?diaryDate="+diaryDate);
	}else{
		response.sendRedirect("./updateDiaryForm.jsp?diaryDate="+diaryDate);
	}
	
	

%>