<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>

<html>
  <head>
    <title>Error page</title>
    <style>
      * { font-family: Verdana }
      #navbar {
      float: left;
      width: 20%;
      margin-left: 20%;
      }    
      #content {
      margin-left: 30%;
      }

    </style>
  </head>
  <body>
    <div id="container" align="center">
      <div id="navbar"><br><br><br><br>
	<h1> Oops! Something bad happened. </h1>
      </div>
      <div id="content">
	<img src="404.jpg"></img>
      </div>
    </div>
    <div>
      <h4>Error occured!</h4>
      <p>Message <jsp:expression> exception.getMessage() </jsp:expression>
    </div>
  </body>
</html>
