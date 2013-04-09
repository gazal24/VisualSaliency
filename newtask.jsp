<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
  <head>
    <script src="helper_script.js"></script>
    <%@ include file ="head.html"%>
    <script>
      function add_method_field(count){
      document.getElementById("method_div").innerHTML = null;      
      for(i=0; i<count; i++) {
	  var obj = document.createElement('input');
	  obj.setAttribute('type', 'text');
	  obj.setAttribute('name', 'method_name');
	  obj.setAttribute('class', 'input-block-level');
	  obj.setAttribute('placeholder', 'Method Name' + i);
	  
	  document.getElementById("method_div").appendChild(obj);
      }
  }

    </script>
  </head>
  <body>
    <%@ include file = "navbar.jsp" %>
    <div class="wrap">
      <div class="container">
	<%@ include file = "errormsg.jsp" %>
      </div> <!-- /container -->
      <div class="container">
 	<form class="form-signin" method="POST" action="newsavetask.jsp" >
          <h3 class="form-signin-heading">Create New Task</h3>
          <input type="text" name="task_name" class="input-block-level" placeholder="Task Name">
          <textarea rows="4" name="task_desc" class="input-block-level" placeholder="Description (Optional)"></textarea>
          <input type="text" name="method_count" class="input-block-level" placeholder="Number of methods" onchange="add_method_field(this.value)">
	  <div id="method_div">
	  </div>	  
          <button class="btn btn-large btn-primary" type="submit">Sign in</button>
	</form>
      </div>
    </div>
    <%@ include file = "footer.html" %>
  </body>
</html>
