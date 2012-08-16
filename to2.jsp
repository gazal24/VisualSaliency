<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

<html>

  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
  <body>

    <br>
    <br>
    <br>
    <table align = center>

      <jsp:declaration>
	
	Statement stmt;
	Connection con;
	String url = "jdbc:mysql://localhost:3306/proj1";
	
      </jsp:declaration>
<jsp:scriptlet><![CDATA[

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * from todo");
	  

while(rs.next())
{
String id = rs.getString("id");
String task = rs.getString("task");
out.println("<tr class=buttons><td><a class=\"regular\">"+ id+"</a></td><td>"+ task +"</td>");
out.print("<td class=\"buttons\"> <a href=\"deletetodo.jsp?id="+ id +"\" class=\"negative\"> <img src=\"images/cross.png\" alt=\"\"/></a></td></tr>");

}
con.close();

]]></jsp:scriptlet>
<tr><td colspan = 3>
      <form method=post action="submittodo.jsp">
	<div class="field"> <input type=text name= todo size=20 placeholder="TODO">
	  <button type="create" class="positive" name="save"> 
	    <img src="images/apply2.png" alt=""/>
            submit
	  </button>
	</div>
      </form>
</td></tr></table>
  </body>
</html>
