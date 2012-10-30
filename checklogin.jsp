<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="dbconnect.jsp" %>

<%
      int login_type = Integer.parseInt(request.getParameter( "login_type" ));
out.println(login_type);
%>


  <jsp:scriptlet><![CDATA[
int login_flag = 0;	  
String task_id="0";
String uname = "";

if(login_type == 1) { //User Login
    out.println("hey");
    uname = request.getParameter( "uname" );
    String passwd = request.getParameter( "passwd" );
    
    rs = stmt.executeQuery("SELECT * from user");
    while(rs.next())
	{
	    String uname_db = rs.getString("uname");
	    String passwd_db = rs.getString("password");
	    if(uname_db.equals(uname) && passwd_db.equals(passwd))
		{
		    login_flag = 1;
		    session.setAttribute("theLoginType", 1);
		    session.setAttribute("theUname", uname );
		    session.setAttribute("thePasswd", passwd);
		    break;
		}
	}
}

else if(login_type == 2) { // Player Login
    String email_id = request.getParameter( "email_id" );
    String code = request.getParameter( "code" );
    rs = stmt.executeQuery("SELECT * from `play` WHERE `player_email_id` = '" + email_id + "' AND `code` = '"+ code +"'" );

    while(rs.next()) {
	String play_id = rs.getString("id");
	String code_db = rs.getString("code");
	String game_id = rs.getString("game_id");

	if(code_db.equals(code)) {
	    login_flag = 1;
	    session.setAttribute("theLoginType", 2);
	    session.setAttribute("thePlayID", play_id);
	    session.setAttribute("theGameID", game_id);
	    rs = stmt.executeQuery("SELECT `task_id` FROM `game` WHERE `id` = '"+ game_id +"'");
	    rs.next();
	    task_id = rs.getString("task_id");
	    rs = stmt.executeQuery("SELECT `uname` FROM `task` WHERE `id` = '"+ task_id +"'");
	    rs.next();
	    uname = rs.getString("uname");
	    session.setAttribute("theUname", uname );
	}
    }
}
    
con.close();

]]></jsp:scriptlet>

<%
    if(login_flag == 0 && login_type == 1) {
	session.setAttribute("errMsg", "Incorrect username or password. Try again.");
	response.sendRedirect("login.jsp");
    } 
    else if (login_flag == 1 && login_type == 1) {
	session.setAttribute("posMsg", "Welcome Back!.");
	response.sendRedirect("task.jsp");
    }
    else if(login_flag == 0 && login_type == 2){
	session.setAttribute("errMsg", "Invalid Volunteer ID or Code!");
	response.sendRedirect("login.jsp");
    }
    else if(login_flag == 1 && login_type == 2){
	session.setAttribute("posMsg", "Welcome to the tournament!");
	response.sendRedirect("method.jsp?taskid="+task_id);
    }


%>