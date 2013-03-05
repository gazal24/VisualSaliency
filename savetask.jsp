<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp"%>

<%		
String tname = request.getParameter( "name" );
String mcount = request.getParameter( "count" );
String uname = (String) session.getAttribute("theUname");

session.setAttribute("theTaskName", tname );
session.setAttribute("theMethodCount", mcount);
out.println("Hello " + mcount);

paramList.clear();
paramList.add(uname);
paramList.add(tname);
paramList.add(mcount);

int resultq = execUpdate(90, paramList);

// String query =  "INSERT INTO `task` (`uname`, `name`, `method_count`) VALUES ('" + uname + "', '" + tname + "', '" + mcount + "')" ;
// int resultq = stmt.executeUpdate(query);


paramList.clear();
paramList.add(tname);
// String query = "SELECT max(id) as task_id FROM `task` WHERE `name` = '" + tname + "'";
rs = execQuery(91, paramList);
resultq = 0;
if(rs.next()) {
    String task_id = rs.getString("task_id");
    session.setAttribute("theTask_ID", task_id);
    resultq = 1;
}

con.close();

if(resultq == 0)
    response.sendRedirect("register.jsp");
else 
    response.sendRedirect("taskmethods.jsp");
%>
