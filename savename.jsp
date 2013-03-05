<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp"%>
<%
   String uname = request.getParameter( "uname" );
   String name = request.getParameter( "name" );
   String passwd = request.getParameter( "passwd" );
   String repasswd = request.getParameter( "repasswd" );
%>

<% 

int resultq = 0;

paramList.clear();
paramList.add(uname);
rs = execQuery(140, paramList);
//rs = stmt.executeQuery("SELECT * from `user` WHERE `uname` = '"+ uname +"'");
if(rs.next()) { // User exist with this name.
    session.setAttribute("errMsg", "Username already exists. Pick different name.");
    response.sendRedirect("register.jsp");
} 
else {
    if(uname == ""){
	session.setAttribute("errMsg", "Username cannot be blank.");
	response.sendRedirect("register.jsp");
    }
    else if(name == ""){
	session.setAttribute("errMsg", "Name cannot be blank.");
	response.sendRedirect("register.jsp");
    }
    else if(passwd == ""){
	session.setAttribute("errMsg", "Password cannot be blank.");
	response.sendRedirect("register.jsp");
    }
    else if(!passwd.equals(repasswd)) {
	session.setAttribute("errMsg", "Passwords do not match.");
	response.sendRedirect("register.jsp");
    } 
    else {
	paramList.clear();
	paramList.add(uname);
	paramList.add(name);
	paramList.add(passwd);
	resultq = execUpdate(141, paramList);
	// String query =  "INSERT INTO `user` (`uname`, `name`, `password`, `age`) VALUES ('" + uname + "', '" + name + "', '" + passwd + "', '22 ')" ;
 	// resultq = stmt.executeUpdate(query);
    }
}
con.close();

if (resultq == 1) {
   session.setAttribute("theUname", uname );
   session.setAttribute("theName", name );
   String filePath = "/var/lib/tomcat6/webapps/tournament/uploads/" + uname;
   //String filePath = context.getInitParameter("file-upload");
   
   File dir = new File(filePath);
   dir.mkdir();

   session.setAttribute("posMsg", "Congratulations. You are registered successfully.");
   session.setAttribute("theLoginType", 1);
   response.sendRedirect("task.jsp");
}
%>