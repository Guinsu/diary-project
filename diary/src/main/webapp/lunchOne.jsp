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
	String msg = null;
	
	if(checkDate == null){
		checkDate = "";
	}
	
	if(msg == null){
		msg ="";
	}
	
	// 선택된 날짜에 lunch_date, menu가 있는지 확인
	String sql2 = "SELECT lunch_date, menu  FROM lunch WHERE lunch_date =?";
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 =	conn.prepareStatement(sql2);
	stmt2.setString(1, checkDate);
	rs2 = stmt2.executeQuery();

	
	// 선택한 메뉴 저장 (menu, ckeckDate가 null이 아닐 때만)
	if(menu != null && checkDate != null){
		String sql3 = "INSERT INTO lunch (lunch_date, menu, update_date, create_date) VALUES (?,?,NOW(),NOW())";
		PreparedStatement stmt3 = null;
		stmt3 =	conn.prepareStatement(sql3);
		stmt3.setString(1, checkDate);
		stmt3.setString(2, menu);
		int row = stmt3.executeUpdate();
		
		if(row > 0 ){            
			 response.sendRedirect("./lunchMenu.jsp?menu="+ URLEncoder.encode(menu, "utf-8") + "&checkDate="+ URLEncoder.encode(checkDate, "utf-8"));
		}else{
			 response.sendRedirect("./lunchOne.jsp");
		}
		
	}
	
	//디버깅
	//System.out.println(menu);
	//System.out.println(checkDate);
	
	
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
		select{
			width: 200px;
			margin-left: 40px;
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
		#smallInput{
			width: 430px;
		}
		#selectMenuBtn{
			margin-top:  20px;
			margin-bottom: 20px;
		}
		#menuDiv{
			margin-top: 30px;
			width: 100%;
		}
		#buttonDiv{
			margin-top: 40px;
			width: 300px;
		}
		#viewStatistics{
			font-size: 30px;
			text-decoration: none;
			color:black;
			border: 1px solid black;
			padding: 3px;
			background-color: #efebf2;
		}
		.inputType{
			width: 50px;
			height: 20px;
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
			<h1>오늘 먹을 점심 메뉴 </h1>
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
			
		<form action="/diary/lunchOne.jsp" method="post">
			<div class="d-flex justify-content-center">
				<div class="ms-5 me-5">
					<label class="me-3">날짜 확인</label>
					<input type="date" name="checkDate"  id="smallInput" >
				</div>
				<div id="buttonDiv">
					<button type="submit">가능확인</button>
					<a href="./diary.jsp"  id="viewStatistics" >뒤로가기</a>
				</div>
			</div>
		</form>
	</aside>
	
	<main>
		<%
			if(checkDate != ""){
				// 선택된 날짜에 메뉴가 없으면
				if(!rs2.next()){
					msg = "메뉴 선택이 가능한 날짜 입니다.";
		%>
				<form action="./lunchOne.jsp" method="post" >
					<div id="menuDiv" class="d-flex justify-content-center">
						<input type="radio" name="menu"  value="중식" class="selectMenuInput">중식
						<input type="radio" name="menu"  value="일식" class="selectMenuInput"> 일식
						<input type="radio" name="menu" value="양식" class="selectMenuInput">양식
						<input type="radio" name="menu" value="한식" class="selectMenuInput">한식
						<input type="hidden" name="checkDate" value="<%=checkDate%>">
					</div>
					<div>
						<button type="submit"  id="selectMenuBtn">투표하기</button>					
					</div>
				</form>
		<%
				// 선택된 날짜에 메뉴가 있으면
			}else{
				msg = "이미 선택된 메뉴가 있습니다.";
		%>			
				<form action="./deleteLunch.jsp" method="post">
					<div  id="menuDiv" >
						<input type="hidden" name= "selectedMenu" value="<%=rs2.getString("menu")%>"> <%=rs2.getString("menu")%>
						<input type="hidden" name= "checkedDate" value="<%=checkDate%>">
						<button type="submit" id="selectMenuBtn" class="ms-3">삭제하기</button>
					</div>
				</form>							
		<%
				}
			}
		%>
		<div class="d-flex justify-content-center">
			<div>
				<%=msg %>
			</div>
		 </div>
	</main>
</body>
</html>