<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp"%>
<%		
   String id = request.getParameter( "id" );
   String status = request.getParameter( "status" );
if (status.equals("1")) status = "0";
else status = "1";
out.println(status);
%>


<%
String query =  "UPDATE `todo` SET `status` = "+ status +" WHERE `id` ="+ id;
stmt.executeUpdate(query);
con.close();
response.sendRedirect("todo.jsp");
%>
