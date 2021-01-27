<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="familyBookrpt.*" %>
<%@ include file="dbCon.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	// request.getParameter를 이용 > 사용자 id, pw를 받음
	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	
	// 쿼리 던짐
	sql = "SELECT FAM_ID, PASSWD FROM fam_user;";
	pstmt = con.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	String dbUserId = "";
	String dbUserPw = "";
	while (rs.next()) { // db의 정보를 가져옴
		dbUserId = rs.getString(1);
		dbUserPw = rs.getString(2);
		if(userId != null && userId.equals(dbUserId)) { // id 일치
			if(userPw != null && userPw.equals(dbUserPw)) { // id + pw 일치 == 로그인 성공
				// 로그인에 성공하면 사용자 아이디를 세션 변수에 저장
				session.setAttribute("userId", userId);
				response.sendRedirect("main.jsp");
			}
		}
		// java.lang.IllegalStateException: Cannot call sendRedirect() after the response has been committed 이거 뭔지 공부해
		
	}

%>
