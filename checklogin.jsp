<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="dbconnect.jsp" %>

<%
   String uname = request.getParameter( "uname" );
   String passwd = request.getParameter( "passwd" );

   session.setAttribute("theUname", uname );
   session.setAttribute("thePasswd", passwd);
%>

<a href="nextpage.jsp">Continue</A>
<% out.println(session.getAttribute("theUname")); %>
<% out.println(session.getAttribute("thePasswd")); %>
<% out.println(out); %>

  <jsp:scriptlet><![CDATA[
rs = stmt.executeQuery("SELECT * from user");
	  

int login_flag = 0;	  
while(rs.next())
{
String uname_db = rs.getString("uname");
String passwd_db = rs.getString("password");
if(uname_db.equals(uname) && passwd_db.equals(passwd))
	    {
	    login_flag = 1;
	    break;
	    }


}
con.close();


]]></jsp:scriptlet>

<%
    if(login_flag == 0) {
	session.setAttribute("errMsg", "Incorrect username or password. Try again.");
	response.sendRedirect("login.jsp");
    }
    else {
	session.setAttribute("posMsg", "Welcome Back!.");
	response.sendRedirect("task.jsp");
    }
%>