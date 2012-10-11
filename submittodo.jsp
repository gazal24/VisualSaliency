<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp"%>
<%		
   String task = request.getParameter( "todo" );
%>


    <jsp:scriptlet><![CDATA[

String query =  "INSERT INTO `todo` (`task`, `status`) VALUES ('" + task + "','"+ 0 +"')" ;
stmt.executeUpdate(query);
con.close();


]]></jsp:scriptlet>
<%
   response.sendRedirect("todo.jsp");
%>
