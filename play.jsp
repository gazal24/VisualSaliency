<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>
<%
Integer strategy = new Integer(1);
strategy = Integer.parseInt(request.getParameter("type"));
session.setAttribute("theStrategy", strategy);
%>

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="button.css" rel="stylesheet" type="text/css">
    <script>
    // Code to initialize the game with method[0] and method[1] image.
      window.onload = loadXMLDoc(0);

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
		  if(responseJSON.left == "gameOver") {
		      document.getElementById("img1_txt").innerHTML = "GAME";
		      document.getElementById("img1").src = "images/cross.png";
		      document.getElementById("img2").src = "images/apply2.png";
		      document.getElementById("img2_txt").innerHTML = "OVER";
		      document.getElementById("result").innerHTML = "Click to see result";
		  } else {
		      document.getElementById("img1_txt").innerHTML = responseJSON.left_method;
		      document.getElementById("img1").src = responseJSON.left
		      document.getElementById("img2_txt").innerHTML = responseJSON.right_method;
		      document.getElementById("img2").src = responseJSON.right;
		      document.getElementById("result").innerHTML = "";
		  }
	      }
	  }
      }

    </script>

  </head>
  <body align="center">
    <p onclick="loadXMLDoc(0)" align="center"> Restart </p>
    <a href="result.jsp" id="result" align="center"> </a>
    <p align="center"> 
      <% if(strategy==0) out.println("<a class=\"super button pink\"> Knockout"); %>
      <% if(strategy==1) out.println("<a class=\"super button green\"> Challenging"); %>
      <% if(strategy==2) out.println("<a class=\"super button blue\"> Round-robin"); %>
</a>
    </p>
    <div align="center">
      <table align="center" class="image_panel fixed" style="border-collapse: collapse">
	<col class="players"/>
	<col class="players"/>
	<tr align="center">
	  <th>
	      <p id="img1_txt"></p>
	  </th>
	  <th>
	      <p id="img2_txt"></p>
	  </th>
	</tr>
	<tr>
	  <td align="center">
	    <img id="img1" onclick="loadXMLDoc(1)" class="mainimage"></img>
	  </td>
	  <td align="center">
	  <img id="img2" onclick="loadXMLDoc(2)"  class="mainimage"></img>
	  </td>
	</tr>
      </table>
    </div>
  </body>
</html>
