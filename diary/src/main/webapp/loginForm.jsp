<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	// 로그인 유지 구현을 DB -> 세션으로 변경
	// 로그인 성공시 세션에 loginMember 라는 변수를 만들고 로그인 아이디를 저장
	String loginMember = (String )session.getAttribute("loginmenber");
	// 사용되는 Session API
	// session.getAttribute(String) : 변수 이름으로 변수 값을 반환하는 메서드
	// session.getAttribute()는 찾는 변수가 없으면 null 값을 반환한다.
	// null 이면 로그아웃 상태이고, null이 아니면 로그인 상태
	//session.getAttribute() 찾는 변수가 없으면 null 값을 반환한다.
	
	
	//System.out.println(loginMember + " <----session");
	
	if(loginMember != null){
		response.sendRedirect("./diary.jsp");
		return;
	}
	
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