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
	String menu = request.getParameter("menu");
	
	if(checkDate == null){
		checkDate = "";
	}
	

	if(menu == null){
		checkDate = "";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<title></title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	<style >
		body{
			font-family: "Dongle", sans-serif;
			font-style: normal;
		}
		aside{
			margin-bottom: 20px;
			margin-top : 30px;
			width: 750px;
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
	
		form{
			text-align: center;
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
		#checkDate{
			border: 1px solid black;
			width: 300px;
			padding: 10px;
			margin-right: 30px;
			margin-bottom: 30px;
			text-align: center;
		}
		#selectMenuBtn{
			margin-top:  20px;
			margin-bottom: 20px;
			margin-left: 5px;
		}
		#menuDiv{
			margin-top: 30px;
			width: 100%;
		}
		#viewStatistics{
			font-size: 30px;
			text-decoration: none;
			color:black;
			border: 1px solid black;
			padding: 3px;
			background-color: #efebf2;
		}
		.selectMenuInput{
			display: flex;
			width: 100px;
			height: 30px;
		}
		
	</style>
</head>
<body  class="d-flex flex-column justify-content-center align-items-center">	
	<header  class="d-flex">
		<div class="d-flex flex-column justify-content-center align-items-center">
			<div id="emoji" >&#x1F4D3;</div>
		</div>
		<div class="flex-fill  text-center ">
			<h1>점심 메뉴 수정</h1>
		 </div>
		<div class="d-flex flex-column justify-content-center align-items-center">
			<div>
				<button type="button"  id="logoutBtn" class="btn btn-outline-dark rounded-circle" >
					<a href="./logoutAction.jsp"> 로 그 아 웃</a>
				</button>
			</div>
		</div>
	</header>
	
	<aside>
		<div class="d-flex justify-content-center" >
			<div id="checkDate" class=" rounded-pill" >
				날짜 : <%=checkDate %>
			</div>
		</div>	
	</aside>
	
	<main>
		<%
			if(checkDate != ""){	
		%>
			<form action="./updateLunchAction.jsp" method="post" >
				<div id="menuDiv" class="d-flex justify-content-center">
					<input type="radio" name="menu"  value="중식" class="selectMenuInput" <%=menu.equals("중식") ? "checked" : "" %>>중식
					<input type="radio" name="menu"  value="일식" class="selectMenuInput" <%=menu.equals("일식") ? "checked" : "" %>> 일식
					<input type="radio" name="menu" value="양식" class="selectMenuInput" <%=menu.equals("양식") ? "checked" : "" %>>양식
					<input type="radio" name="menu" value="한식" class="selectMenuInput" <%=menu.equals("한식") ? "checked" : "" %>>한식
					<input type="hidden" name="checkDate" value="<%=checkDate%>">
				</div>
				<div>
					<button type="submit"  id="selectMenuBtn">수정하기</button>
					<a href="./lunchOne.jsp"  id="viewStatistics" >뒤로가기</a>					
				</div>
			</form>
		<%
			}				
		%>									
	</main>
</body>
</html>