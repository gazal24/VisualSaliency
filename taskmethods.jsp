<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

<html>

  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <%
       String task_name = (String) session.getAttribute("theTask");
       Integer method_count =  (Integer) session.getAttribute( "theCount" );
    %>

  </head>
  <body>
    <table align = center>
      <tr><td>
	  <br>
	  <form method=post action="savemethod.jsp">
	    <table>

	  <%
	     int i=0;
	     for(i=0; i<method_count; i++)
				      {
				      %>
	     <tr>
	       <td class="field">
		 <%  out.print(i+1 +" : ");   %>
		 <input type=text name= m_name size=20 placeholder="method name">
	       </td>
	     </tr>
	     
	     <% } %>
	     <tr>
	    <input type= hidden name= m_count value= <% out.println(method_count); %> >
	     <td class="buttons"> 
	       <button type="submit" class="positive" name="save"> 
		 <img src="images/apply2.png" alt=""/> save
	       </button>
	       <a href="getname.jsp" class="regular">
		 <img src="images/textfield_key.png" alt=""/>  Reset
	       </a>
	     </td>
	     </tr>
	    </table>
	  </form>
  </body>
</html>

