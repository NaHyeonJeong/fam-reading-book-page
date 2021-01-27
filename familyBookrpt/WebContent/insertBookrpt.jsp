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
    function noticeInsert(){
        alert('독서록을 등록하였습니다.\n메인 페이지로 돌아갑니다.');
        document.location.href="main.jsp";
    }
</script>
<title>독서록 저장</title>
</head>
<body onload="noticeInsert();">
<%@ include file="dbCon.jsp" %>
<%
//String reportNo = request.getParameter("rwReportNo"); 독서록 번호는 자동 생성이라서 가져올 필요가 없나...
String famID = request.getParameter("rwFamID");
String bookNo = request.getParameter("rwBookNo");
String reportTitle = request.getParameter("rwReportTitle");
String reportContents = request.getParameter("comments");
String readPeriod = request.getParameter("rwReadPeriod");
String registDate = request.getParameter("rwRegistDate");

sql = "INSERT INTO book_report(FAM_ID, BOOK_NO, REPORT_TITLE, REPORT_CONTENTS, READ_PERIOD, REGIST_DATE) ";
sql += "VALUES(?,?,NULLIF(?,''),?,?,NULLIF(?,''));";

pstmt = con.prepareStatement(sql);
pstmt.setString(1, famID);
pstmt.setString(2, bookNo);
pstmt.setString(3, reportTitle);
pstmt.setString(4, reportContents);
pstmt.setString(5, readPeriod);
pstmt.setString(6, registDate);

int result = pstmt.executeUpdate();
if(result==1)
	System.out.println("DB insert 성공");
else
	System.out.println("DB insert 실패");
pstmt.close();
con.close();
%>
</body>
</html>