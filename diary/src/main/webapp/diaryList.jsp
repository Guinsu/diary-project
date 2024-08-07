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

	// 게시판 형식으로 다이어리 내용 출력리스트 모듈
	int currentPage = 1;
	if(request.getParameter("currentPage") != null ){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	int rowPerPage = 10;
	int startRow = (currentPage-1) * rowPerPage  ;//1-0, 2-10, 3-20, 4-30;
	
	String searchWord = "";
	
	if(request.getParameter("searchWord") != null ){
		searchWord = request.getParameter("searchWord");
	}
	
	String sql2 = "SELECT diary_date diaryDate, title FROM diary WHERE title LIKE ? ORDER BY diary_date DESC LIMIT ?,?";
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://13.124.239.48:3306/diary", "root", "1q2w3e4r!!");
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 =	conn.prepareStatement(sql2);
	stmt2.setString(1,"%"+searchWord+"%");
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	rs2 = stmt2.executeQuery();
	
	// lastPage 모듈
	String sql3 = "SELECT count(*) cnt FROM diary WHERE title LIKE ?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 =	conn.prepareStatement(sql3);
	stmt3.setString(1,"%"+searchWord+"%");
	rs3 = stmt3.executeQuery();
	
	int totalRow = 0;
	
	if(rs3.next()){
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
	//디버깅
	//System.out.println(currentPage + " <----currentPage ");
	//System.out.println(totalRow + " <----totalRow ");
	//System.out.println(lastPage + " <----lastPage ");
	
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
		a{
			text-decoration: none;
			color: black;
		}
		body{
			font-family: "Dongle", sans-serif;
			font-style: normal;
		}
		main{
			font-size: 35px;
		}
		input{
			width: 400px;
		}
		h1{
			font-size: 120px;
		}
		table {
			width: 500px;
		  	border: 1px solid black;
		  	border-radius: 10px;
		}
		.btnGroup{
			margin-right: 20px;
			font-size: 30px;
			border: 1px solid black;
			border-radius: 10px;
		}
	</style>
</head>
<body>
	<header >
		<h1 class="text-center" >일기 목록 </h1>
	</header>
	<main class="d-flex flex-column justify-content-center align-items-center" >
		<table>
			<tr>
				<th>날짜</th>
				<th>제목</th>
			</tr>
			<%
				while(rs2.next()){
			%>
				<tr>
					<td><%=rs2.getString("diaryDate") %></td>
					<td>
						<a href="./diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>" ><%=rs2.getString("title") %></a>
					</td>
				</tr>
			<%	
				}
			%>
		</table>
		
		<div class="mt-3 btn-group me-2" role="group" aria-label="Second group"  >
			<button type="button" class="btn btn-secondary btnGroup"  >
				<%
					if(currentPage > 1){
				%>
					<a href="./diaryList.jsp?currentPage=<%=currentPage -1%>">이전</a>
				<%
					}else{
				%>
					<a style="color: grey; cursor: not-allowed; ">이전</a>
				<%
					}
				%>
			</button>
			<button type="button" class="btn btn-secondary btnGroup"><%=currentPage%></button>
			<button type="button" class="btn btn-secondary btnGroup">
				<%if(currentPage < lastPage ){
				%>
					<a href="./diaryList.jsp?currentPage=<%=currentPage +1%>">다음</a>		
				<%
				}else{
				%>
					<a style="color: grey; cursor: not-allowed;  ">다음</a>
				<%
				}
				%>
			</button>
		  </div>
		
		<form action="/diary/diaryList.jsp" method="get" class="mt-3">
			<div>
				제목검색 : 
				<input type="text" name="searchWord">
				<button type="submit">검색</button>
			</div>
		</form>
	</main>
</body>
</html>