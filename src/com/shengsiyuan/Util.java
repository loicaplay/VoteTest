package com.shengsiyuan;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

/**
 * 这个工具类提供了用XML生成投票问题和选项的方法模板，以及存取XML Document对象和File对象的静态方法，
 * 通过以下静态常量和createXMLContent()方法，可以方便的管理投票内容，如增改投票的问题和选项，只需要
 * 修改以下的成员变量即可，而不必操作具体JSP执行代码
 * @author louis
 *
 */
public class Util
{
	/**
	 * 用于存取投票数据的XML文件，该常量应用于这个类中的其他方法，在具体执行代码中是不可见的
	 */
	public static final String XML_FILE_NAME = "voteData.xml";
	
	/**
	 * 用于动态的获取具体的问题名称
	 */
	public static final String QUESTION_NAME = "questionName ";
	
	/**
	 * 用于输入控件的统一的参数名，以供从request中获取参数值
	 */
	public static final String OPTION_NAME = "optionName ";
	
	/**
	 * 用于作为XML元素的问题选项的属性名，其值是输入控件的名称，也是具体输入控件的类型（如单选或复选框）
	 */
	public static final String INPUT_TYPE = "inputType";
	public static final String RADIO = "radio";
	public static final String CHECKBOX = "checkbox";
	
	/**
	 * XML的根元素名称，不建议修改它
	 */
	public static final String QUESTION_LIST = "问题列表";
	
	public static final String QUESTION_1 = "过年回家吗";
	public static final String QUESTION_2 = "回家待几天";
	public static final String QUESTION_3 = "会参与哪些娱乐项目";
	public static final String QUESTION_4 = "对哪些技术感兴趣";
	
	/**
	 * 初始化一个XML内容模板，以生成一个Document实例，该实例包含了预定义的String常量的问题集
	 * 通过更改在Util包中定义的常量值，可以改变为其他问题，但是问题选项需要手动在本方法中修改，
	 * 包括选项的input控件的类型。
	 * @return 生成的XML文件内容
	 */
	public static Document createXMLContent()
	{
		Document document = DocumentHelper.createDocument();
		Element root = document.addElement(QUESTION_LIST);
		
		Element question1 = root.addElement(QUESTION_1);
		question1.addElement("回家").addAttribute(INPUT_TYPE, RADIO).setText("0");
		question1.addElement("不回家").addAttribute(INPUT_TYPE, RADIO).setText("0");
		
		Element question2 = root.addElement(QUESTION_2);
		question2.addElement("一到两天").addAttribute(INPUT_TYPE, RADIO).setText("0");
		question2.addElement("三到四天").addAttribute(INPUT_TYPE, RADIO).setText("0");
		question2.addElement("五到七天").addAttribute(INPUT_TYPE, RADIO).setText("0");
		question2.addElement("七天以上").addAttribute(INPUT_TYPE, RADIO).setText("0");
		
		Element question3 = root.addElement(QUESTION_3);
		question3.addElement("拜年").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question3.addElement("吃饺子").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question3.addElement("打麻将").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question3.addElement("打游戏").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question3.addElement("陪家人").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question3.addElement("吃喝睡").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		
		Element question4 = root.addElement(QUESTION_4);
		question4.addElement("Java").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question4.addElement("JavaScript").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question4.addElement("Python").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question4.addElement("数据库").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question4.addElement("算法").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		question4.addElement("前端技术").addAttribute(INPUT_TYPE, CHECKBOX).setText("0");
		
		return document;
	}
	
	/**
	 * 通过读取XML文件生成XML文档。如果XML文件不存在，则通过Util.createXMLContent()方法创建一个新的XML实例。
	 * @param request 通过传递的request以处理同一个request。
	 * @return 生成的文档对象。
	 */
	public static Document generateXMLDoc(HttpServletRequest request)
	{
  		//String directory = "C:/Java学习/MyEclipsePro/MyVote2/WebRoot";
		  
  		//动态获取文件存放的路径，将文件路径分隔符替换为平台无关的分隔符
  		File voteData = getFileObj(request);
  		
  		if(!voteData.exists())
  		{
  			OutputFormat format = OutputFormat.createPrettyPrint();
  			format.setEncoding("utf-8");
  			FileWriter fileWriter;
			try
			{
				voteData.createNewFile();
				fileWriter = new FileWriter(voteData);
				XMLWriter xmlWriter = new XMLWriter(fileWriter, format);
	  			//将初始化的XML文档写入到文件
	  			xmlWriter.write(Util.createXMLContent());
	  			
	  			xmlWriter.close();
			}
			catch(IOException e)
			{
				e.printStackTrace();
			}
  		}
  		
  		SAXReader saxReader = new SAXReader();
  		Document document = null;
		try
		{
			document = saxReader.read(voteData);
		}
		catch(DocumentException e)
		{
			e.printStackTrace();
		}
		return document;
	}
	
	
	/**
	 * 获取XML文档。
	 * @param request 通过传递的request以处理同一个request。
	 * @return 已存在的XML文件的Document实例。
	 */
	public static Document getXMLDoc(HttpServletRequest request)
	{
		File voteData = getFileObj(request);
		
		SAXReader saxReader = new SAXReader();
		Document document = null;
		try
		{
			document = saxReader.read(voteData);
		}
		catch(DocumentException e)
		{
			e.printStackTrace();
		}
		return document;
	}
	
	/**
	 * 在..apache-tomcat-7.0.82\webapps\MyVote2\目录下创建File对象，该方法使用了“/”分隔符以替换任何平台相关的分隔符。
	 * @param request 通过传递的request以处理同一个request
	 * @return File对象，用于为getXMLDoc(HttpServletRequest request)
	 * 方法提供参数以生成XML文档。
	 */
	public static File getFileObj(HttpServletRequest request)
	{
		String directory = request.getServletContext().getRealPath("").replace(File.separator, "/"); 
		File voteData = new File(directory, Util.XML_FILE_NAME);
		return voteData;
	}
	
	/**
	 * 将最新结果的XML文档对象写入到XML文件。
	 * @param request
	 * @param document
	 * @throws IOException
	 */
	public static void write2XML(HttpServletRequest request, Document document) throws IOException
	{
		XMLWriter xmlWriter = new XMLWriter(new FileWriter(Util.getFileObj(request)));
		xmlWriter.write(document);
		xmlWriter.close();
	}
}
