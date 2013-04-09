<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container">
      <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="brand" href="#">Visual Saliency</a>
      <div class="nav-collapse collapse">
        <ul class="nav">
          <li><a href="/tournament/">Home</a></li>
          <li><a href="#about">About</a></li>
          <li><a href="#contact">Contact</a></li>
	  <% String s2 = (String)session.getAttribute("isValid");
	     if (s2 != null) { %>
	  <li class="divider-vertical"></li>          
	  <li><a href="task.jsp">Task</a></li>
	  <% } %>
        </ul>
	<% s2 = (String)session.getAttribute("isValid");
	   if (s2 == null) { %>
        <form class="navbar-form pull-right" method="post" action="checklogin.jsp">
	  <input type="hidden" name="login_type" value="1">
	  <input class="span2" type="text" name="uname" placeholder="Username">
	  <input class="span2" type="password" name="passwd" placeholder="Password">
          <button type="submit" class="btn">Sign in</button>
        </form>
	<% } else { %>
	<div class="navbar-text pull-right">	
	  <ul class="nav">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Account <b class="caret"></b></a>
              <ul class="dropdown-menu">
		<li><a href="settings.jsp">Settings</a></li>
		<li><a href="#">Something else here</a></li>
		<li class="divider"></li>
		<li class="nav-header">Nav header</li>
		<li><a href="#">Separated link</a></li>
		<li><a href="logout.jsp">Logout</a></li>
              </ul>
            </li>
	  </ul>
          Welcome <a href="#" class="navbar-link"><%= session.getAttribute("theName") %></a>
        </div>
	<% } %>
      </div><!--/.nav-collapse -->
    </div>
  </div>
</div>
