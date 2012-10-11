<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp"%>
<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="button.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  <%
     Integer task_id = new Integer(1);
     task_id = Integer.parseInt(request.getParameter("taskid"));
     String uname = (String) session.getAttribute("theUname");
     session.setAttribute("theTask_ID", task_id);
  %>
    <div align="center" width="800">
      Hello! <%= session.getAttribute( "theUname" ) %>
      <%@ include file = "errormsg.jsp" %>
    </div>
      <%
	 
	 rs = stmt.executeQuery("Select * from task WHERE id=" + task_id);
	 rs.next();
	 String tname = rs.getString("name");
	 int counter = 0;
	 
         rs = stmt.executeQuery("SELECT * from method WHERE task_id=" + task_id );
	 String img_path;
	 img_path = "uploads/" + uname + "/" + tname + "/" + "original" + ".jpg";
      %>
    <div>
      <table align="center" width="200">
      <tr>
	<td class="buttons" width="500" align="center" colspan="3"><br>
	  <img src= <% out.print(img_path);%> alt= <% out.print("Original Image");%> width= 150px /> <br/>
	  <a class="regular"> <% out.print("Original Image"); %> </a>
       </td>
      </tr>
      </table>
      <div align="right">
	<a class="large button black" href="creategame.jsp"> Create Game </a>  
      </div>

    </div>
<br/>

    <div class="img_thumb">
      <table align="center" width="500">
      <tr>
      <%
	 out.println("<tr>");
         while(rs.next()) {
         String method = rs.getString("name"); 
	 img_path = "uploads/" + uname + "/" + tname + "/" + method + ".jpg";
	 if(counter%3 == 0) { out.println("</tr><tr>"); counter = 0;}
      %> 
       <td class="buttons" width="500" align="center"><br>
	 <img src= <% out.print(img_path);%> alt= <% out.print(method);%> width= 150px /> <br/>
	 <a class="regular"> <% out.print(method); %> </a>
      </td>
      <%
	 counter++;
	 }
      con.close();
      %>
      </tr>
      </table>
    </div>
    <br / > <br/>	<br / > <br/>


<div>
  <table align="center" border="0"> 
    <tr>
      <td id="light"><a class="super button pink" href="play.jsp?type=0">Knockout</a></td>
      <!-- <td id="light"><a class="super button pink">Knockout</a></td> -->
      <td id="light"><a class="super button green"  href="play.jsp?type=1">Challenging</a></td>
      <td id="light"><a class="super button blue"  href="play.jsp?type=2">Round-robin</a></td>
      
<!-- <div id="light" align="center"> -->
<!--        <ul style="list-style: none;"> -->
<!--         <li><a class="super button pink">Pink Button</a> -->
<!--         <a class="large button green">Green Button</a></li> -->
<!--        <li> <a class="large button blue">Blue Button</a> -->
<!--         <a class="large button red">Red Button</a></li> -->
<!--         <li><a class="large button orange">Orange Button</a> -->
<!--         <a class="large button yellow">Yellow Button</a></li> -->
<!--         </ul> -->
<!--  </div> -->
        
<!--  <div id="dark"> -->
<!--         <ul> -->
<!--         <li><a class="super button pink">Pink Button</a> -->
<!--         <a class="large button green">Green Button</a></li> -->
<!--        <li> <a class="medium button blue">Blue Button</a> -->
<!--         <a class="large button red">Red Button</a></li> -->
<!--        <li> <a class="small button orange">Orange Button</a> -->
<!--         <a class="medium button yellow">Yellow Button</a></li> -->
<!--         </ul> -->
<!-- </div> -->

</td> </tr>
</table>
</div>
</body>
</html>







