<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="familyBookrpt.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1.0">
<link href="style.css" rel="stylesheet">
<script>
    function pageChange(){
        document.getElementById('rwForm').action ="deleteBookrpt.jsp";
        document.getElementById('rwForm').submit();
    }
    function gotoMain(){
        window.location.href = 'main.jsp';
    }
    function formSubmit(){
        document.getElementById('rwForm').submit();
    }
</script>
<title>독서록 페이지</title>
</head>
<body>
<%@ include file="dbCon.jsp" %>
	<%
    	String reportNo = request.getParameter("reportNo");
    	System.out.println("독서록번호>> " + reportNo);
    	String title = "";
    	title = !reportNo.equals("0") ? "독서록 수정/삭제 페이지" :  "독서록 작성 페이지"; 
    %>
	<header id="rwHeader">
        <h1><%=title %></h1>
    </header>
    <article id="rwArticle">
    <%
        String famID = "";
        int bookNo = -1;
        String reportTitle = "";
        String reportContents = ""; 
        String readPeriod = "";
        String registDate = "";
        //동적으로 페이지 바꾸기 위한 변수
        String actionLink = "";
        String readonly = "readonly";
        String udBtnHidden = "";
        String addBtnHidden = "";
        
        if(!reportNo.equals("0")){
            //데이터를 가져와서 보여준다
            //수정과 삭제를 하기 위한 전 단계랄까...
            addBtnHidden = "display:none;";
            sql = "SELECT FAM_ID, BOOK_NO, REPORT_TITLE, REPORT_CONTENTS, READ_PERIOD, REGIST_DATE ";
            sql += "FROM book_report ";
            sql += "WHERE REPORT_NO = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, reportNo);
            rs = pstmt.executeQuery();
            rs.next();
            
            famID = rs.getString(1);
            bookNo = rs.getInt(2);
            reportTitle = rs.getString(3);
            reportContents = rs.getString(4);
            readPeriod = rs.getString(5);
            registDate = rs.getString(6);
            
            actionLink ="updateBookrpt.jsp";//데이터 수정
            pstmt.close();
            con.close();
        }
        else{
            //독서록 번호가 있으면 빈칸으로 보여주고 insert진행 가능
            readonly = "";
            udBtnHidden = "display:none;";
            
            actionLink ="insertBookrpt.jsp";//데이터 입력
            System.out.println("actionLink  >>  " + actionLink);
        }
    %>
        <form id="rwForm" method="GET" action=<%=actionLink %>>
            <table>
                <tr>
                    <td class="tdTitle"><label style="<%=udBtnHidden%>">독서록번호 </label></td>
                    <td class="tdData"><input <%=readonly %> style="<%=udBtnHidden%> width: 20%;" type="text" name="rwReportNo" value=<%=reportNo %>> <br/></td>
                </tr>
                <tr>
                    <td class="tdTitle"><label>가족ID </label></td>
                    <td class="tdData"><input <%=readonly %> type="text" style="width: 20%;" name="rwFamID" value=<%=famID %>></td>
                </tr>
                <tr>
                    <td class="tdTitle"><label>도서번호 </label></td>
                    <td class="tdData"><input <%=readonly %> type="text" style="width: 20%;" name="rwBookNo" <%=bookNo==-1?"value=''":"value="+ bookNo %>></td>
                </tr>
                <tr>
                    <td class="tdTitle"><label>독서록제목</label></td>
                    <td class="tdData"><input type="text" id="rwReportTitleid" style="width: 20%;" name="rwReportTitle" value=<%=reportTitle %>></td>
                </tr>
                <tr>
                    <td class="tdTitle"><label>독서록내용</label></td>
                    <td class="tdData"><textarea name="comments" rows="6" cols="50"><%=reportContents %></textarea></td>
                </tr>
                <tr>
                    <td class="tdTitle"><label>독서기간</label></td>
                    <td class="tdData"><input type="text" name="rwReadPeriod" value=<%=readPeriod %>></td>
                </tr>
                <tr>
                    <td class="tdTitle"><label>등록일자</label></td>
                    <td class="tdData"><input type="date" name="rwRegistDate" value=<%=registDate %>></td>
                </tr>
            </table>
        </form>
    </article>
    <nav id="rwNav">
    	<!-- 공통 버튼 -->
        <input type="button" name="listPageBtn" value="목록" onclick="gotoMain();"/>
        <!--메인 페이지에서 '글쓰기'버튼을 누르면 보여지는 버튼들-->
        <input type="button" style="<%=addBtnHidden %>" id="addBtn" name="registerBtn" onclick="formSubmit();" value="등록"/>
        <!--메인 페이지에서 '독서록 목록중에 독서록 제목'을 누르고 들어오면 보여지는 버튼들-->
        <input type="button" style="<%=udBtnHidden %>" id="updateBtn" name="" onclick="formSubmit();" value="수정"/>
        <input type="button" style="<%=udBtnHidden %>" id="deleteBtn" onclick="pageChange();" value="삭제"/>
    </nav>
    <footer id="rwFooter">
        <h4>&copy;NA HYEON JEONG</h4>
    </footer>
</body>
</html>