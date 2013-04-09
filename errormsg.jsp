<% String posMsg = (String) session.getAttribute("posMsg"); 
   String errMsg = (String) session.getAttribute("errMsg"); %>

<% if(posMsg != null) { %>
<div class="alert alert-success">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Well Done!</strong> <% out.println(posMsg);%>
</div>
<% } %>

<% if(errMsg != null) { %>
<div class="alert alert-error">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Oops!</strong> <% out.println(errMsg);%>
</div>
<% } %>

<% session.setAttribute("posMsg", null);
   session.setAttribute("errMsg", null); %>
