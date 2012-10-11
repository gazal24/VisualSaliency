<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>

<html>

  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <%
       String task_name = (String) session.getAttribute("theTask");
       Integer method_count =  (Integer) session.getAttribute( "theCount" );
    %>

  </head>
  <body>
    <div align="center" width="800">
      <%@ include file = "errormsg.jsp" %>
    </div>
    <div><table align="center" width="800">
    <tr><td align="right">
	    Hello! <%= session.getAttribute( "theUname" ) %>
	    <br> <br>
	</td></tr>
    </table></div>


    <div width="800">
	
	    <br>
	    <table align="center">
	      <tr><td class="buttons" align="center">
		  <a class="positive">Task : <% out.println(task_name);%> </a>
		  <br />
		  <br />
		  <a class="regular">Enter Method Names </a>
	      </td></tr>
	      <form method="post" action="savemethod.jsp">
		
	  <%
	     int i=0;
	     for(i=0; i<method_count; i++)
				      {
				      %>
	     <tr>
	       <td><a class="regular">
		   <%  out.println(i+1+" - "); %> </a>
		 <a class="field"><input type="text" name="m_name" size="20" placeholder="method name">
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

