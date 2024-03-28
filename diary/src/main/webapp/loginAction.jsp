<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%


	// 1. 요청 값 분석
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
		//로그인 성공
		// diary.login. my_session => "ON" 변경
		String sql3 = "UPDATE login SET my_session = ?, on_date = NOW() WHERE no = 1";
		PreparedStatement stmt3 = null;
		stmt3 = conn.prepareStatement(sql3);
		stmt3.setString(1, "ON");
		stmt3.executeUpdate();
		
		stmt3.close();
		//System.out.println("로그인성공");			
		
	}else{
		// 로그인 실패
		String errMsg =  URLEncoder.encode("아이디와 비밀번호를 확인 해 주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
	}



	//0. 로그인(인증)) 분기
	//diary.login.my_session => 'ON' => redirect("diary.jsp")
	
	String sql1 = "SELECT my_session mySession FROM login";
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	stmt1 =	conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	String mySession = null;
	
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	
	if(mySession.equals("ON")){
		response.sendRedirect("/diary/diary.jsp?mySession="+mySession);
	
		// 자원 반납
		rs1.close();
		stmt1.close();
		conn.close();	

		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼 때 return 사용
	}
	
	
	stmt1.close();
	rs1.close();
	
	stmt2.close();
	rs2.close();
	
	conn.close();
%>
