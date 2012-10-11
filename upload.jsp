<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp" %>

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <title>File Uploading Form</title>

<%
   int task_id =  (Integer)session.getAttribute( "theTask_ID" );
%>

  <jsp:scriptlet><![CDATA[
       String tname = (String) session.getAttribute("theTask");
       String query = "SELECT * FROM `method` WHERE `task_id` = " + task_id;
       rs = stmt.executeQuery(query);
       int i=0;

  ]]></jsp:scriptlet>
  
  </head>
  <body>
    <table align = center>
      <form action="saveimage.jsp" method="post" enctype="multipart/form-data">
	<tr><td colspan =2 align = center> Select files to upload 
	    <br /><br /></td></tr>
	<tr class="field">
	  <td> Dataset Name </td>
	   <td colspan='2'> <input type="text" name="set_name" value="" placeholder="Dataset Name"/></td>

</tr>
	<tr>
	  <td>Original Image </td>
	  <td></td>
	   <td>	<input type="file" name="original" /></td>
	</tr>
	<%
	   String m_name;
           i=0;
           while(rs.next()) { 
	       i++;
	       m_name = rs.getString("name");
        %>
	 <tr>
	   <td> <% out.print(m_name); %> </td>
	   <td>	<input type="hidden" name=mname value= <% out.print("'" + m_name + "'"); %>/>	</td>
	   <td>	<input type="file" name= <% out.print("file"+i); %> />	</td>
	 </tr>
	 
	 <% }
	    con.close();
	 %>
	 <tr><td><br /><br /> <input type="submit" value="Upload File" /> </td></tr>
    </form>
  </body>
</html>
