<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
//session.removeAttribute("longinMember");

session.invalidate(); // 기존 세션공간을 초기화(포멧)
System.out.println(session.getId() + "<---- session.invalidate() 호출 후 확인하기 ");
response.sendRedirect("/diary/loginForm.jsp");

%>