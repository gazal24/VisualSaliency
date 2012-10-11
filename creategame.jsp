<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="dbconnect.jsp"%>
<%@ page import="org.apache.commons.lang.RandomStringUtils.*" %>
<%@ page import="java.util.Random.*" %>
<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="button.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="helper_script.js"></script>
    <script>
      id = 2;
      function add_email_field(){
      var obj = document.createElement('div');
      obj.innerHTML = "<br /> <a class='field'><input type='text' name='email' size='20' placeholder='Email id " + id + "' /></a>"
      document.getElementById("email_field").appendChild(obj);

      id++;
      }

    </script>

  </head>
  <body>
  <%
     int task_id = (Integer)session.getAttribute( "theTask_ID" );
     String uname = (String) session.getAttribute("theUname");
  %>
    <div align="center" width="800">
      Hello! <%= session.getAttribute( "theUname" ) %>
      <%@ include file = "errormsg.jsp" %>

    </div>
    <br/>

    <div align="center">
      <%
      	 rs = stmt.executeQuery("Select * from task WHERE id=" + task_id);
	 rs.next();
	 String tname = rs.getString("name");
	 out.println("<b>Task Name : </b>" + tname);
      %>
      <br>
      <%
	 String code = "";
	 String charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
	 for(int i=0; i<10; i++)
	     code = code + charSet.charAt(((int)(Math.random()*1000))%36);
         out.println("<b>Code : </b>" + code);
      %>

    </div>
    
    <div align="center">
      <form method="post" action="savegame.jsp" id="game_form">
	<span onclick="add_email_field()">[+]</span>
	<input type="hidden" name="code" value=<% out.println(code); %> />
	<div id="email_field">
	  <a class="field"><input type="text" name="email" size="20" placeholder="Email id"></input></a>
	</div>
	<br />
	<div class="buttons">
	  <button type="submit" class="positive" name="save"> 
	    <img src="images/apply2.png" alt=""/> Save
	  </button>
	  <button type="button" class="regular" onclick="formReset('game_form')">
	    <img src="images/textfield_key.png" alt=""/> Reset
	  </button>
	</div>
      </form>
    </div>
</body>
</html>







