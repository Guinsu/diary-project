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
	
	String menu = request.getParameter("menu");
	String checkDate = request.getParameter("checkDate");
	if(menu == null){
		menu = "";
	}
	if(checkDate == null){
		checkDate = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	<meta charset="UTF-8">
	<title></title>
	<style >
		body{
			font-family: "Dongle", sans-serif;
			font-style: normal;
			text-align: center;
			margin-top: 50px;
		}
		div {
			font-size: 120px;
			margin-bottom: 50px;
		}
		#viewStatistics{
			font-size: 70px;
			text-decoration: none;
			color:black;
			border: 1px solid black;
			border-radius: 30px;
			width: 400px;
		}
	</style>
</head>
<body>
	<div><%=checkDate %></div>
	<div>오늘의 점심 메뉴는 "<%=menu %>" 입니다.  </div>
	<a href="./statsLunch.jsp"  class="btn btn-outline-secondary"  id="viewStatistics">전체 통계 보기</a>
	<a href="./lunchOne.jsp"  class="ms-4 btn btn-outline-secondary"  id="viewStatistics">뒤로가기</a>
</body>
</html>