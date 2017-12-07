<%@page import="com.shengsiyuan.Util"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'home.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <h1>投票问题列表：</h1>
    <h3>1.<a href="question.jsp?<%=Util.QUESTION_NAME %>=<%=Util.QUESTION_1%>"><%=Util.QUESTION_1%></a>？</h3>
    <h3>2.<a href="question.jsp?<%=Util.QUESTION_NAME %>=<%=Util.QUESTION_2%>"><%=Util.QUESTION_2%></a>？</h3>
    <h3>3.<a href="question.jsp?<%=Util.QUESTION_NAME %>=<%=Util.QUESTION_3%>"><%=Util.QUESTION_3%></a>？</h3>
    <h3>4.<a href="question.jsp?<%=Util.QUESTION_NAME %>=<%=Util.QUESTION_4%>"><%=Util.QUESTION_4%></a>？</h3>
  </body>
</html>
