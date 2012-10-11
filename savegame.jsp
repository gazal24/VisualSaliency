<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp" %>
<%
   String code = request.getParameter("code");
   int task_id =  (Integer)session.getAttribute( "theTask_ID" );

   out.println(code + ":: ");
   String[] email = request.getParameterValues( "email" );
   int size=-1;
   try {
       while(email[++size] != "");
   } catch(Exception e) {
       //   out.println("got an error");
   }

   out.println(size);
   String query =  "INSERT INTO `game` (`task_id`, `code`) VALUES ('" + task_id + "', '" + code + "')" ;
   int resultq = stmt.executeUpdate(query);
   int flag=0;
   if(resultq == 0)
   flag = 1;
   
query = "SELECT id as game_id FROM `game` WHERE `code` = '" + code +"'";
rs = stmt.executeQuery(query);
rs.next();
int game_id = Integer.parseInt(rs.getString("game_id"));
int i;
for(i=0; i<size; i++) {
    query =  "INSERT INTO `play` (`game_id`, `code`, `player_email_id`) VALUES ('" + game_id + "', '" + code + "', '" + email[i] + "')" ;
    resultq = stmt.executeUpdate(query);
}



if(resultq == 0) {
    session.setAttribute("errMsg", "Game could not be created. Try again.");
    response.sendRedirect("method.jsp?taskid="+task_id);
}
else {
    session.setAttribute("posMsg", "Game created successfully and send to " + size +" volunteer!");
    response.sendRedirect("task.jsp");
}
%>
