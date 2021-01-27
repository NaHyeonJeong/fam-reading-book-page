<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1.0">
<link href="style.css" rel="stylesheet">
<title>로그인</title>
</head>
<body>
	<header id="loginHeader">
        <h1>로그인</h1>
    </header>
    <article id="loginArticle">
        <form action="loginOk.jsp" method="POST" id="loginForm"> <!-- 실제 기능은 main.jsp에서 일어남 -->
            <label for="userId">ID(아이디)</label>
            <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요"><br>
            
            <label for="userPw">PASSWORD(비밀번호)</label>
            <input type="password" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요"><br>
            
            <input type="submit" value="로그인"/>
            <!-- <button type="submit" id="loginBtn"><a href="main.jsp">로그인</a></button> -->
        </form>
    </article>
    <footer id="loginFooter">
        <h4>&copy;NA HYEON JEONG</h4>
    </footer>
</body>
</html>