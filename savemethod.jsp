<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp" %>

<%		
   String[] name = request.getParameterValues( "m_name" );
   Integer method_count = new Integer(1);
   method_count = Integer.parseInt(request.getParameter( "m_count" ));

   String uname = (String) session.getAttribute("theUname");
   int task_id =  (Integer)session.getAttribute( "theTask_ID" );
   String tname = (String) session.getAttribute("theTask");
%>

  <jsp:scriptlet><![CDATA[

int i =0;
int resultq = 0;
int flag = 1;
for(i=0; i<method_count; i++)
    {
	String query =  "INSERT INTO `method` (`task_id`, `name`) VALUES ('" + task_id + "', '" + name[i] + "')" ;
	resultq = stmt.executeUpdate(query);
	if(resultq == 0)
	    flag = 0;
    }


String filePath = "/var/lib/tomcat6/webapps/tournament/uploads/" + uname + "/" + tname + "/";
//String filePath = context.getInitParameter("file-upload");

File dir = new File(filePath);
dir.mkdir();



con.close();


]]></jsp:scriptlet>

<%
	 //    out.println(resultq);
    if(flag == 0) {
	session.setAttribute("errMsg", "Error creating Task.");
	response.sendRedirect("taskmethods.jsp");
    }
    else {
	session.setAttribute("posMsg", "Task " + tname + " with "+ method_count +" methods created Successfully!.");
	response.sendRedirect("method.jsp?taskid="+task_id);
    }
%>