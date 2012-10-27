<%@ page import="java.sql.*" %>
<jsp:declaration>
      
Statement stmt;
Connection con;
String url = "jdbc:mysql://localhost:3306/proj1";
ResultSet rs,rs1;   
</jsp:declaration>

<%
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
stmt = con.createStatement();
%>
