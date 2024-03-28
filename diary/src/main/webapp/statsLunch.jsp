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
	
	
	rs1.close();
	stmt1.close();

%>

<%
/*
	SELECT menu, COUNT(*) 
	FROM  lunch
	GROUP BY menu
	ORDER BY COUNT(*) DESC;

*/
	String sql2 = "SELECT menu, COUNT(*) cnt  FROM lunch GROUP BY menu";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	
	stmt2 =	conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>statsLunch</h1>
	
		<%
			double maxHeight = 500;
			double totalCnt = 0; 
			while(rs2.next()){
				totalCnt += rs2.getInt("cnt");
			}
		
			rs2.beforeFirst();
		%>
		<div>
			전체 투표수 : <%=(int)totalCnt %>
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