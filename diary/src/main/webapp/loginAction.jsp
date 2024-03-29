<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%


	// 로그인 유지 구현을 DB -> 세션으로 변경
	// 로그인 성공시 세션에 loginMember 라는 변수를 만들고 로그인 아이디를 저장
	String loginMember = (String )session.getAttribute("loginmenber");
	System.out.println(loginMember + " <----session");
	
	if(loginMember != null){
		response.sendRedirect("./diary.jsp");
		return;
	}

	// loginMember가 null 이다 -> session 공간에 loginMember 변수를 생성

	// 1. 요청 값 분석 -> 로그인 성공 유무 확인 후 -> 성공하면 session에 loginMember변수를 생성
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Connection conn = null;
	Class.forName("org.mariadb.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	String sql2 = "SELECT member_id memberId  FROM member WHERE member_id =? AND member_pw = ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null; 
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, memberId);
	stmt2.setString(2, memberPw);
	rs2 =stmt2.executeQuery();
	
	
	
	if(rs2.next()){ 
		//로그인 성공시 DB 값 설정 -> session 변수 설정
		session.setAttribute("loginMember", rs2.getString("memberId"));
		response.sendRedirect("/diary/diary.jsp");	
		
	}else{
		// 로그인 실패
		String errMsg =  URLEncoder.encode("아이디와 비밀번호를 확인 해 주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
	}


%>
