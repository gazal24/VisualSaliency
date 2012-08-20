<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
  <body>
    <div align="center" width="800">
      <%@ include file = "errormsg.jsp" %>
    </div>
    <div width="800">
      <table align = center width="800">
	<tr>
	  <td align = left>
	    User Login :
	    <form method=post action="checklogin.jsp">
	      <div class="field"> <input type=text name= uname size=20 placeholder="Username"> </div>
	      <div class="field"> <input type=password name= passwd size= 50 placeholder="Password"> </div>
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
	    <form method=post action="checklogin.jsp">
	      <div class="field"> <input type=text name= uname size=20 placeholder="Player Name"> </div>
	      <br />
	      <br />
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
