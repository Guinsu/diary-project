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
	
	String diaryDate = request.getParameter("diaryDate");
		
	//디버깅
	//System.out.println(diaryDate);
	String sql2 = "SELECT diary_date, feeling, title, weather, content , update_date, create_date FROM diary WHERE diary_date =?";
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://13.124.239.48:3306/diary", "root", "1q2w3e4r!!");
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 =	conn.prepareStatement(sql2);
	stmt2.setString(1, diaryDate);
	rs2 = stmt2.executeQuery();
	
	
	//디버깅
	System.out.println(rs2);
	
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<title>addDiaryForm</title>
	<link rel="icon" type="image/png" href="image/diary.jpeg">
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
		#emoji{
			width:80px;
			height:80px;
			font-size: 70px;
		}
		.inputType{
			width: 40px;
			height: 20px;
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
			<form name="diaryForm" action="/diary/updateDiaryAction.jsp" method="post" onsubmit="return validateForm()">
				<div class="mb-2 d-flex justify-content-between"  >
					<label>날짜  : </label>
					<input type="text" value=" <%=diaryDate %>" readonly="readonly"  name="diaryDate" id="yo">
				</div>
				<div class="mb-2 d-flex justify-content-between" >
					<label>제목 : </label>
					<input type="text" name="title" id="title"  value="<%=rs2.getString("title") %>">
				</div>
				<div class="d-flex" >
					<div class="p-2 flex-fill">
						<label>날씨 : </label>
						<select name="weather" ">
							<option value="맑음" <%=rs2.getString("weather").equals("맑음") ?  "selected" : "" %>>맑음</option>
							<option value="흐림" <%=rs2.getString("weather").equals("흐림") ?  "selected" : "" %>>흐림</option>
							<option value="비" <%=rs2.getString("weather").equals("비") ?  "selected" : "" %>>비</option>
							<option value="눈" <%=rs2.getString("weather").equals("눈") ?  "selected" : "" %>>눈</option>
						</select>
					</div>
					<div class="p-2 flex-fill" id="emotion">
						<label>감정 : </label>    
						<input type="radio"  value="&#128538" <%=rs2.getString("feeling").equals("😚") ? "checked" : "" %> name="emojis" class="inputType">&#128538
						<input type="radio"  value="&#128545" <%=rs2.getString("feeling").equals("😡") ? "checked" : "" %> name="emojis"  class="inputType">&#128545
						<input type="radio"  value="&#128557" <%=rs2.getString("feeling").equals("😭") ? "checked" : "" %> name="emojis"  class="inputType">&#128557
						<input type="radio"  value="&#128529" <%=rs2.getString("feeling").equals("😑") ? "checked" : "" %> name="emojis" class="inputType">&#128529
					</div>
				</div>
			
				<div class="mb-2 d-flex justify-content-between" >
					<label class="">내용 : </label>
					<textarea rows="7" cols="63" name="content" ><%=rs2.getString("content") %></textarea>
				</div>
				<div  class="d-flex justify-content-center ">
					<button type="submit" class="mt-1 btn btn-outline-dark"  id="writingDiaryBtn">수정</button>
					<a href="./diaryOne.jsp?diaryDate= <%=diaryDate %>" id="backDiaryAtag" class="btn btn-outline-dark">뒤로가기 </a>
				</div>
			</form>
		<%
			}
		%>
	</main>
	<script>
		function validateForm() {
			let diaryDate = document.forms["diaryForm"]["diaryDate"].value;
			let title = document.forms["diaryForm"]["title"].value;
			let content = document.forms["diaryForm"]["content"].value;
			let emotions = document.forms["diaryForm"]["emojis"];
			let emotionChecked = false;
			
			if (diaryDate == "") {
				alert("날짜를 입력하세요.");
				return false;
			}
			if (title == "") {
				alert("제목을 입력하세요.");
				return false;
			}
			if (content == "") {
				alert("내용을 입력하세요.");
				return false;
			}
	
			for (let i = 0; i < emotions.length; i++) {
				if (emotions[i].checked) {
					emotionChecked = true;
					break;
				}
			}
	
			if (!emotionChecked) {
				alert("감정을 선택하세요.");
				return false;
			}
			
			return true;
		}
	</script>
</body>
</html>