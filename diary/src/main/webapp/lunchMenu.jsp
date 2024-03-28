<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	String menu = request.getParameter("menu");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<div>오늘 메뉴는 <%=menu %> 입니다.</div>
</body>
</html>