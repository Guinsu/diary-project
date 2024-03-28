<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//0. 로그인(인증)) 분기
	//diary.login.my_session => 'ON' => redirect("diary.jsp")
	
	String sql1 = "SELECT my_session mySession FROM login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 =	conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	String mySession = null;
	
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	
	if(mySession.equals("ON")){
		response.sendRedirect("/diary/diary.jsp");
	
		// 자원 반납
		rs1.close();
		stmt1.close();
		conn.close();
	
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼 때 return 사용
	}
	
	rs1.close();
	stmt1.close();
	conn.close();
	
	// 1. 요청 값 분석
	String errMsg = request.getParameter("errMsg");
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
	<title>login</title>
	<style >
		body{
			width:100%;
			height:100%;
			background-image: url("./1.png");
		 	background-size: cover;
		 	font-family: "Dongle", sans-serif;
  			font-size: 25px;
  			font-style: normal;
		}
		header{
			margin-top: 10%;
		}
		form{
			background-color: white;
			width: 700px;
			height: 500px;
		}
		h3{
			margin-bottom: 10%;
		}
		
		#idDiv,#pwDiv{
			width: 250px;
			margin-top: 3%;
		}
		#loginBtn{
			width:200px;
		}
		.loginBtnDiv{
			margin-top: 7%;
			margin-left: 8%;
		}
		
	</style>
</head>
<body>
	<header  class="d-flex justify-content-center">	
		<h1>I'm your Diary</h1>
	</header>
	
	<main  class="d-flex justify-content-center ">
		<form method="post" action="./loginAction.jsp" class="border border-4 border-light-subtle rounded-4 d-flex flex-column justify-content-center align-items-center p-3 mb-2 bg-light text-dark shadow-lg p-3 mb-5 bg-body-tertiary rounded">
			<h3>로그인이 필요 합니다 &#128204 </h3>
			<div class="d-flex justify-content-between"  id="idDiv"> 
				<label>아이디</label>
				<input type="text" name="memberId" class="rounded-3">
			</div>
			<div class="d-flex justify-content-between" id="pwDiv">
				<label>비밀번호</label>
				<input type="password" name="memberPw"  class="rounded-3">
			</div>
			<div  class="loginBtnDiv">
				<input type="submit" id="loginBtn"  value="로그인" class="btn btn-outline-danger  btn-lg">
			</div>
			<div class="mt-4 ">
				<%
					if(errMsg != null){
				%>
					<%=errMsg %>
				<%
					}
				%>
			</div>
		</form>
	</main>
</body>
</html>