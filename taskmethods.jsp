<%@ page contentType="text/html;charset=UTF-8" %>

<html>

  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <%
       String tname = (String) session.getAttribute("theTaskName");
Integer mcount =  Integer.parseInt((String)session.getAttribute( "theMethodCount" ));
    %>
    <script src="helper_script.js"></script>
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
	    <a class="positive">Task : <%= tname %> </a>
	    <br />
	    <br />
	    <a class="regular">Enter Method Names </a>

	    <form id="method_form" method="post" action="savemethod.jsp">
	      
	   <%
	     int i=0;
	     for(i=0; i<mcount; i++)
				      {
				      %>
              <div class="field">					  
	       <a style="font:bold"> <%= i+1 %> : </a>
		<input type="text" name="m_name" size="20" placeholder="method name">
	      </div>
	     <% } %>
	     
	     <input type= hidden name= m_count value= <% out.println(mcount); %> >
	     <br />
	     <div class="buttons"> 
		   
	       <button type="submit" class="positive" name="save"> 
		 <img src="images/apply2.png" alt=""/> save
	       </button>
	       
	       <button type="button" class="regular" onclick="formReset('method_form')" value="Reset">
		 <img src="images/textfield_key.png" alt=""/> Reset
	       </button>	  
	     </div>
	    </form>
	  </td></tr>
	</table>
  </body>
</html>

