<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(session.getAttribute("userId") == null){
			out.println("<a href='login.jsp'>로그인</a>");
		} else {
			String userId = (String)session.getAttribute("userId");
			out.println(userId + "님 반갑습니다<br>");
			out.println("<a href='logout.jsp'>로그아웃</a>");
		}
	%>
</body>
</html>