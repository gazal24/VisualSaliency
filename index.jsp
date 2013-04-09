<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="dbconnect.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file ="head.html"%>
  </head>
  <body>
    <%@ include file = "navbar.jsp" %>
    <div class="container">
      <%@ include file = "errormsg.jsp" %>
      <% s2 = (String)session.getAttribute("isValid");
	 if (s2 == null) { %>
      <a class="btn pull-right" href="register.jsp">New User? Sign Up!</a>
      <form method="POST" action="checklogin.jsp">
	<input type="hidden" name="login_type" value="2" />
	<input class="input" type="text" name="email_id" size="20" placeholder="Player ID">
	<input type="text" name="code" size="20" placeholder="CODE">
        <button type="submit" class="btn">Log in</button>
      </form>
      <% } %>
      <% String s1 = (String)session.getAttribute("isValid");
	 if(s1 != null && s1.equals("logout") == true) {
	     session.invalidate();
	 }
      %>
      <div class="hero-unit">
        <h1>Hello, world!</h1>
        <p>This is a template for a simple marketing or informational website. It includes a large callout called the hero unit and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
        <p><a href="#" class="btn btn-primary btn-large">Learn more &raquo;</a></p>
      </div>
      
      <!-- Example row of columns -->
      <div class="columns">
        <div class="span0" id="about">
          <h2>About</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn" href="#">View details &raquo;</a></p>
        </div>
        <div class="span0">
          <h2>FAQs</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn" href="#">View details &raquo;</a></p>
	</div>
        <div class="span0" id="contact">
          <h2>Contact</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          <p><a class="btn" href="#">View details &raquo;</a></p>
        </div>
      </div>
      <hr>
    </div> <!-- /container -->
    <%@ include file = "footer.html" %>
  </body>
</html>
