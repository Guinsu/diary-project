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
	
	String checkDate = request.getParameter("checkDate");
	
	//디버깅
	//System.out.println(checkDate);
	
	String sql = "SELECT diary_date diaryDate FROM diary WHERE diary_date =? ";
	// 결과가 있으면 이미 이 날짜에 일기가 있다 -> 입력 X 
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, checkDate);
	rs = stmt.executeQuery();
	
	if(rs.next()){
		// 이날짜 일기 기록 불가능(이미존재)
		response.sendRedirect("/diary/addDiaryForm.jsp?checkDate=" + checkDate+"&ck=F");
	}else{
		// 이날짜 일기 기록 가능
		response.sendRedirect("/diary/addDiaryForm.jsp?checkDate=" + checkDate+"&ck=T");
	}
	
%>