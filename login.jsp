<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
  <body>
    <table align = center>
       <tr><td> 
	   <%@ include file = "errormsg.jsp" %>
       </td></tr>
       <tr><td>
	   <br>
	   <br>
	   <br>
      <form method=post action="checklogin.jsp">
	<div class="field"> <input type=text name= uname size=20 placeholder="Username"> </div>
	<div class="field"> <input type=password name= passwd size= 50 placeholder="Password"> </div>
	<br>
	<div class="buttons"> 
	  <button type="submit" class="positive" name="save"> 
	    <img src="images/apply2.png" alt=""/>
	    Login
	  </button>
	  <a href="getname.jsp" class="regular">
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
