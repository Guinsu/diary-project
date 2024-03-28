<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%

	String sql1 = "SELECT my_session mySession FROM login WHERE no =?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 =	conn.prepareStatement(sql1);
	stmt1.setInt(1, 1);
	rs1 = stmt1.executeQuery();
	
	String mySession = null;
	
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	
	if(mySession.equals("ON")){
		String sql2 = "UPDATE login SET my_session = ?, off_date = NOW() WHERE no = 1";
		PreparedStatement stmt2 = null;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, "OFF");
		stmt2.executeUpdate();

		stmt2.close();
		response.sendRedirect("/diary/loginForm.jsp");
		return; 
				
	}else{
		String errMsg =  URLEncoder.encode("아이디와 비밀번호를 확인 해 주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
	}
	
	
	// 자원 반납
	rs1.close();
	stmt1.close();
	conn.close();
%>