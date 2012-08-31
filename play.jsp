<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="flash.css" rel="stylesheet" type="text/css">
    <script>
      function loadXMLDoc(a)
      {
	  var xmldoc = new XMLHttpRequest();
          if (window.XMLHttpRequest)
	      {// code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
	      }
          else
	      {// code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	      }
	  
	  
	  xmldoc.open("GET", "game.jsp?choice="+a+"&random="+Math.random(), true);
	  xmldoc.send();
	  xmldoc.onreadystatechange=function() {
	      if (xmldoc.readyState==4 && xmldoc.status==200) {
		  resptxt = xmldoc.responseText;
		  var responseJSON = eval('(' + resptxt + ')');
		  document.getElementById("img1").src = responseJSON.left;
		  document.getElementById("img2").src = responseJSON.right;
	      }
	  }
      }

    </script>

  </head>
  <body>
    <div>
      <table align="center">
	<tr>
	  <td>
	    <img id="img1" onclick="loadXMLDoc(1)" src="images/cross.png" width="400">
	  </td>
	  <td>
	    <img id="img2" onclick="loadXMLDoc(2)" src="images/apply2.png" width="400"></img>
	    <p id="foo"> as </p>
	  </td>
	  <td>
	    <p onclick="loadXMLDoc(0)"> init </p>
	  </td>

	</tr>
      </table>
    </div>
  </body>
</html>
