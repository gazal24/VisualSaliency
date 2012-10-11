<%@ page import="java.lang.*" %>
<%    
   int [][]adjGraph = (int[][])session.getAttribute("theAdjGraph");
   int []score = (int[])session.getAttribute("theScore");
   int[] currentRound = (int[])session.getAttribute("theCurrentRound"); 
   int methodCount =  (Integer)session.getAttribute( "theMethodCount" );
   String[] method =(String[]) session.getAttribute("theMethodArray");

   int i,j;
%>

<html>
<head>
  <link href="button.css" rel="stylesheet" type="text/css">
</head>
<body align="center">
<div>
    
    <% int currentSize = (int)Math.round(Math.pow(2, Math.ceil(Math.log(methodCount)/Math.log(2)))); 
//	out.println(currentSize);
    %>

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
		
		mtemp = method[i];
		method[i] = method[j];
		method[j] = mtemp;
	    }
	
	
for(i=0; i<methodCount; i++)
    out.println("<td>"+method[i]+"</td>");
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
    <%  
//       for(i=0; i<currentSize; i++)
//	 out.println("<td>"+ currentRound[i]+"</td>");
    %>
   <!-- </tr> -->
</table>
<br />

  <h4><p align="center" width="800"> Row beats Column ? 1 : 0</p>

    <table class="image_panel result">
      <tr>
	<td></td>

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
