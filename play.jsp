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
    //      window.onload = loadXMLDoc(0);
    window.onload = initPlay();

    function initPlay() {
	fetch_original();
        loadXMLDoc(0);
    }

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
		      document.getElementById("img1").src = "images/black.png";
		      document.getElementById("img2").src = "images/black.png";
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

    
    function fetch_original() {
	var xmldoc = new XMLHttpRequest();
	if (window.XMLHttpRequest)
	    {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	    }
	else
	    {// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	    }
	xmldoc.open("GET", "multiQuery.jsp?random="+Math.random(), true);
	xmldoc.send();
	xmldoc.onreadystatechange = function() {
	    if (xmldoc.readyState==4 && xmldoc.status==200) {
		resptxt = xmldoc.responseText;
		var responseJSON = eval('('+ resptxt +')');
		document.getElementById("original").src = responseJSON.originalImg;
		document.getElementById("original_div").style.display = "none";
	    }
	}
    }

    function toggle() {
    		if(document.getElementById("original_div").style.display == "none") {
		    document.getElementById("original_div").style.display = "inline";
		    document.getElementById("showOriginal").innerHTML = "Hide Original";
		}
		else {
		    document.getElementById("original_div").style.display = "none";
		    document.getElementById("showOriginal").innerHTML = "Show Original";
		}

    }

    </script>

  </head>
  <body align="center">
    <div align="right"> <p onclick="loadXMLDoc(0)" class="medium button black" align="right">Restart</p></div>
    <a href="result.jsp" id="result" align="center"> </a>
    <div align="right"> 
      <% if(strategy==0) out.println("<a class=\"super button pink\"> Knockout </a>"); %>
      <% if(strategy==1) out.println("<a class=\"super button green\"> Challenging </a>"); %>
      <% if(strategy==2) out.println("<a class=\"super button blue\"> Round-robin </a>"); %>
    </div>
    <div align="center">
      <p id="showOriginal" onclick="toggle()" class="medium button black" align="center">Show Original</p>
    </div>
    <div id="original_div">
      <table class="image_panel fixed">
	  <th>
	    Original
	  </th>
	
	<tr><td>
	    <img id="original" src="" class="mainimage"></img>
      </td></tr></table>
    </div>
    <br>
    <div>
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
