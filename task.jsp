<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp" %>
<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="button.css" rel="stylesheet" type="text/css">
    <script src="helper_script.js"></script>
  </head>
  <body>

    <div align="center" width="800">
      Hello! <%= session.getAttribute("theName") %> [<%= session.getAttribute("theUname") %>] <br />
      <%@ include file = "errormsg.jsp" %>
      <% String referrer = request.getHeader("referer"); 
        out.println("<p> use this sometime : " + referrer + "</p>");
       %>
      <a float="right" class="large button black" href="settings.jsp">Account Setting</a>
    </div>
    <div class="img_thumb">
      <table align="center" width="600">
	<% String uname = (String) session.getAttribute("theUname"); %>

      <%
	 rs = stmt.executeQuery("SELECT * from task WHERE uname = '" + uname +"'" );
	 int counter = 0;
	 String img_path;
 	 out.println("<tr>");
         while(rs.next()) {
           String tname = rs.getString("name"); 
           String task_id = rs.getString("id");
	   img_path = "uploads/" + uname + "/" + tname + "/" + "original" + ".jpg";
  	   if(counter%3 == 0) { out.println("</tr><tr>"); counter = 0;}
      %> 
	<td class="buttons" width="500" align="center"><br>
	 <!-- <img src= <% out.print(img_path);%> alt= <% out.print(tname);%> height=100px width= 150px /> <br/> -->
	  <a class="regular" href=<% out.print("method.jsp?taskid="+task_id); %> ><h1> <% out.print(tname); %> </td>
        <%
	 counter++;
         }
         con.close();
	%>
	</tr>
      </table>
    </div>
    <div align="center">
    <table>
      <tr><td align="center"><br> <br>
	  
      <form method=post action="savetask.jsp">
      	New Task :
	<div class="field"> <input type="text" name="name" size="20" placeholder="Task Name"> </div>
	<div class="field"> <input type="text" name="count" size="50" placeholder="2"> </div>
	<br>
	<div class="buttons"> 

	  <button type="create" class="positive" name="save"> 
	    <img src="images/apply2.png" alt=""/>
	    Create
	  </button>

	  <a href="task.jsp" class="regular">
            <img src="images/textfield_key.png" alt=""/>
            Reset
	  </a> 
	</div>
      </form>
      </td></tr></table>
      </div>
  </body>
</html>
