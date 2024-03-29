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

	if(checkDate == null){
		checkDate = "";
	}
	String ck = request.getParameter("ck");
	//System.out.println(ck);
	if(ck == null){
		ck="";
	}
	
	String msg = "";
	
	if(ck.equals("T")){
		msg = "입력 가능한 날짜 입니다.";
	}else if(ck.equals("F")){
		msg = "일기가 이미 존재하는 날짜입니다.";
	}else{
		msg = "";
	}
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
		select{
			width: 200px;
			margin-left: 40px;
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
			margin-left :50px;
			margin-top: 4px;
			width: 325px;
			height: 50px;
			padding-right:50px;
			padding-left: 50px;
			border: 1px solid black;
			border-radius: 5px;
			text-align: center;
			font-size: 30px;
		}
		#yo{
			width: 650px;
		}
		#title{
			width: 650px;
		}
		#emotion{
			font-size: 25px;
		}
		.inputType{
			width: 50px;
			height: 20px;
		}
	</style>
</head >
<body  class="d-flex flex-column justify-content-center align-items-center">
	
		
	<header  class="d-flex">
		<div class="d-flex flex-column justify-content-center align-items-center">
			<div id="emoji" >&#x1F4D3;</div>
		</div>
		<div class="flex-fill  text-center ">
			<h1>일기작성 </h1>
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
		<div  class="ms-5 d-flex">
			<div id="checkDate" class="rounded-pill">
				날짜 : <%=checkDate %>
			</div>
			<div id="ckecked" class="rounded-pill">
				가능여부 : <%=ck %>	
			</div>
		</div>	
			
		<form action="/diary/checkDateAction.jsp" method="post">
			<div class="d-flex justify-content-center">
				<div class="me-5">
					<label class="me-3">일기 여부 확인</label>
					<input type="date" name="checkDate">
				</div>
				<div>
					<button type="submit">가능확인</button>
				</div>
			</div>
			<div class="mt-2 d-flex justify-content-center">
				<div><%=msg%></div>
			</div>
		</form>
	</aside>
	
	<main>
		<form action="/diary/addDiaryAction.jsp" method="post">
			<div class="mb-2 d-flex justify-content-between"  >
				<label>날짜  : </label>
					<%
						if(ck.equals("T")){
					%>
						<input type="text" name="diaryDate" readonly="readonly" value="<%=checkDate%>"  id="yo">
					<%
						}else{
					%>
						<input value="" type="text" name="diaryDate" readonly="readonly" id="yo">
					<%
						}
					%>
				
			</div>
			<div class="mb-2 d-flex justify-content-between" >
				<label>제목 : </label>
				<input type="text" name="title" id="title" >
			</div>
			<div class="d-flex" >
				<div class="p-2 flex-fill">
					<label>날씨 : </label>
					<select name="weather">
						<option value="맑음">맑음</option>
						<option value="흐림">흐림</option>
						<option value="비">비</option>
						<option value="눈">눈</option>
					</select>
				</div>
				<div class="p-2 flex-fill" id="emotion">
					<label>감정 : </label>
					<input type="radio"  value="&#128538" name="emojis" class="inputType">&#128538
					<input type="radio" value="&#128545" name="emojis"  class="inputType">&#128545
					<input type="radio"  value="&#128557" name="emojis"  class="inputType">&#128557
					<input type="radio"  value="&#128529" name="emojis" class="inputType">&#128529
				</div>
			</div>
			<div class="mb-2 d-flex justify-content-between" >
				<label class="">내용 : </label>
				<textarea rows="7" cols="63" name="content"></textarea>
			</div>
			<div  class="d-flex justify-content-center ">
				<button type="submit" class="mt-1 btn btn-outline-dark"  id="writingDiaryBtn">입력</button>
				<a href="./diary.jsp" id="backDiaryAtag"  class="btn btn-outline-dark">뒤로가기 </a>
			</div>
		</form>
	</main>
</body>
</html>