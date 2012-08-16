<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<html>
<head>	
<%		
   String name = request.getParameter( "name" );
   Integer method_count = new Integer(1);
   method_count = Integer.parseInt(request.getParameter( "count" ));
   String uname = (String) session.getAttribute("theUname");

   session.setAttribute("theTask", name );
   session.setAttribute("theCount", method_count);
%>
<br>
<% 
   out.println("Hello " + method_count);
%>
<br>
<a href="nextpage.jsp">Continue</A>

  <jsp:declaration>
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/proj1";
    
  </jsp:declaration>

  <jsp:scriptlet><![CDATA[

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
String query =  "INSERT INTO `task` (`uname`, `name`, `method_count`) VALUES ('" + uname + "', '" + name + "', '" + method_count + "')" ;
stmt = con.createStatement();
int resultq = stmt.executeUpdate(query);
ResultSet rs = stmt.executeQuery("SELECT * from task");
while(rs.next())
{
String out1 = rs.getString("uname");
String out2 = rs.getString("name");
String out3 = rs.getString("method_count");
out.println(out1);
out.println(out2);
out.println(out3);
}
query = "SELECT max(id) as task_id FROM `task` WHERE `name` = '" + name + "'";
rs = stmt.executeQuery(query);
resultq = 0;
while(rs.next()) {
    String task_id = rs.getString("task_id");
    session.setAttribute("theTask_ID", task_id);
    //    out.println("*** " + rs.getString("task_id"));
    resultq = 1;
}

con.close();


]]></jsp:scriptlet>


<%
   if(resultq == 0)
   response.sendRedirect("register.jsp");
   else 
   response.sendRedirect("taskmethods.jsp");
%>
</head>

<body>
</body>
</html>
