<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="familyBookrpt.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1.0">
<link href="style.css" rel="stylesheet">
<title>가족 독서록 관리</title>
</head>
<body>
<%@ include file="dbCon.jsp" %>
<%
	System.out.println("\n>>> main.jsp - START");
%>
	<nav id="mainNav">
		<%
			if(session.getAttribute("userId") == null){
				out.println("<button><a href='login.jsp'>로그인</a></button>");
			} else {
				String userId = (String)session.getAttribute("userId");
				out.println(userId + "님 반갑습니다<br>");
				out.println("<button><a href='logout.jsp'>로그아웃</a></button>");
			}
		%>
		<!-- 
			<button><a href="login.jsp">로그인</a></button>
			<button><a href="">로그아웃</a></button>
		 -->
		
		
	</nav>
	<header id="mainHeader">
		<h1>가족 독서록 관리 시스템</h1>
	</header>
	<article id="mainArticle">
		<form id="articleForm1" method="post">
			<select name="searchParm1">
				<option value="1">전체</option>
				<option value="2">최근1개월</option>
				<option value="3">최근6개월</option>
				<option value="4">최근1년</option>
			</select>
			<select name="searchParm2">
				<option value="1">책이름</option>
				<option value="2">독서록제목</option>
				<option value="3">작성자ID</option>
				<option value="4">내용</option>
			</select>
			<input type="text" name="searchParm3" placeholder="검색할 내용을 입력하세요">
			<button>검색</button>
		</form>
		<table id="mainTable" border="1">
			<thead id="mainTableHead">
				<tr>
					<th>번호</th>
					<th>제 목</th>
					<th>도서명</th>
					<th>작성자명</th>
					<th>작성자ID</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody id="mainTableBody">
			<%
				String searchParm1 = request.getParameter("searchParm1");
				String searchParm2 = request.getParameter("searchParm2");
				String searchParm3 = request.getParameter("searchParm3");
				
				System.out.println("searchParm1 = " + searchParm1);
				System.out.println("searchParm2 = " + searchParm2);
				System.out.println("searchParm3 = " + searchParm3);
				
				if(searchParm1==null) searchParm1="";
				if(searchParm2==null) searchParm2="";
				if(searchParm3==null) searchParm3="";
				
				String whereString1 = "";
				String whereString2 = "";
				switch (searchParm1){
				case "1":
					whereString1 = "";
					break; 
				case "2":
					whereString1 = " AND TR.REGIST_DATE > DATE_ADD(NOW(), INTERVAL -1 MONTH)";
					break;
				case "3":
					whereString1 = " AND TR.REGIST_DATE >= DATE_ADD(NOW(), INTERVAL -6 MONTH)";
					break;
				case "4":
					whereString1 = " AND TR.REGIST_DATE >= DATE_ADD(NOW(), INTERVAL -12 MONTH)";
					break;
				}
				
				searchParm3 = searchParm3.trim();
				if (!searchParm3.equals("")){
					switch (searchParm2){
					case "1":
						whereString2 = " AND TB.BOOK_TITLE LIKE CONCAT('%',?,'%')";
						break;
					case "2":
						whereString2 = " AND TR.REPORT_TITLE LIKE CONCAT('%',?,'%')";
						break;
					case "3":
						whereString2 = " AND TR.FAM_ID = ?";
						break;
					case "4":
						whereString2 = " AND TR.REPORT_CONTENTS LIKE CONCAT('%',?,'%')";
						break;
					}
				}

				sql = "SELECT TR.REPORT_NO, TR.REPORT_TITLE, TB.BOOK_TITLE, TU.FAM_NAME, TR.FAM_ID, TR.REGIST_DATE\n";
				sql+= "FROM BOOK_REPORT TR JOIN FAM_USER TU ON TU.FAM_ID = TR.FAM_ID JOIN BOOK TB ON TB.BOOK_NO = TR.BOOK_NO\n";
				sql+= "WHERE 1=1";
				sql+= whereString1;
				sql+= whereString2;
				
				pstmt = con.prepareStatement(sql);
				if (!searchParm3.equals("")){
					pstmt.setString(1, searchParm3);
				}
				rs = pstmt.executeQuery();
				while (rs.next()) {
					int reportNo = rs.getInt(1);
					String reportTitle= rs.getString(2);
					String bookTitle= rs.getString(3);
					String famName = rs.getString(4);
					String famId = rs.getString(5);
					String registDate= rs.getString(6);
					reportTitle = reportTitle==null ? "제목없음" : reportTitle;
					reportTitle = reportTitle.isEmpty() ? "제목없음" : reportTitle;
					registDate = registDate==null ? "" : registDate;
			%>
				<tr>
					<td><%=reportNo %></td>
					<td><a href="rwpage.jsp?reportNo=<%=reportNo %>"><%=reportTitle %></a></td>
					<td><%=bookTitle %></td>
					<td><%=famName %></td>
					<td><%=famId %></td>
					<td><%=registDate %></td>
				</tr>
			<%
				}
			pstmt.close();
			con.close();
			%>
			</tbody>
		</table>
		<div id="centerButton">
			<button id="rwpageBtn"><a href="rwpage.jsp?reportNo=0">독서록작성</a></button>
		</div>
	</article>
	<footer id="mainFooter">
		<h4>&copy;NA HYEON JEONG</h4>
	</footer>
</body>
</html>