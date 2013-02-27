<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

<table>
  <%
     String errMsg = (String) session.getAttribute("errMsg");
     if(errMsg != null) { %>
  
  <tr class="buttons" id="negmsg" onclick="hide_ele('negmsg')">
    <td>
      <a class="negative" align="center"> <% out.println(errMsg);%>
	<br />
	<span style="color:grey; font-size:10px">Click to hide</span>
    </td>
  </tr>
  
  <% session.setAttribute("errMsg", null); 
  } %>

  <%
     String posMsg = (String) session.getAttribute("posMsg");
     if(posMsg != null) { %>
  <tr class="buttons" id="posmsg" onclick="hide_ele('posmsg')">
    <td>
      <a class="positive" align="center"> <% out.println(posMsg); %>
	<br />
	<span style="color:grey; font-size:10px">Click to hide</span>
    </td>
  </tr>
  <% session.setAttribute("posMsg", null); 
  } %>
</table>
