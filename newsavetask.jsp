<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp"%>

<%		
String uname = (String) session.getAttribute("theUname");
String tname = request.getParameter( "task_name" );
String mcount_str = request.getParameter( "method_count" );
String[] name = request.getParameterValues( "method_name" );
String task_detail = request.getParameter( "task_desc" );
Integer mcount = new Integer(1);
mcount = Integer.parseInt(mcount_str);

// int i;
// for(i=0; i<mcount; i++) {
//     out.println(name[i]);
// }

session.setAttribute("theTaskName", tname );
session.setAttribute("theMethodCount", mcount);

paramList.clear();
paramList.add(uname);
paramList.add(tname);
paramList.add(task_detail);
paramList.add(mcount_str);

int resultq = execUpdate(90, paramList);

// String query =  "INSERT INTO `task` (`uname`, `name`, `method_count`) VALUES ('" + uname + "', '" + tname + "', '" + mcount + "')" ;
// int resultq = stmt.executeUpdate(query);


paramList.clear();
paramList.add(tname);
// String query = "SELECT max(id) as task_id FROM `task` WHERE `name` = '" + tname + "'";
rs = execQuery(91, paramList);
resultq = 0;
String task_id = null;
if(rs.next()) {
    task_id = rs.getString("task_id");
    session.setAttribute("theTask_ID", task_id);
    resultq = 1;
}


///////// SAVE METHOD ////////////
int i =0;
int flag = 1;
for(i=0; i<mcount; i++)
    {
	paramList.clear();
	paramList.add(task_id);
	paramList.add(name[i]);
	// String query =  "INSERT INTO `method` (`task_id`, `name`) VALUES ('" + task_id + "', '" + name[i] + "')" ;
	
	if(execUpdate(110, paramList) == 0)
	    flag = 0;
    }


String filePath = "/var/lib/tomcat6/webapps/tournament/uploads/" + uname + "/" + tname + "/";
//String filePath = context.getInitParameter("file-upload");

File dir = new File(filePath);
dir.mkdir();
if(flag == 0) {
    session.setAttribute("errMsg", "Error in creating Methods.");
    response.sendRedirect("newtask.jsp");
}
else {
    session.setAttribute("posMsg", "Task " + tname + " with "+ mcount +" methods created Successfully!.");
    response.sendRedirect("method.jsp?taskid="+task_id);
}
%>