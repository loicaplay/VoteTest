<%@page import="org.dom4j.Element"%>
<%@page import="org.dom4j.Node"%>
<%@page import="com.shengsiyuan.Util"%>
<%@page import="java.io.FileWriter"%>
<%@page import="org.dom4j.io.XMLWriter"%>
<%@page import="org.dom4j.Document"%>
<%@page import="org.dom4j.io.SAXReader"%>
<%@page import="java.io.File"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

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

<title>My JSP 'question1_result.jsp' starting page</title>

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
	<% String questionName = request.getParameter(Util.QUESTION_NAME); %>

	<h2>问题：<%=questionName %>？投票结果是：</h2>

	<%
		//从已有的XML文件中获取文档对象
		Document document = Util.getXMLDoc(request);

		//得到投票选项的列表
		String XPATH_Expr = "//" + questionName + "/*";
		List<Node> optionList = document.selectNodes(XPATH_Expr);

		//将从输入控件中获得的选项值存入到一个数组中
		String[] optionName = request.getParameterValues(Util.OPTION_NAME);
		for(Iterator<Node> iter = optionList.iterator(); iter.hasNext();)
		{
			Element element = (Element) iter.next();
			
			//获取单个的投票选项、投票被选中的次数
			String elementName = element.getName();
			String text = element.getText();
			int textAsInt = Integer.parseInt(text);

			//如果提交时选中了至少一个选项，则将这个选项的投票次数增加，否则不增加
			if(optionName != null)
			{
				for(int i = 0; i < optionName.length; i++)
				{
					if(elementName.equals(optionName[i]))
					{
						textAsInt++;
						element.setText(textAsInt + "");
					}
				}
			}
			
	%>
	<h4><%=elementName%>被选中的次数是：<%=textAsInt%></h4>
	<%
		}
			
		//将更新后的XML文档对象从内存中写入到文件
		Util.write2XML(request, document);
	%>

</body>
</html>
