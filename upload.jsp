<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <title>File Uploading Form</title>

<%
   Integer task_id = new Integer(1);
   task_id =  Integer.parseInt((String)session.getAttribute( "theTask_ID" ));
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
  ]]></jsp:scriptlet>
  
  </head>
  <body>
    <table align = center>
      <form action="saveimage.jsp" method="post" enctype="multipart/form-data">
	<tr><td colspan =2 align = center> Select files to upload </td></tr>
	<%
	   int i;
	   String m_name;
	   Integer method_count =  (Integer) session.getAttribute( "theCount" );
	   for(i=0; i<method_count; i++) {
		rs.next();
		m_name = rs.getString("name");
        %>
	 <tr>
	   <td> <% out.print(m_name); %> </td>
	   <td>	<input type="file" name= <% out.print("file"+i); %> />	</td>
	 </tr>
	 
	 <% }
	    con.close();
	 %>
	 <tr><td><br /><br /> <input type="submit" value="Upload File" /> </td></tr>
    </form>
  </body>
</html>
