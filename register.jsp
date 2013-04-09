<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
  <%@ include file ="head.html"%>
  </head>
    <script src="helper_script.js"></script>
    <%@ include file ="head.html"%>
  </head>
  <body>
    <%@ include file = "navbar.jsp" %>
    <div class="container">
      <%@ include file = "errormsg.jsp" %>
      <form  class="form-upload span4 offset4" id="register_form" method="POST" action="savename.jsp" onsubmit="return validateForm_register(this);">
        <h3 class="form-signin-heading">New User Registration</h3>

	<div class="control-group controls">
	  <input type="text" name="uname" placeholder="Username" onfocus="this.parentNode.className='control-group controls';">
	  <span class="help-inline" id="errormsg_uname"></span>
	</div>

	<div  class="control-group controls">
	<input type="text" name="name" placeholder="Name" onfocus="this.parentNode.className='control-group controls';">
	<span class="help-inline" id="errormsg_name"></span>
	</div>

	<div  class="control-group controls">
	<input type="text" name="email" placeholder="Email" onblur="validateForm_email(this);" onfocus="this.parentNode.className='control-group controls';">
	<span class="help-inline" id="errormsg_email"></span>
	</div>


	<div  class="control-group controls">
	<input type="password" name="passwd" placeholder="Password" onfocus="this.parentNode.className='control-group controls';">
	<span class="help-inline" id="errormsg_passwd"></span>
	</div>


	<div  class="control-group controls">
	<input type="password" name="repasswd" placeholder="Confirm Password" onfocus="this.parentNode.className='control-group controls';">
	<span class="help-inline" id="errormsg_repasswd"></span>
	</div>
        <button class="btn btn-primary" type="submit">Register</button>
      </form>
    </div> <!-- /container -->
  </body>
</html>
