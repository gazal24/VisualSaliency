<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html>
  <head>
    <script src="helper_script.js"></script>
    <%@ include file ="head.html"%>
  </head>
  <body>
    <%@ include file = "navbar.jsp" %>
    <div class="wrap">
      <div class="container">
	<%@ include file = "errormsg.jsp" %>
      </div> <!-- /container -->
      <div class="container">
 	<%
	   String tname = (String)session.getAttribute("theTaskName");   
	   String task_detail = (String)request.getParameter("taskdetail");
	%>
	<form action="multiQuery.jsp?type=updateTaskDetail" method="POST">
	  <h3><%= tname %></h3>
	  <textarea rows="10" name="taskdetail" class="input-block-level"><%= task_detail%></textarea>
	  <button class="btn btn-primary" type="submit">Save</button>
	</form>
      </div>
    </div>
    <%@ include file = "footer.html" %>
  </body>
</html>

