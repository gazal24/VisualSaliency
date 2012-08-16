<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
    <title>MySQL Database creation</title>
    <style>
      * { font-size: 12px; font-family: Verdana }
    </style>
  </head>
  <body>

    <h2>Creation of a books database</h2>

    <jsp:declaration>
 
      Statement stmt;
      Connection con;
      String url = "jdbc:mysql://localhost:3306/";
      
    </jsp:declaration>

    <jsp:scriptlet><![CDATA[

Class.forName("java.lang.Thread");
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 

stmt = con.createStatement();
stmt.executeUpdate("CREATE DATABASE books");
con.close();

]]></jsp:scriptlet>
    
  </body>
</html>
