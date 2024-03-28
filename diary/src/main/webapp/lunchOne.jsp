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
	
	
	String checkDate = request.getParameter("checkDate");
				
	String sql2 = "SELECT lunch_date, menu  FROM lunch WHERE lunch_date =?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 =	conn.prepareStatement(sql2);
	stmt2.setString(1, checkDate);
	rs2 = stmt2.executeQuery();

	if(checkDate == null){
		checkDate = "";
	}
	
	String ck = request.getParameter("ck");
	//System.out.println(ck);
	if(ck == null){
		ck="";
	}
	
	String msg = "";
	
	String menu = request.getParameter("menu");
	
	//디버깅
	//System.out.println(menu);
	
	if(menu != null){
		String sql3 = "INSERT INTO lunch (lunch_date, menu, update_date, create_date) VALUES (?,?,NOW(),NOW())";
		PreparedStatement stmt3 = null;
		stmt3 =	conn.prepareStatement(sql3);
		stmt3.setString(1, checkDate);
		stmt3.setString(2, menu);
		int row = stmt3.executeUpdate();
		if(row > 0 ){
			 response.sendRedirect("./lunchMenu.jsp?menu="+menu);
		}else{
			 response.sendRedirect("./lunchOne.jsp");
		}
	}
	
	rs1.close();
	stmt1.close();
	conn.close();
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
		.inputType{
			width: 50px;
			height: 20px;
		}
	</style>
</head>
<body  class="d-flex flex-column justify-content-center align-items-center">
	
		
	<header  class="d-flex">
		<div class="d-flex flex-column justify-content-center align-items-center">
			<div id="emoji" >&#x1F4D3;</div>
		</div>
		<div class="flex-fill  text-center ">
			<h1>오늘 먹을 메뉴 </h1>
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
				가능여부 : <%=msg %>	
			</div>
		</div>	
			
		<form action="/diary/lunchOne.jsp" method="post">
			<div class="d-flex justify-content-center">
				<div class="me-5">
					<label class="me-3">메뉴 입력한 날짜 확인</label>
					<input type="date" name="checkDate"  id="smallInput" >
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
			<%
				if(checkDate != ""){
					// 선택된 날짜에 메뉴가 없으면
					if(!rs2.next()){
						msg = "메뉴 선택이 가능한 날짜 입니다.";
			%>
						<form action="./lunchOne.jsp" method="post">
							<input type="radio" name="menu"  value="중식">중식
							<input type="radio" name="menu"  value="일식">일식
							<input type="radio" name="menu" value="양식">양식
							<input type="radio" name="menu" value="한식">한식	
							<button type="submit">투표하기</button>					
						</form>
			<%
					// 선택된 날짜에 메뉴가 있으면
					}else{			
			%>	
						<form action="./deleteLunch.jsp" method="post">
							<input type="hidden" name= "selectedMenu" value="<%=rs2.getString("menu")%>"> <%=rs2.getString("menu")%>
							<input type="hidden" name= "checkedDate" value="<%=checkDate%>">
							<button type="submit">삭제</button>
						</form>							
			<%
						
					}
				}
			%>
	</main>
</body>
</html>