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
	
	// 메뉴 테이블에서 그룹화하고 각 메뉴가 몇 번 등장했는지 보여주는 쿼리문
	String sql2 = "SELECT menu, COUNT(*) cnt  FROM lunch GROUP BY menu";
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://13.124.239.48:3306/diary", "root", "1q2w3e4r!!");
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	
	stmt2 =	conn.prepareStatement(sql2);
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
	<link rel="icon" type="image/png" href="image/diary.jpeg">
	<meta charset="UTF-8">
	<title></title>
	<style >
		body{
			font-family: "Dongle", sans-serif;
			font-style: normal;
		}
		h1{
			font-size: 150px;
		}
		div{
			font-size: 100px;
		}
		table{
			width: 700px;
			height: 600px;
			 border-collapse: collapse;
			 border-radius: 30px;
			 border-style: hidden;
			 box-shadow: 0 0 0 1px #000;
		}
		td{
			font-size: 100px;
			text-align: center;
		}
		#goBackTag{
			text-decoration: none;
			color : black;
			border: 1px solid black;
			font-size: 50px;
			margin-left: 40px;
		}
	</style>
</head>
<body class="d-flex flex-column justify-content-center align-items-center ">
	<h1>점심메뉴 통계 </h1>
		<%
			double maxHeight = 500;
			double totalCnt = 0; 
			while(rs2.next()){
				totalCnt += rs2.getInt("cnt");
			}
		
			rs2.beforeFirst();
		%>
		<div>
			  투표수 : <%=(int)totalCnt %>
			  <a href="./lunchOne.jsp"   class="btn btn-outline-secondary"  id="goBackTag">뒤로가기</a>
		</div>
	<table border="1">
		<tr>
		<%
			String[] c = {"#C62828","#FFCDD2","#0288D1","#F57C00","#5D4037", "#37474F", "#AB47BC" };
			int i =0;
			while(rs2.next()){	
				int h =(int)(maxHeight * (rs2.getInt("cnt")/totalCnt));
		%>
			<td style="vertical-align: bottom;">
				<div style=" height: <%=h%>px;  background-color: <%=c[i] %>;  text-align: center;">
						<%=rs2.getInt("cnt") %>
				</div>
			</td>
		<%	
				i++;
			}
		%>
		</tr>
		<tr>
		<%
		//rs2의 위치를 다시 처음으로
			rs2.beforeFirst();
			while(rs2.next()){	
		%>
			<td><%=rs2.getString("menu") %></td>
		<%	
			}
		%>
		</tr>
	</table>
</body>
</html>