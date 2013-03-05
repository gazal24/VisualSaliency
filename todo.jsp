<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="dbconnect.jsp" %>

<html>

  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
  <body>

    <br>
    <br>
    <br>
    <table align = center  style="table-layout: fixed;">

<%
      
paramList.clear();
rs = execQuery(100, paramList);
			
// rs = stmt.executeQuery("SELECT * from todo ORDER BY `id`");
	  
if(rs.next()) {
while(rs.next())
{
String id = rs.getString("id");
String task = rs.getString("task");
String status = rs.getString("status");
String img = "";

out.println("<tr class=buttons><td><a class=\"regular\">"+ id+"</a></td><td> ");

if(status.equals("1")) {
img = "images/untick.png";
out.println("<del>");
} else img="images/tick.png";

out.println(task);
out.println("</td>");

out.print("<td class='buttons'> <a href='striketodo.jsp?id="+ id +"&status="+status+"' class='negative'> <img src='" + img + "' alt=''/></a></td>");
out.print("<td class=\"buttons\"> <a href=\"deletetodo.jsp?id="+ id +"\" class=\"negative\"> <img src=\"images/cross.png\" alt=\"\"/></a></td></tr>");

}
}
con.close();
%>

<tr><td colspan = 3>
    <form method="post" action="submittodo.jsp">
      <div class="field"> <input type="text" name="todo" size="20" placeholder="TODO">
	<button type="create" class="positive" name="save"> 
	  <img src="images/apply2.png" alt=""/>
          submit
	</button>
      </div>
    </form>
    </td></tr></table>
  </body>
</html>
