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
	
	String diaryDate = request.getParameter("diaryDate");
		
	//디버깅
	//System.out.println(diaryDate);
	String sql2 = "SELECT diary_date, title, weather, content , update_date, create_date FROM diary WHERE diary_date =?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 =	conn.prepareStatement(sql2);
	stmt2.setString(1, diaryDate);
	rs2 = stmt2.executeQuery();
	
	//디버깅
	//System.out.println(stmt1);
	rs2.close();
	stmt2.close();
	conn.close();
	
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<title>addDiaryForm</title>
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
	<style >
		body{
			font-family: "Dongle", sans-serif;
			font-style: normal;
		}
		main{
			width: 750px;
		}
		a{
			text-decoration: none;
			color: black;
			font-size:25px;
			margin-right: 10px;
		}
		header{
			width: 100%;
		}
		h1{
			color: black;
			font-size: 100px;
		}
		div{
			font-size: 30px;
		}
		input{
			width: 500px;
		}
		select{
			width: 650px;
		}
		
		#emoji{
			width:80px;
			height:80px;
			font-size: 70px;
		}
		#logoutBtn{
			width: 100px;
			height:100px;
			margin: 10px;
		}
		#checkDate, #ckecked{
			border: 1px solid black;
			width: 300px;
			padding: 10px;
			margin-right: 30px;
			margin-bottom: 30px;
		}
		#writingDiaryBtn{
			padding: 0px;
			width: 325px;
			height: 50px;
			margin-left: 100px;
			font-size: 25px;
		}#writingDiaryAtag{
			margin-right :0px;
			padding-right:50px;
			padding-left: 50px;
		}
		#backDiaryBtn{
			padding: 0px;
			width: 325px;
			height: 50px;
			margin-left: 90px;
		}#backDiaryAtag{
			margin-right :0px;
			padding-right:50px;
			padding-left: 50px;
		}
		#yo{
			width: 650px;
		}
		#title{
			width: 650px;
		}
	</style>
</head >
<body  class="d-flex flex-column justify-content-center align-items-center">
	
		
	<header  class="d-flex">
		<div class="flex-fill  text-center ">
			<h1>일기 수정 </h1>
		 </div>
	</header>
	
	
	<main>
		<%
			if(rs2.next()){	
		%>
			<form action="/diary/updateDiaryAction.jsp" method="post">
				<div class="mb-2 d-flex justify-content-between"  >
					<label>날짜  : </label>
					<input type="text" value=" <%=diaryDate %>" readonly="readonly"  name="diaryDate" id="yo">
				</div>
				<div class="mb-2 d-flex justify-content-between" >
					<label>제목 : </label>
					<input type="text" name="title" id="title"  value="<%=rs2.getString("title") %>">
				</div>
				<div class="mb-2 d-flex justify-content-between" >
					<label>날씨 : </label>
					<select name="weather" ">
						<option value="맑음" <%=rs2.getString("weather").equals("맑음") ?  "selected" : "" %>>맑음</option>
						<option value="흐림" <%=rs2.getString("weather").equals("흐림") ?  "selected" : "" %>>흐림</option>
						<option value="비" <%=rs2.getString("weather").equals("비") ?  "selected" : "" %>>비</option>
						<option value="눈" <%=rs2.getString("weather").equals("눈") ?  "selected" : "" %>>눈</option>
					</select>
				</div>
				<div class="mb-2 d-flex justify-content-between" >
					<label class="">내용 : </label>
					<textarea rows="7" cols="63" name="content" ><%=rs2.getString("content") %></textarea>
				</div>
				<div  class="d-flex justify-content-center ">
					<button type="submit" class="mt-1 btn btn-outline-dark"  id="writingDiaryBtn">수정</button>
					<button type="submit" class="mt-1 btn btn-outline-dark"  id="backDiaryBtn"><a href="./diaryOne.jsp?diaryDate= <%=diaryDate %>" id="backDiaryAtag">뒤로가기 </a></button>
				</div>
			</form>
		<%
			}
		%>
	</main>
</body>
</html>