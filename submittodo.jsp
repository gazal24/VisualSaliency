<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<html>
<head>	
<%		
   String task = request.getParameter( "todo" );
%>

  <jsp:declaration>
    
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/proj1";
    
  </jsp:declaration>

  <jsp:scriptlet><![CDATA[

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
String query =  "INSERT INTO `todo` (`task`) VALUES ('" + task + "')" ;
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
