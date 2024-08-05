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
	//System.out.println(stmt1);
	
%>

<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	<link rel="icon" type="image/png" href="image/diary.jpeg">
	<meta charset="UTF-8">
	<title></title>
	<style >
		body{
			font-family: "Dongle", sans-serif;
			font-style: normal;
		}
		header{
			width: 100%;
			margin-top: 50px;
			margin-bottom: 50px;
		}
		main{
			width: 100%;
		}
		a{
			text-decoration: none;
			color: black;
			font-size:25px;
			padding: 10px;
		}
		h1{
			color: black;
			font-size: 100px;
		}
		div{
			font-size: 40px;
		}
		button{
			padding: 0px;
			margin-right: 20px;	
		}
		#contents{
			padding: 20px;
			width: 1000px;
			border: 1px solid black;
		}
		#commentDiv{
			max-height: 400px;
			width : 100%;
			overflow-y: auto;
		}
		#commentBtn{
			font-size: 30px;
		}
		#commentMaxDiv{
			max-width: 500px;
			 word-break: break-all;
		}
		#createDate{
			font-size: 30px;
		}
		
	</style>
</head>
<body>
	<header class="d-flex justify-content-center ">
		<h1>오늘의 일기</h1>
	</header>
	
	<main class="d-flex justify-content-center" >
	
		<!-- 일기 상세 DIV -->
		<div id="contents" class="rounded-4">
			<%
				if(rs2.next()){
			%>
				<div class='d-flex justify-content-between'>
					 <div>날짜 : <%=rs2.getString("diary_date")%></div>
					<div>날씨 : <%=rs2.getString("weather")%></div>
				</div>
				<hr>
				<div class='d-flex justify-content-between'>
					 <div>제목 : <%=rs2.getString("title")%></div>
					 <div>기분: <%=rs2.getString("feeling") %></div>
				</div>
					<hr>
					 <div>내용 : <%=rs2.getString("content")%></div>
				<hr>
			<%	
				}
			%>
				<div class="text-center">
					<button class="btn btn-outline-dark">
						<a href="./diary.jsp">다이어리로</a>
					</button >
					<button class="btn btn-outline-dark">
						<a href="./updateDiaryForm.jsp?diaryDate=<%=rs2.getString("diary_date")%>">수정하기</a>
					</button>
					<button class="btn btn-outline-dark">
						<a href="./deleteDiaryAction.jsp?diaryDate=<%=rs2.getString("diary_date")%>">삭제하기</a>
					</button>
					<button class="btn btn-outline-dark">
						<a href="./diaryList.jsp">게시판으로</a>
					</button >
				</div>
		</div>
		
		<!-- 댓글 DIV -->
		<div class="ms-2 d-flex flex-column justify-content-center align-items-center border border-black rounded-4" >
			<div id="commentDiv">
				<%
					String sql3 = "SELECT comment_no commentNo,  diary_date diaryDate ,memo, create_date createDate FROM comment WHERE diary_date = ?";
					PreparedStatement stmt3 = null;
					ResultSet rs3 = null;
					
					stmt3 = conn.prepareStatement(sql3);
					stmt3.setString(1, diaryDate);
					rs3 = stmt3.executeQuery();
				%>
		
				<%
					while(rs3.next()){
				%>
					<div  class="d-flex">
						<div class="p-2 flex-grow-1"  id="commentMaxDiv">
							<%=rs3.getString("memo") %>
						</div>
						<div class="mt-3  p-2" id="createDate">
							<%=rs3.getString("createDate") %>
							<a href="./deleteComment.jsp?commentNo=<%=rs3.getString("commentNo")%>&diaryDate=<%=rs3.getString("diaryDate")%>">삭제</a>
						</div>
					</div>
					<hr>
				<%	
					}
				%>
			</div>
			<!-- 댓글 추가 폼 -->
			<div>
				<form name="commentForm" action="./addCommentAction.jsp"  method="post" class="d-flex justify-content-center" onsubmit="return validateCommentForm()">
					<input type="hidden"  name="diaryDate" value=<%=diaryDate %>>
					<textarea rows="2" cols="40" name="memo" class="ms-2 mb-2"></textarea>
					<button type="submit"  id="commentBtn" class="mb-2">입력</button>
				</form>
			</div>
		</div>
	</main>
	<script>
		function validateCommentForm() {
			let memo = document.forms["commentForm"]["memo"].value;
			if (memo.trim() == "") {
				alert("댓글을 입력하세요.");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>