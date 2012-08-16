<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
  <body>
    <table align = center>
      <tr><td> <%@ include file = "errormsg.jsp" %> </td></tr>
      <tr><td align = right>
	  <div>
	    Hello! <%= session.getAttribute( "theUname" ) %>
	  </div>
      </td></tr>
	  <br>
	  <br>
	  <br>
      <% String uname = (String) session.getAttribute("theUname"); %>
      <jsp:declaration>
	
	Statement stmt;
	Connection con;
	String url = "jdbc:mysql://localhost:3306/proj1";
	
      </jsp:declaration>

      <jsp:scriptlet><![CDATA[
	 Class.forName("com.mysql.jdbc.Driver");
	 con = DriverManager.getConnection(url, "root", "root"); 
	 stmt = con.createStatement();
         ResultSet rs = stmt.executeQuery("SELECT * from task WHERE uname = '" + uname +"'" );
       
         while(rs.next()) {
           String task = rs.getString("name");
           out.println("<tr><td>");
           out.println(task);
           out.println("</td></tr>");
         }
         con.close();
       ]]></jsp:scriptlet>

      <tr><td><br> <br>

      <form method=post action="savetask.jsp">
      	New Task :
	<div class="field"> <input type=text name= name size=20 placeholder="Task Name"> </div>
	<div class="field"> <input type=text name= count size= 50 placeholder="3"> </div>
	<br>
	<div class="buttons"> 

	  <button type="create" class="positive" name="save"> 
	    <img src="images/apply2.png" alt=""/>
            Register
	  </button>

	  <a href="newtask.jsp" class="regular">
            <img src="images/textfield_key.png" alt=""/>
            Reset
	  </a>   <a href="index.jsp" class="negative">
            <img src="images/cross.png" alt=""/>
	    Back
	  </a>
	</div>
      </form>
      <div>
  </body>
</html>
