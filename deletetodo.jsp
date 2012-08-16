<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<html>
<head>	
<%		
   String id = request.getParameter( "id" );
%>

  <jsp:declaration>
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/proj1";
    
  </jsp:declaration>

  <jsp:scriptlet><![CDATA[

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
String query =  "DELETE FROM `todo` WHERE `id` ="+ id;
stmt = con.createStatement();
stmt.executeUpdate(query);
con.close();

]]></jsp:scriptlet>
<%
   response.sendRedirect("todo.jsp");
%>
</head>

<body>
</body>
</html>
