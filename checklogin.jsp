<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="dbconnect.jsp" %>


<%
int login_type = Integer.parseInt(request.getParameter( "login_type" ));
out.println(login_type);

int login_flag = 0;	  
String task_id="0";
String uname = "max";
String name = "";

// STANDARD IMPLEMENTATION OF RMI LAYER
// String str;
// try
//     {
// 	paramList.add(uname);
// 	//paramList.add(passwd);
// 	crs = execQuery(1, paramList);
// 	while(crs.next()) {
// 	    str = crs.getString("uname");
// 	    if(str.equals("ggarg"))
// 		out.println(str);
// 	}
//     }
// catch (Exception e)
//     {
// 	out.println("Error found. Check <br></br>" + e.toString());
//     }




if(login_type == 1) { //User Login
    out.println("hey");
    uname = request.getParameter( "uname" );
    String passwd = request.getParameter( "passwd" );

    paramList.clear();
    paramList.add(uname);
    paramList.add(passwd);
    crs = execQuery(20, paramList);
    
    //    rs = stmt.executeQuery("SELECT * from `proj1`.`user` where `uname` = '" + uname + "' AND `password` = '" + passwd + "'");

    if(crs.next()) {
	name = crs.getString("name");
	login_flag = 1;
	session.setAttribute("theLoginType", 1);
	session.setAttribute("theName", name );
	session.setAttribute("theUname", uname );
	session.setAttribute("thePasswd", passwd);
    }
}


else if(login_type == 2) { // Player Login
    String email_id = request.getParameter( "email_id" );
    String code = request.getParameter( "code" );

    paramList.clear();
    paramList.add(email_id);
    paramList.add(code);
    crs = execQuery(21, paramList);

    // rs = stmt.executeQuery("SELECT * from `play` WHERE `player_email_id` = '" + email_id + "' AND `code` = '"+ code +"'" );

    if(crs.next()) {
	String play_id = crs.getString("id");
	String code_db = crs.getString("code");
	String game_id = crs.getString("game_id");

	login_flag = 1;
	session.setAttribute("theLoginType", 2);
	session.setAttribute("thePlayID", play_id);
	session.setAttribute("theGameID", game_id);
	
	paramList.clear();
	paramList.add(game_id);
	crs = execQuery(22, paramList);

	// rs = stmt.executeQuery("SELECT `task_id` FROM `game` WHERE `id` = '"+ game_id +"'");
	crs.next();
	task_id = crs.getString("task_id");

	paramList.clear(); paramList.add(task_id);
	// rs = stmt.executeQuery("SELECT `uname` FROM `task` WHERE `id` = '"+ task_id +"'");
	crs = execQuery(23, paramList);
	crs.next();
	name = "Volunteer / Player!";
	session.setAttribute("theName", name );
	uname = crs.getString("uname");
	session.setAttribute("theUname", uname );
    }
}
    
con.close();

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