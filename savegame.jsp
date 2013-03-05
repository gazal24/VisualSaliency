<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp" %>
<%
   String code = request.getParameter("code");
   String task_id =  (String) session.getAttribute( "theTask_ID" );

   out.println(code + ":: ");
   String[] email = request.getParameterValues( "email" );
   int size=-1;
   try {
       while(email[++size] != "");
   } catch(Exception e) {
       //   out.println("got an error");
   }

   out.println(size);

   paramList.clear();
   paramList.add(task_id);
   paramList.add(code);

   // String query =  "INSERT INTO `game` (`task_id`, `code`) VALUES ('" + task_id + "', '" + code + "')" ;

   int resultq = 1;
   resultq = execUpdate(80, paramList);

   // int resultq = stmt.executeUpdate(query);
   int flag=0; 
   String game_id="";
   if(resultq == 0)
       flag = 1;

   paramList.clear();
   paramList.add(code);
   rs = execQuery(81, paramList);

// query = "SELECT id as game_id FROM `game` WHERE `code` = '" + code +"'";
// rs = stmt.executeQuery(query);

if(rs.next())
    game_id = rs.getString("id");
int i;
String query = "";
for(i=0; i<size; i++) {
    paramList.clear();
    paramList.add(game_id);
    paramList.add(code);
    paramList.add(email[i]);
    resultq = execUpdate(82, paramList);
    out.println("\n RSQ=" + resultq);
    
    // query =  "INSERT INTO `play` (`game_id`, `code`, `player_email_id`) VALUES ('" + game_id + "', '" + code + "', '" + email[i] + "')" ;
    // resultq = stmt.executeUpdate(query);
    if(resultq == 0)
	flag = 1;

}


if(flag == 1) {
    session.setAttribute("errMsg", "Game could not be created. Try again.");
    response.sendRedirect("method.jsp?taskid="+task_id);
}
else {
    session.setAttribute("posMsg", "Game created successfully and send to " + size +" volunteer!");
    response.sendRedirect("task.jsp");
}
%>
