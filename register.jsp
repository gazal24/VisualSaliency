<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>

<html>

  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <script>
      function formReset() {
      document.getElementById("register_form").reset();
      }
    </script>
  </head>
  <body>
    <div align="center">
      <table align="center">
	<tr><td> <%@ include file = "errormsg.jsp" %> </td></tr>
	</table>
    </div>
    <div align="center">
      <table>
      <tr><td>
	  <br>
	  <br>
      <form id="register_form" method="get" action="savename.jsp">
	<div class="field"> <input type="text" name="uname" size="20" placeholder="Username"> </div>
	<div class="field"> <input type="text" name="name" size="50" placeholder="Name"> </div>
	<div class="field"> <input type="password" name="passwd" size="50" placeholder="Password"> </div>
	<div class="field"> <input type="password" name="repasswd" size="50" placeholder="Confirm Password"> </div>
	<br>
	<div class="buttons"> 

	  <button type="submit" class="positive" name="save"> 
	    <img src="images/apply2.png" alt=""/>
            Register
	  </button>

	  <button type="button" class="regular" onclick="formReset()" value="Reset">
	    <img src="images/textfield_key.png" alt=""/> Reset
	  </button>	  
	  <a href="login.jsp" class="negative">
            <img src="images/cross.png" alt=""/>
	    Back
	  </a>

	</div>
      </form>
      <div>
  </body>
</html>
