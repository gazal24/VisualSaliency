<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.sql.*,java.lang.*,webp_rmi.*,java.rmi.registry.*" %>
<%@ page import="java.net.*" %>

<%@ page import="Stra.Strategy" %>
<%@ page import="Stra.Node" %>

<%
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setHeader("Cache-Control","no-store"); // HTTP 1.1
response.setDateHeader("Expires", 0);
%>

<%
    Strategy sa = new Strategy(2,3);
Node na = new Node(1,2,3);
//   out.println(na.game(0));
//   out.println(sa.game(3));
int [][]arr = new int[10][10];
for(int i=0; i<10; i++)
    for(int j=0; j<10;j++)
	arr[i][j] = (i+1)*(j+1);

%>
<html>
  <head>
    <script src="helper_script.js"></script>
    <link href="style.css" rel="stylesheet" type="text/css">
    <script>
      function setTime() {
      document.getElementById("time").innerHTML = Date();
      setTimeout(function(){setTime()},900);
      }
      
      window.onload = function() {
      setTime();
      }
    </script>
  </head>
  <body >
    <div align="center" width="800">
      <p id="time"> </p>
      <%@ include file = "errormsg.jsp" %>
      <% session.invalidate(); %>
    </div>
    <div width="800">
      <table align="center" width="800">
	<tr>
	  <td align="left" class="meh">
	    User Login :
	    <form method="post" action="checklogin.jsp" id="login_form">
	      <input type="hidden" name="login_type" value="1" />
	      <div class="field"> <input type="text" name="uname" size="20" placeholder="Username"> </div>
	      <div class="field"> <input type="password" name="passwd" size="50" placeholder="Password"> </div>
	      <br>
	      <div class="buttons"> 
		<button type="submit" class="positive" name="save"> 
		  <img src="images/apply2.png" alt=""/>
		  Login
		</button>
		<a href="register.jsp" class="regular">
		  <img src="images/textfield_key.png" alt=""/>
		  New User? Sign Up!
		</a>
	      </div>
	    </form>
	  </td>
	  <td>
	    Player Login :
	    <form method="post" action="checklogin.jsp">
	      <input type="hidden" name="login_type" value="2" />
	      <div class="field"> <input type="text" name="email_id" size="20" placeholder="Player ID"> </div>
	      <div class="field"> <input type="text" name="code" size="20" placeholder="CODE"> </div>
	      <br />
	      <div class="buttons"> 
		<button type="submit" class="positive" name="save"> 
		  <img src="images/apply2.png" alt=""/>
		  Continue
		</button>
		<a href="index.jsp" class="negative">
		  <img src="images/cross.png" alt=""/>
		  Back
		</a>
	      </div>
	    </form>
	</td></tr>
      </table>
    </div>
  </body>
</html>
