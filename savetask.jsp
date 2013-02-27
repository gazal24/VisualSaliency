<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp"%>

<%		
String tname = request.getParameter( "name" );
Integer method_count = new Integer(1);
method_count = Integer.parseInt(request.getParameter( "count" ));
String uname = (String) session.getAttribute("theUname");

session.setAttribute("theTaskName", tname );
session.setAttribute("theCount", method_count);
out.println("Hello " + method_count);

String query =  "INSERT INTO `task` (`uname`, `name`, `method_count`) VALUES ('" + uname + "', '" + tname + "', '" + method_count + "')" ;
int resultq = stmt.executeUpdate(query);

query = "SELECT max(id) as task_id FROM `task` WHERE `name` = '" + tname + "'";
rs = stmt.executeQuery(query);
resultq = 0;
if(rs.next()) {
    Integer task_id = new Integer(1);
    task_id = Integer.parseInt(rs.getString("task_id"));
    session.setAttribute("theTask_ID", task_id);
    resultq = 1;
}

con.close();

if(resultq == 0)
    response.sendRedirect("register.jsp");
else 
    response.sendRedirect("taskmethods.jsp");
%>
