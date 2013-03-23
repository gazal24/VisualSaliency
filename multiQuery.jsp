<%@ include file="dbconnect.jsp" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.thoughtworks.xstream.XStream"%>
<%
String type = request.getParameter("type");
ResultSet rs1=null;

if(type.equals("returnOriginal")) { 
    String uname = (String) session.getAttribute("theUname");
    String tname = (String) session.getAttribute("theTaskName");
    String img_path1 = "uploads/" + uname + "/" + tname + "/" +  "original.jpg";
    out.println("{");
    out.println("\"originalImg\" : \"" + img_path1 + "\"");
    out.println("}");
}

if(type.equals("saveScore")) {
    XStream xstream = new XStream();
    int [][]adjGraph = (int[][])session.getAttribute("theAdjGraph");
    String play_id =(String) session.getAttribute("thePlayID");
    String adjGraph_string = xstream.toXML(adjGraph);
    
    String query =  "UPDATE `play` SET `score`= '"+adjGraph_string+"' WHERE `id`="+play_id;       
    stmt.executeUpdate(query);
    response.sendRedirect("result.jsp");
}

if(type.equals("updatePasswd")) {
    try {
	String uname = (String) session.getAttribute("theUname");
	String old_passwd = request.getParameter( "old_pass" );
	String new_passwd = request.getParameter( "new_pass" );
	String cnf_passwd = request.getParameter( "cnf_pass" );
	if(!cnf_passwd.equals(new_passwd) || new_passwd.equals("")) {
	    session.setAttribute("errMsg", "Passwords do not match. Try again!");
	} else {
	    String query = "SELECT * from `proj1`.`user` where `uname` = '" + uname + "' AND `password` = '" + old_passwd + "'";
	    rs1 = stmt.executeQuery(query);
	    if(rs1.next()) {
		query = "UPDATE  `proj1`.`user` SET  `password` =  '"+new_passwd+"' WHERE  `user`.`uname` =  '"+uname+"'";
		stmt.executeUpdate(query);
		session.setAttribute("posMsg", "Password changed successfuly!");
	    } else {
	    session.setAttribute("errMsg", "Current password do not match. Try again!");
	    }
	}
    }
    catch(Exception e){
	session.setAttribute("errMsg", "Error changing password!");
    }
    response.sendRedirect("settings.jsp");
}

if(type.equals("updateName")) {
    try {
	String uname = (String) session.getAttribute("theUname");
	String name = request.getParameter("name");
	String query = "UPDATE  `proj1`.`user` SET  `name` =  '"+name+"' WHERE  `user`.`uname` =  '"+uname+"'";
	stmt.executeUpdate(query);
	session.setAttribute("theName", name);
	session.setAttribute("posMsg", "Name updated successfuly!");
    }
    catch(Exception e){
	session.setAttribute("errMsg", "Error in updating Name!");
    }
    response.sendRedirect("settings.jsp");
}
%>