<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ include file="dbconnect.jsp" %>
<html>
  <head>

    <script src="helper_script.js"></script>
    <style>
      #content {
      margin-left:  20%;
      }
      #navbar {
      float: left;
      width: 20%;
      }    
    </style>

    <script>
      // comment

      function change_content(tab) {
	  var xmldoc = new XMLHttpRequest();
          if (window.XMLHttpRequest)
	      {// code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
	      }
          else
	      {// code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }
	  xmldoc.open("GET", tab+".html?random="+Math.random(), true);
	  xmldoc.send();
	  xmldoc.onreadystatechange=function() {
	      if (xmldoc.readyState==4 && xmldoc.status==200) {
		  resptxt = xmldoc.responseText;
		  document.getElementById("Tab_content").innerHTML = resptxt;
	      }
	  }
      }


    </script>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="button.css" rel="stylesheet" type="text/css">
  </head>
  <body>
    <div align="center" width="800">
      Hello! <%= session.getAttribute( "theName" ) %><br />
      <%@ include file = "errormsg.jsp" %>
    </div>
    
    <div id="container" align="center">
      <div id="navbar" align="left">
	<ul>
	  <li><a href="#" onclick="change_content('name')">Change Name</a></li>
	  <li><a href="#" onclick="change_content('passwd')">Change Password</a></li>
	</ul>
      </div>


      <div id="content" align="left" style="border:1px solid gray; width:450px; height:300px; margin-bottom: 1em; padding: 10px">
	<div id="Tab_content">

	</div>
      </div>
  </body>
</html>
