<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp"%>
<%		
   String id = request.getParameter( "id" );
%>


<%
String query =  "DELETE FROM `todo` WHERE `id` ="+ id;
stmt.executeUpdate(query);
con.close();
response.sendRedirect("todo.jsp");
%>
