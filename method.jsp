<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp"%>
<%@ include file="check_session.jsp"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="helper_script.js"></script>
    <%@ include file ="head.html"%>
    <%
       response.setHeader("Pragma","no-cache"); // HTTP 1.0
       response.setHeader("Cache-Control","no-store"); // HTTP 1.1
       response.setDateHeader("Expires", 0);
       %>
  </head>
  <body>
    <%@ include file = "navbar.jsp" %>
    <div class="container">
      <%@ include file = "errormsg.jsp" %>
    </div>
    <div class="wrap">
      <div class="container">
	<%
	   String task_id = request.getParameter("taskid");
	   String uname = (String) session.getAttribute("theUname");
	   int login_type = (Integer) session.getAttribute("theLoginType");
	   session.setAttribute("theTask_ID", task_id);
	   %>
	<%
           paramList.clear();
           paramList.add(task_id);
           crs = execQuery(40, paramList);
           // rs = stmt.executeQuery("Select * from task WHERE id=" + task_id);

           crs.next();
	   String chk_uname = crs.getString("uname");
	   if(!chk_uname.equals(uname)) {
	   session.setAttribute("errMsg", "Access Denied. You can only view your own task."); 
	   // response.sendRedirect("task.jsp");
	   %>
        <jsp:forward page="task.jsp" />      
        <%
	   }

	   String tname = crs.getString("name");
	   String task_detail = crs.getString("detail");
           session.setAttribute("theTaskName", tname);
	   %>

	<% if(login_type == 1) {  %>
	<a class="btn btn-inverse" href="creategame.jsp"> Create Game </a>
	<% } %>

	<% if(login_type == 1) {  %>
	<a class="btn btn-inverse" href="upload.jsp">Upload Image Set </a>
	<% } %>

	<% if(login_type == 1) {  %>
	<a class="btn btn-inverse" href="result.jsp">View Overall Scoring </a>
	<% } %>

	<% if(login_type == 2) {  %>
	<a class="btn btn-inverse" href="result.jsp">View Volunteer Scoring </a>
	<% } %>
	
	<span class="pull-right">
	  <a class="btn btn-success" href="play.jsp?type=0">Knockout</a>
	  <a class="btn btn-success" href="play.jsp?type=1">Challenging</a>
	  <a class="btn btn-success" href="play.jsp?type=2">Round-robin</a>
	</span>
	<hr>
      </div>

      <div class="container">
	<div class="hero-unit">
          <h2><%= tname %></h2>
	  <pre style="text-align:justify"><%= task_detail%></pre>
	  <% if(login_type == 1) {  %>
	  <form method="POST" action="edittask.jsp">
	    <input type="hidden" name="taskdetail" value="<%= task_detail%>">
	    <button class="btn btn-primary pull-right" type="submit">Edit</button>	  
	  </form>
	  <% } %>
	</div>
	<hr>
	<%
	   int counter = 0;
           paramList.clear();
           paramList.add(task_id);
           crs = execQuery(41, paramList);
           // rs = stmt.executeQuery("SELECT * from `method` WHERE task_id=" + task_id );

	   //TODO: mname array: figure out its size properly while declaring the variable.
           String mname[] = new String[100];
           int mcount=0;
           while(crs.next()) {
	   mname[mcount] = crs.getString("name");
	   mcount++;

	   }
	   session.setAttribute("theMethodArray", mname);
           session.setAttribute("theMethodCount", mcount);
	   //String[] method =(String[]) session.getAttribute("theMethodArray");


           paramList.clear();
           paramList.add(task_id);
           crs = execQuery(42, paramList);
           // rs = stmt.executeQuery("SELECT * from `set` WHERE task_id=" + task_id );
	   String img_path;

           int i;
           while(crs.next()) {
           String set_id = crs.getString("id");
	   img_path = "uploads/" + uname + "/" + tname + "/" + set_id + "/" + "original" + ".jpg";
	   counter=0;
	   %>
	<div class="container-fluid row-fluid">
	  <div class="span3"  style="background-color:#000000">
	    <div class="thumbnail">
	      <img src= <%= img_path.replaceAll(" ", "%20")%> alt= <%= "Original Image" %> height= 150px />
	      <h5 style="color:#ffffff"> <% out.print("Original Image"); %>
		<% if(login_type == 1) {  %>
		<form method="POST" action="set.jsp" class="pull-right" style="margin:0 0 0 0;">
		  <input type="hidden" name="set_id" value=<%= set_id%> />
		  <button class="btn btn-link" type="submit">Edit</button>
		</form>
		<% } %>
	      </h5>
	    </div>
	  </div>
	  <div class="span8">
	    <ul class="thumbnails">
	      <%
		 for(i=0; i<mcount; i++) {
		    img_path = "uploads/" + uname + "/" + tname + "/" + set_id + "/" + mname[i] + ".jpg";
		%> 
		 <li class="span3" style="background-color:#eeeeee">
		   <div class="thumbnail">
		     <img class="img_thumb" src= <%= img_path.replaceAll(" ", "%20") %> alt= <%= mname[i]%> />
		     <h5 style="overflow:hidden"> <% out.print(mname[i]); %> </h5>
		   </div>
		 </li>
		 <%
		    counter++;
		    if(counter%4 == 0) {
		    %>
	    </ul>
	    <ul class="thumbnails">
	      <% counter = 0;
		 }
		 }
		 %>
	    </ul>
	  </div>
	</div>
	<hr class="hairline">
	<%
	   }
	   con.close();
	   %>
      </div>
    </div>
</div>
<%@ include file = "footer.html" %>
</body>
</html>
