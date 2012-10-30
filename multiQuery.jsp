<%@ include file="dbconnect.jsp" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.thoughtworks.xstream.XStream"%>
<%
String type = request.getParameter("type");
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
%>