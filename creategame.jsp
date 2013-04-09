<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp"%>
<%@ page import="org.apache.commons.lang.RandomStringUtils.*" %>
<%@ page import="java.util.Random.*" %>
<%@ include file="check_session.jsp" %>

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
    <script>
      var current_count = new Number(0);
      function add_method_field(count){
	  var i;
	  if(count <= current_count) {
	      i = 1;
	      document.getElementById("email_div").innerHTML = null;      
	  }
	  else {
	      i = current_count+1;
	  }
	  for(; i<=count; i++) {
	      //alert(i);
	      var obj = document.createElement('input');
	      obj.setAttribute('type', 'text');
	      obj.setAttribute('name', 'email');
	      obj.setAttribute('class', 'input-block-level');
	      obj.setAttribute('placeholder', 'Email id ' + (i));
	      //obj.setAttribute('onblur', 'validateForm_email(this)');
	      
	      document.getElementById("email_div").appendChild(obj);
          }
	  if(parseInt(count) > 0)
	      current_count = parseInt(count);
	  else {
	      current_count = 0;
	      document.getElementById("email_div").innerHTML = null;      
	  }
      }

      // function add_email_field(){
      // 	  var obj = document.createElement('input');
      // 	  obj.setAttribute('type', 'text');
      // 	  obj.setAttribute('name', 'email');
      // 	  obj.setAttribute('class', 'input-block-level');
      // 	  obj.setAttribute('placeholder', 'Email id ' + (i+1));
      // 	  obj.setAttribute('onblur', 'validateForm_email(this)');
	  
      // 	  document.getElementById("email_div").appendChild(obj);
      // }
    </script>
  </head>
  <body>
    <%@ include file = "navbar.jsp" %>
    <div class="container">
      <%@ include file = "errormsg.jsp" %>
    </div>
    <%
       String task_id = (String) session.getAttribute( "theTask_ID" );
       String uname = (String) session.getAttribute("theUname");
       
       paramList.clear();
       paramList.add(task_id);
       rs = execQuery(70, paramList);
       // rs = stmt.executeQuery("Select * from task WHERE id=" + task_id);
       String tname=null;
       if(rs.next()) {
	   tname = rs.getString("name");
       }
       
       String code = "";
       String charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
       for(int i=0; i<10; i++)
	   code = code + charSet.charAt(((int)(Math.random()*1000))%36);
      %>


    <div class="wrap">
      <div class="container">
	<form class="form-signin" method="POST" action="savegame.jsp" id="game_form">
	  <input type="hidden" name="code" value=<% out.println(code); %>>
	  <p class="lead"><%=tname%></p>
	  <pre>Code : <%= code%></pre>
	  <span class="help-block">Number of Volunteers</span>
          <input type="text" name="method_count" class="input-mini" onchange="add_method_field(this.value)">
	  <hr class="hairline">
	  <p>Email id</p>
	  <div id="email_div">
	  </div>
	  
          <button class="btn btn-large btn-primary" type="submit">Sign in</button>
	</form>
      </div>
    </div>
    <%@ include file = "footer.html" %>
  </body>
</html>
