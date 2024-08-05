<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="java.net.URLEncoder"%>
<%@ page import="java.util.Calendar"%>

<%
	//session 로그인 여부 확인
	String loginMember = (String)(session.getAttribute("loginMember"));
	if(loginMember == null){
		String errMsg =  URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요.", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg=" +errMsg);
	}
	
	//선택된 년,월
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");	
	
	Calendar firstDate = Calendar.getInstance();
	
	// traget된 year,month 가 없을 때 오늘 날짜 기준의 년 / 월을 구한다. (페이지 첫 진입시 )
	if(targetYear == null ||  targetMonth == null){
		firstDate.set(Calendar.DATE, 1); 
	}else{
	// 선택된 년,월,일을 구한다.
		firstDate.set(Calendar.YEAR, Integer.parseInt(targetYear)); 
		firstDate.set(Calendar.MONTH, Integer.parseInt(targetMonth));   
		firstDate.set(Calendar.DATE, 1);   
	}
	
	//매 월마다 1일 앞의 빈칸을 구한다
	int yo = firstDate.get(Calendar.DAY_OF_WEEK);
	// 요일 값에서 -1을 하면 1일 앞의 빈 공백을 알 수 있다.
	int preBlank = yo - 1;
	
	//fistDate가 가질 수 있는 가장 큰 숫자(마지막날) 을 구한다.
	int lastDate = firstDate.getActualMaximum(Calendar.DATE); 
	int afterBlank = 0;
	
	// 전체 div의 개수는 7로 나누어 떨어져야한다. 달력을 보면 총 42개의 칸으로 이루어져 있기 때문이다.
	if((preBlank + lastDate + afterBlank)%7 != 0) {
		afterBlank = 7 - (preBlank + lastDate + afterBlank)%7;
	}

	//전체 div의 개수구하기
	int totalTd = preBlank + lastDate + afterBlank;
	
	int year = firstDate.get(Calendar.YEAR); 
	int month = firstDate.get(Calendar.MONTH); 
	
	
	// tYear 와 tMonth에 해당되는 diary 목록을 추출
	String sql2 = "SELECT day(diary_date) day, left(title,5) title, diary_date FROM diary WHERE YEAR(diary_date)=? AND MONTH(diary_date)=?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://13.124.239.48:3306/diary", "root", "1q2w3e4r!!");
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1,  year);
	stmt2.setInt(2, month+1);
	
	//디버깅
	//System.out.println(stmt2);
	
	rs2 = stmt2.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Annie+Use+Your+Telescope&family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400;1,700&family=Dongle&family=Marmelad&family=Newsreader:ital,opsz,wght@0,6..72,200..800;1,6..72,200..800&display=swap" rel="stylesheet">
	
	
	<meta charset="UTF-8">
	<title></title>
	<style >
		body{
			width:100%;
			height:100%;
		 	font-family: "Dongle", sans-serif;
  			font-style: normal;
		}
		a{
			text-decoration: none;
			color: black;
			font-size:20px;
		}
		h1{
			color: black;
			font-size: 100px;
		}
		h2{
			font-size: 30px;
		}
		tr{
			text-align: center;
			font-size: 22px;
		}
		td{
			width:100px;
			height:87px;
			
		}

		.days{
			vertical-align : top;
		}
		
		.titleDiv{
			max-width: 100px;
			max-height:20px;
			
		}
		
		#logoutBtn{
			width: 100px;
			height:100px;
			margin: 10px;
		}
		#famousSayingDiv{
			padding: 1%;
			margin-right: 1px;
			font-size: 30px;
		}
		#emoji{
			width:110px;
			height:110px;
			font-size: 100px;
		}
		#nextMonth,#previousMonth{
			margin-bottom: 10px;
			margin-right: 20px;
			padding: 0px;
			width: 100px;
		}
		#writingDiaryAtag{
			margin-right :0px;
			padding-right:450px;
			padding-left: 450px;
		}
		
		#showList{
			font-size: 40px;
			padding: 10px;
			width: 400px;
		}
		#diaryDiv{
			height: 86%;
			overflow: auto;
		}
		#makeDiaryA{
			padding-right: 50px;
			padding-left: 50px;
		}
		
	</style>
