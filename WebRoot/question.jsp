<%@page import="org.dom4j.DocumentHelper"%>
<%@page import="org.dom4j.Document"%>
<%@page import="com.shengsiyuan.Util"%>
<%@page import="org.dom4j.Node"%>
<%@page import="org.dom4j.Element"%>
<%@page import="org.dom4j.io.SAXReader"%>
<%@page import="org.dom4j.io.XMLWriter"%>
<%@page import="org.dom4j.io.OutputFormat"%>
<%@ page language="java" import="java.util.*" import="java.io.*"
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8");%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'question.jsp' starting page</title>

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
	<!-- 从URL链接中获取被传递的参数值 -->
	<% String questionName = request.getParameter(Util.QUESTION_NAME); %>
	
	投票问题：<%=questionName %>？

	<form action="result.jsp" method="post">
		<%
			//从XML文件中生成Document对象，如果XML文件不存在，则新建一个
			Document document = Util.generateXMLDoc(request);

			/*
			!!!使用Xpath语法需要添加jaxen-1.1.6.jar 这个依赖包
			方法是在WEB-INF/lib目录下包含这两个文件，然后在Build Path中添加它们
			*/
			
			//通过XPath表达式选取指定的节点（子元素）列表，元素名由通过URL传递过来的参数确定
			String XPATH_Expr = "//" + questionName + "/*";
			List<Node> list = document.selectNodes(XPATH_Expr);
			for(Iterator<Node> iter = list.iterator(); iter.hasNext();)
			{
				//得到子元素，即问题的选项名称
				Element element = (Element) iter.next();
				//从XML文档中获取表单输入类型，确认是radio还是checkbox，将它作为表单的name和type的属性值
				String attrValue = element.attributeValue(Util.INPUT_TYPE);
				//获取元素名，将它作为表单的value的属性值，以及控件的显示名称
				String elementName = element.getName();
				
				//获取用于动态显示的投票次数的文本
				String text = element.getText();
		%>

		<input type="<%=attrValue%>" value="<%=elementName%>" name="<%=Util.OPTION_NAME%>"><%=elementName%> (<%=text%>)<br>
		
		<%
			}
		%>
		
		<!-- 将问题名称传递到下一个页面 -->
		<input type="hidden" name="<%=Util.QUESTION_NAME %>" value="<%=questionName%>">
		<input type="submit" value="提交">
	</form>
</body>
</html>
