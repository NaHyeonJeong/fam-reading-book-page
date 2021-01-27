<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="familyBookrpt.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	System.out.println(">>> dbCon.jsp - start");
%>
<%
Connection con = null;
/*
PreparedStatement 란?
statement를 상속받는 인터페이스로 SQL구문을 실행시키는 기능을 갖는 객체
PreCompiled된 SQL문을 표현 즉, statement객체는 실행시 sql명령어를 지정하여 여러 sql구문을 하나의 statement객체로 수행이 가능하다.(재사용 가능)
하지만, preparedStatement는 객체 생성시에 지정된 sql명령어만을 실행할수 있다.(다른 sql구문은 실행못함 ->재사용 못함)
*/
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;

DBAgent.loadConnect();
con = DBAgent.getCon();
%>
</body>
</html>