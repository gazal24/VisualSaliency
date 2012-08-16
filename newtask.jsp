<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

<html>

  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
  <body>
    <table align = center>
      <tr><td> <%@ include file = "errormsg.jsp" %> </td></tr>
      <tr><td align = right>
	  <div>
	    Hello! <%= session.getAttribute( "theUname" ) %>
	  </div>
      </td></tr><tr><td>
	  <br>
	  <br>
	  <br>
      <jsp:declaration>
	
	Statement stmt;
	Connection con;
	String url = "jdbc:mysql://localhost:3306/proj1";
	
      </jsp:declaration>

      <form method=post action="savetask.jsp">
      	New Task :
	<div class="field"> <input type=text name= name size=20 placeholder="Task Name"> </div>
	<div class="field"> <input type=text name= count size= 50 placeholder="3"> </div>
	<br>
	<div class="buttons"> 

	  <button type="create" class="positive" name="save"> 
	    <img src="images/apply2.png" alt=""/>
            Register
	  </button>

	  <a href="newtask.jsp" class="regular">
            <img src="images/textfield_key.png" alt=""/>
            Reset
	  </a>   <a href="index.jsp" class="negative">
            <img src="images/cross.png" alt=""/>
	    Back
	  </a>
	</div>
      </form>
      <div>
  </body>
</html>
