<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="familyBookrpt.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="style.css" rel="stylesheet">
<script>
    function noticeDelete(){
        alert('독서록을 삭제하였습니다.\n메인 페이지로 돌아갑니다.');
        document.location.href="main.jsp";
    }
</script>
<title>독서록 삭제</title>
</head>
<body onload="noticeDelete();">
<%@ include file="dbCon.jsp" %>
<%
System.out.println("DB delete 시작");
String reportNo = request.getParameter("rwReportNo");
String famID = request.getParameter("rwFamID");
String bookNo = request.getParameter("rwBookNo");
String reportTitle = request.getParameter("rwReportTitle");
String reportContents = request.getParameter("comments");
String readPeriod = request.getParameter("rwReadPeriod");
String registDate = request.getParameter("rwRegistDate");

sql = "DELETE FROM book_report ";
sql += "WHERE REPORT_NO = ? ;";

pstmt = con.prepareStatement(sql);
pstmt.setString(1, reportNo);

int result = pstmt.executeUpdate();
if(result==1)
	System.out.println("DB delete 성공");
else
	System.out.println("DB delete 실패");
pstmt.close();
con.close();
%>
</body>
</html>