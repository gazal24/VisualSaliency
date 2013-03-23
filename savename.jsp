<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="webp_rmi.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="dbconnect.jsp"%>
<%
   String uname = request.getParameter( "uname" );
   String name = request.getParameter( "name" );
   String email = request.getParameter( "email" );
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
    else if(email == ""){
	session.setAttribute("errMsg", "Email cannot be blank.");
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
	paramList.add(email);
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
   session.setAttribute("theLoginType", 1);
   session.setAttribute("isValid", "yes");
   String filePath = "/var/lib/tomcat6/webapps/tournament/uploads/" + uname;
   //String filePath = context.getInitParameter("file-upload");
   
   File dir = new File(filePath);
   dir.mkdir();

   int i=0;
   // String arr[] = new String[3];
   // arr[0] = "gazal24@gmail.com";
   // arr[1] = "gazal.cse.iitkgp@gmail.com";
   // arr[2] = "08cs3012@iitkgp.ac.in";

   // emailer.to = arr[0];
   // for(i=1; i<3; i++)
   //     emailer.to = emailer.to + "," + arr[i];

   emailer.to = email;
   emailer.subject = "Welcome to our System";
   emailer.msgText = "Hello! " + name + "\nYou have been registered successfully.\n\nYour username is : "+ uname +" \n\nClick the link below to sign in. \nhttp://localhost:8080/tournament\n\nregards \nTeam Admin";
   emailer.sendmail();

   session.setAttribute("posMsg", "Congratulations. You are registered successfully.");
   response.sendRedirect("task.jsp");
}
%>