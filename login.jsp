<%@ page import="Stra.Strategy" %>
<%
   Strategy sa = new Strategy(2,3);
   out.println(sa.game(3));
%>
<html>
  <head>
    <%
       session.setAttribute("theUname", "" );
       session.setAttribute("thePasswd", "");
       
       %>
    <link href="style.css" rel="stylesheet" type="text/css">
    <script>
      function formReset() {
      document.getElementById("login_form").reset();
      }

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
    </div>
    <div width="800">
      <table align="center" width="800">
	<tr>
	  <td align="left">
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
