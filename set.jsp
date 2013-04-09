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
	   String set_id = request.getParameter("set_id");
	   String uname = (String) session.getAttribute("theUname");
	   String tname = (String) session.getAttribute("theTaskName");
	   String task_id = (String) session.getAttribute("theTask_ID");
	   String[] mname =(String[]) session.getAttribute("theMethodArray");
	   int mcount =  (Integer)session.getAttribute( "theMethodCount" );

	   String img_path = "uploads/" + uname + "/" + tname + "/" + set_id + "/" + "original" + ".jpg";
	   int i;
	   %>
	
	<ul class="breadcrumb">
        <li><a href=<%="method.jsp?taskid="+task_id%>><%= tname %></a><span class="divider">/</span></li>
        <li class="active">Set<span class="divider">/</span></li>
	</ul>

	<div class="container-fluid row-fluid">
	  <div class="span3" >
	    <div class="thumbnail"  style="background-color:#000000">
	      <img src= <%= img_path.replaceAll(" ", "%20")%> alt= <%= "Original Image" %> height= 150px />
	      <h5 style="color:#ffffff"> <% out.print("Original Image"); %>
	      </h5>
	    </div>
	    <div>
	      <form action="editimage.jsp" class="pull-right" style="margin:0 0 0 0;" enctype="multipart/form-data"  method="POST">
		<input type="hidden" name="set_id" value=<%= set_id %> />
		<input type="hidden" name="method_name" value="original" />
		<input type="file" name="original">
		<button class="btn btn-small btn-primary" type="submit">Save</button>
	      </form>
	    </div>
	  </div>
	  <div class="span8">
	      <%
		 for(i=0; i<mcount; i++) {
		    img_path = "uploads/" + uname + "/" + tname + "/" + set_id + "/" + mname[i] + ".jpg";
		%> 
		 <ul class="thumbnails">
		 <li class="span4" style="background-image:url('bg-site.png');">
		   <div class="thumbnail">
		     <img class="img_thumb" src= <%= img_path.replaceAll(" ", "%20") %> alt= <%= mname[i]%> />
		     <h5 style="overflow:hidden"> <% out.print(mname[i]); %> </h5>
		   </div>
		 </li>
		 <li>
		   <form action="editimage.jsp" class="pull-right" style="margin:0 0 0 0;" enctype="multipart/form-data"  method="POST">
		     <input type="hidden" name="set_id" value=<%= set_id %> />
		     <input type="hidden" name="method_name" value='<%= mname[i]%>' />
		     <input type="file" name="original">
		     <button class="btn btn-small btn-primary pull-left" type="submit">Save</button>
		   </form>
		 </li>
	    </ul>
		 <hr>
	      <%
	      }
	      %>
	  </div>
	</div>
      </div>
    </div>
    <%@ include file = "footer.html" %>
  </body>
</html>
