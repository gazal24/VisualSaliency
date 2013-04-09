<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp" %>
<%@ include file="check_session.jsp" %>

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
	<div>
	  <a href="newtask.jsp" class="btn btn-inverse pull-right">Create Task</a>
	</div>
	<div class="row-fluid">
	  <ul class="thumbnails">
	    <% String uname = (String) session.getAttribute("theUname"); %>
	    <%
               paramList.clear();
               paramList.add(uname);
               // query = "SELECT * from task WHERE uname = '" + uname +"'";
               crs = execQuery(30, paramList);
	       
	       int counter = 0;
	       String img_path;
               while(crs.next()) {
               String tname = crs.getString("name"); 
               String task_id = crs.getString("id");
               String task_detail = crs.getString("detail");
	       img_path = "uploads/" + uname + "/" + tname + "/" + "103/" +"original" + ".jpg";
  	       if(counter%3 == 0) { %> 
	  </ul>
	</div>
	<div class="row-fluid">
	  <ul class="thumbnails">
	    <% counter = 0; 
	       }
	    %> 
            <li class="span4">
	      <div class="thumbnail">
		<div class="thumbnail" style="height:200px;">
                  <img data-src="holder.js/300x300" alt="" style="max-height: 200px; max-width: 350px;" src=<%= img_path %>>
		</div>
                <div class="caption">
                  <h3><% out.print(tname); %></h3>
                  <p style="height:80px;overflow:hidden"><%= task_detail %></p>
                  <p><a href=<% out.print("method.jsp?taskid="+task_id);%> class="btn btn-primary btn-small">View</a> <a href="#" class="btn btn-small">Manage</a></p>
                </div>
	      </div>
            </li>
            <%
	       counter++;
               }
               con.close();
	    %>
          </ul>
        </div>
      </div>
    </div>
    <%@ include file = "footer.html" %>
  </body>
</html>
