<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <title>File Uploading Form</title>

<%
   int task_id =  (Integer)session.getAttribute( "theTask_ID" );
%>

  <jsp:declaration>
      
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/proj1";
    
  </jsp:declaration>


  <jsp:scriptlet><![CDATA[
       String tname = (String) session.getAttribute("theTask");
       String query = "SELECT * FROM `method` WHERE `task_id` = " + task_id;
       Class.forName("com.mysql.jdbc.Driver");
       con = DriverManager.getConnection(url, "root", "root"); 
       stmt = con.createStatement();
       ResultSet rs = stmt.executeQuery(query);
       int i=0;

  ]]></jsp:scriptlet>
  
  </head>
  <body>
    <table align = center>
      <form action="saveimage.jsp" method="post" enctype="multipart/form-data">
	<tr><td colspan =2 align = center> Select files to upload 
	    <br /><br /></td></tr>
	<tr>
	  <td>Original Image </td>
	   <td>	<input type="file" name="original" /></td>
	</tr>
	<%
	   String m_name;
	   Integer method_count =  (Integer) session.getAttribute( "theCount" );
	   for(i=0; i<method_count; i++) {
		rs.next();
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