</head>
<body>
	<header  class="d-flex">
		<div class="d-flex flex-column justify-content-center align-items-center">
			<div id="emoji" >&#x1F4D3;</div>
		</div>
		<div class="flex-fill  text-center ">
			<h1>I'm your Diary </h1>
		 </div>
		<div class="d-flex flex-column justify-content-center align-items-center">
			<div>
				<button type="button"  id="logoutBtn" class="btn btn-outline-dark rounded-circle" >
					<a href="./logoutAction.jsp"> 로 그 아 웃</a>
				</button>
			</div>
		</div>
	</header>
	

	<main class="border d-flex ">
		<div class="border  border-black d-flex flex-column justify-content-center align-items-center" id="famousSayingDiv" >
			<div class="d-flex flex-column justify-content-center p-2 flex-grow-1 ">
				<div>일기는 오늘을 위한 기록이 아니라, 내일을 위한 준비다.</div>
				<div class="d-flex justify-content-center"> - 앤 프랭크</div>
			</div>
			<div class="p-2 d-flex flex-column justify-content-center align-items-center">
				<div>
					<a href="./lunchOne.jsp" id="showList" class="mb-3 btn btn-outline-dark">점심 메뉴 고르기</a>
				</div>
				<div>
					<a href="./diaryList.jsp" id="showList" class="btn btn-outline-dark">게시판처럼 보기 </a>
				</div>
			</div>
		</div>
		<div class="border p-2 flex-grow-1  border-black"  id="diaryDiv">
			<div class=" text-center">
				<h2><%=year%>년 <%=month+1%>월</h2>
			</div>		
			<div class=" text-center" style="display: flex; justify-content: space-between;">
				<div>
					<button  class="btn btn-outline-secondary"  id="previousMonth">
						<a href="./diary.jsp?targetYear=<%=year%>&targetMonth=<%=month-1%>" class="p-1" >이전달</a>
					</button>
					<button  class="btn btn-outline-secondary" id="nextMonth" >
						<a href="./diary.jsp?targetYear=<%=year%>&targetMonth=<%=month+1%>" class="p-1"  >다음달</a>
					</button>
				</div>
				<div>
					<button class="mt-1 btn  btn-outline-dark  border border-black border-2" style="width: 200px; margin-bottom: 10px;" ><a href="./addDiaryForm.jsp" id="makeDiaryA">일기 쓰기</a></button>
				</div>
			</div>
			<table border="1" width="100%" class=" table-border">
			<tr >
				<th  class="border border-black">일</th>
				<th  class="border border-black">월</th>
				<th  class="border border-black">화</th>
				<th  class="border border-black">수</th>
				<th  class="border border-black">목</th>
				<th  class="border border-black">금</th>
				<th  class="border border-black">토</th>
			</tr>
			<tr>
				<%
				
					for(int d=1; d<=totalTd; d++){
				%>
						<td  class="border border-black days">
							<% 
								int t = d-preBlank;
								if( t >= 1 && t <= lastDate) {
							%>
								<%=t%>
								
							<%
								//현재 날짜 (d-preBlank)의 일기가 rs2 목록에 있는지 비교 
									while(rs2.next()){
										if(rs2.getInt("day") == ( d-preBlank)){
							%>
											<div class="titleDiv d-flex justify-content-center">
												<a href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diary_date")%>">											
													<%=rs2.getString("title") %>.....
												</a>
											</div>
							<%				
											break;
										}
									}
									rs2.beforeFirst(); 
								} else {
							%>
									&nbsp;
							<%		
								}
							%>
						</td>
				<%
						if(d%7 == 0 && d < totalTd) {
				%>
							</tr>
							<tr>
				<%			
							}
					}
				%>
				</tr>
			</table>
		</div>
	</main>
</body>
</html>