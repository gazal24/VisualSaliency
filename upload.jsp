<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp" %>
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
	   String task_id = (String) session.getAttribute( "theTask_ID" );
	   String tname = (String) session.getAttribute("theTaskName");
	 %>  
	<form class="form-horizontal form-upload span5 offset3" id="upload_form" action="saveimage.jsp" method="POST" enctype="multipart/form-data" onsubmit="return validateForm_upload(this);">
	  <p class="lead"><%=tname%></p>
	  <span class="help-inline">Upload Images</span>
	  <hr>
	  <div class="control-group" style="margin-bottom:0px">
	    <p class="control-label" style="overflow:hidden">Original Image</label>
	    <div class="controls">
	      <input type="hidden" name="mname" class="input-block-level" value="Original Image">
	      <input type="file" name="original" class="input-block-level">
	    </div>
	  </div>

	  <%
	     paramList.clear();
             paramList.add(task_id);
             //String query = "SELECT * FROM `method` WHERE `task_id` = " + task_id;
             rs = execQuery(120, paramList);
             int i=0;
	     String m_name;
             while(rs.next()) { 
	     i++;
	     m_name = rs.getString("name");
          %>
	  <!-- <input type="hidden" name="mname" value= <% out.print("'" + m_name + "'"); %>> -->
	  <div class="control-group" style="margin-bottom:0px">
	    <p class="control-label" style="overflow:hidden"><%= m_name%></label>
	    <div class="controls">
	      <input type="hidden" value="<%= m_name %>">
	      <input type="file" name= <% out.print("file"+i); %>>
	    </div>
	  </div>
	  <% 
	     }
	     con.close();
	  %>
	  <button type="submit" class="btn btn-primary pull-right">Upload</button>
	</form>
      </div>
    </div>
    <%@ include file = "footer.html" %>
  </body>
</html>
