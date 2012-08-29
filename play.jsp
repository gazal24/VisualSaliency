<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>



      <html>
      <head>
      <link href="style.css" rel="stylesheet" type="text/css">
      <link href="flash.css" rel="stylesheet" type="text/css">
      <script>
//       function loadXMLDoc()
// {
//     var xmlhttp;
//     if (window.XMLHttpRequest)
// 	{// code for IE7+, Firefox, Chrome, Opera, Safari
// 	    xmlhttp=new XMLHttpRequest();
// 	}
//     else
// 	{// code for IE6, IE5
// 	    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
// 	}
//     xmlhttp.onreadystatechange=function()
//     {
// 	if (xmlhttp.readyState==4 && xmlhttp.status==200)
// 	    {
// 		document.getElementById("foo").innerHTML=xmlhttp.responseText;
// 	    }
//     }
//     xmlhttp.open("GET","game.jsp",true);
//     xmlhttp.send();
// }
      
      function loadXMLDoc(a)
      { 
	  var xmldoc = new XMLHttpRequest();
	  xmldoc.open("GET", "game.jsp?choice="+a, true);
	  xmldoc.send();
	  
	  xmldoc.onreadystatechange=function() {
	      if (xmldoc.readyState==4 && xmldoc.status==200)
		  document.getElementById("foo").innerHTML = xmldoc.responseText;
	  }
      }


      </script>

  </head>
  <body>
    <div>
      <table>
	<tr>
	  <td>
	    <img id="img1" onclick="loadXMLDoc(1)" src="images/cross.png">
	  </td>
	  <td>
	    <img id="img2" onclick="loadXMLDoc(2)" src="images/apply2.png"></img>
	    <p id="foo"> as </p>
	  </td>
	</tr>
      </table>
    </div>
  </body>
</html>
