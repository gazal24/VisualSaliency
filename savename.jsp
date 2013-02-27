<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp"%>
<%
   String uname = request.getParameter( "uname" );
   String name = request.getParameter( "name" );
   String passwd = request.getParameter( "passwd" );
   String repasswd = request.getParameter( "repasswd" );

   session.setAttribute("theUname", uname );
   session.setAttribute("thePasswd", passwd);
%>

<a href="nextpage.jsp">Continue</A>
<% out.println(session.getAttribute("theUname")); %>
<% out.println(session.getAttribute("thePasswd")); %>
<% out.println(out); %>


<% String filePath = "/var/lib/tomcat6/webapps/tournament/uploads/" + uname;
//String filePath = context.getInitParameter("file-upload");

File dir = new File(filePath);
dir.mkdir();


int match = 0;
int resultq = 0;
String uname_db;
rs = stmt.executeQuery("SELECT * from `user` WHERE `uname` = '"+ uname +"'");
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
	String query =  "INSERT INTO `user` (`uname`, `name`, `password`, `age`) VALUES ('" + uname + "', '" + name + "', '" + passwd + "', '22 ')" ;
	resultq = stmt.executeUpdate(query);
    }
}
con.close();

if (resultq == 1) {
    session.setAttribute("posMsg", "Congratulations. You are registered successfully.");
    session.setAttribute("theLoginType", 1);
    response.sendRedirect("task.jsp");
}
%>