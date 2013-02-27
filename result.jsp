<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp" %>
<%@ page import="com.thoughtworks.xstream.XStream"%>

<%    
      //      int [][]adjGraph = (int[][])session.getAttribute("theAdjGraph");
   int [][]adjGraph = new int[5][5];
   int [][]p = new int[5][5];
   int [][]adjGraph_tmp;
   //   int []score = (int[])session.getAttribute("theScore");
   int []score = new int[5];
   int[] currentRound = (int[])session.getAttribute("theCurrentRound"); 
   int methodCount =  (Integer)session.getAttribute("theMethodCount");
   String[] method =(String[]) session.getAttribute("theMethodArray");
   String[] method_mutableOrder = new String[5];
   String play_id =(String) session.getAttribute("thePlayID");
   int loginType = (Integer) session.getAttribute("theLoginType");
   int task_id = (Integer)session.getAttribute("theTask_ID");
   int i,j,k;
   String query;
   String adjGraph_string;
   XStream xstream = new XStream();
%>

<%!
   int max(int a, int b){
       if(a>b) return a;
       return b;
   } 
 int min(int a, int b){
    if(a<b) return a;
    return b;
 }
%>
    <% 
       // THIS UPDATION CODE MUST NOT BE KEPT IN THIS PAGE. UPDATE SOMEWHERE ELSE AND THEN COME BACK HERE.
   //       adjGraph_string = xstream.toXML(adjGraph);
   //       query =  "UPDATE `play` SET `score`= '"+adjGraph_string+"' WHERE `id`="+play_id;       
   //       stmt.executeUpdate(query);
    %>

    <%
      // User login
      if(loginType == 1) {
	  query = "SELECT `score` FROM `game`,`play` WHERE `game`.`task_id` = " + task_id + " AND `play`.`game_id` = `game`.`id`";
	  rs = stmt.executeQuery(query);
	  while(rs.next()){
	      adjGraph_string = rs.getString("score");
	      if(adjGraph_string != null) {
		  adjGraph_tmp = (int[][]) xstream.fromXML(adjGraph_string);
		  for(i=0; i<methodCount; i++)
		      for(j=0; j<methodCount; j++)
			  adjGraph[i][j] += adjGraph_tmp[i][j];
	      }
	  }
      }

      // Player Login
      else if(loginType == 2) {
	  query =  "SELECT `score` FROM `play` WHERE `id`=" + play_id;
	  rs = stmt.executeQuery(query);
	  rs.next();
	  adjGraph_string = rs.getString("score");
	  if(adjGraph_string != null)
	      adjGraph = (int[][])xstream.fromXML(adjGraph_string);
	  else {
	      session.setAttribute("errMsg", "No score present. Tournament must be played atleast once to view score.");
	      response.sendRedirect("method.jsp?taskid="+task_id);
	  }
	  
      }

      for(i=0; i< methodCount; i++)
	  for(j=0; j< methodCount; j++)
	      if(i!=j) {
		  if(adjGraph[i][j] > adjGraph[j][i])
		      p[i][j] = adjGraph[i][j];
	      }
	      else p[i][j] = 0;
	  
      for(i=0; i< methodCount; i++)
	  for(j=0; j< methodCount; j++)
	      if(i!=j)
		  for(k=0; k< methodCount; k++)
		      if(i!=k && j!=k)
			  p[j][k] = max(p[j][k], min(p[j][i],p[i][k]));

      for(i=0; i< methodCount; i++)
	  for(j=0; j< methodCount; j++)
	      if(i!=j)
		  if(p[i][j] > p[j][i])
		      score[i]++;

      for(i=0; i<methodCount; i++) 
	  method_mutableOrder[i] = method[i];
          


    %>

<html>
  <head>
    <link href="button.css" rel="stylesheet" type="text/css">
  </head>
  <body align="center">
    <div>
       <% if(loginType == 2) out.println(); %>
    </div>
    <table class="image_panel result">
      <tr>
	<td  colspan="100">Score</td>
      </tr>
      <tr>
	<%
	   int temp;
	   String mtemp;
	   for(i=0; i<methodCount-1; i++) 
	       for(j=i; j<methodCount; j++) 
		   if(score[i] < score[j])
		       {
			   temp = score[i];
			   score[i] = score[j];
			   score[j] = temp;
			   
			   mtemp = method_mutableOrder[i];
			   method_mutableOrder[i] = method_mutableOrder[j];
			   method_mutableOrder[j] = mtemp;
		       }

	
for(i=0; i<methodCount; i++)
    out.println("<td>"+method_mutableOrder[i]+"</td>");
%>
</tr><tr>
<%  
for(i=0; i<methodCount; i++)
    out.println("<td>"+score[i]+"</td>");
%>
   </tr>

  <!-- <tr> -->
  <!--   <td  colspan="100">curr</td> -->
  <!-- </tr> -->
  <!-- <tr> -->
   <!-- </tr> -->
</table>
<br />

    <h4><p align="center" width="800"> Row beats Column ? 1 : 0</p>

     <!-- <table class="image_panel result"> -->
     <!-- <tr> -->
     <!-- <td>  </td> -->
 <%
   
// for(i=0; i<methodCount; i++)
//     out.println("<td>"+method[i]+"</td>");
// out.println("</tr>");

// for(i=0; i<methodCount; i++) {
//     out.println("<tr>");
//     out.println("<td>"+method[i]+"</td>");
//     for(j=0; j<methodCount; j++) {
// 	out.println("<td>"+adjGraph[i][j]+"</td>");
//     }
//     out.println("</tr>");
// }

// %>
 </table>


    <table class="image_panel result">
    <tr>
    <td> </td>
<%
   
for(i=0; i<methodCount; i++)
    out.println("<td>"+method[i]+"</td>");
out.println("</tr>");

for(i=0; i<methodCount; i++) {
    out.println("<tr>");
    out.println("<td>"+method[i]+"</td>");
    for(j=0; j<methodCount; j++) {
	out.println("<td>"+adjGraph[i][j]+"</td>");
    }
    out.println("</tr>");
}

%>
</table>

</body>
</html>
