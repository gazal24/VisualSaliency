<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

<table>
<%
   String errMsg = (String) session.getAttribute("errMsg");
   if(errMsg != null) { %>

       <tr class=buttons><td><a class="negative"> <% out.println(errMsg); %> </td></tr>
       <% session.setAttribute("errMsg", null); 
   } %>
<%
   String posMsg = (String) session.getAttribute("posMsg");
   if(posMsg != null) { %>
      <tr class=buttons><td><a class="positive"> <% out.println(posMsg); %> </td></tr>
      <% session.setAttribute("posMsg", null); 
   } %>
</table>
