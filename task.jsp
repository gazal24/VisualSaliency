<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

<html>
  <head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="flash.css" rel="stylesheet" type="text/css">
  </head>
  <body>

    <!-- <div class="fixwidth" style="display:block" id="flash-notice" onclick="$(this).hide();"> -->
    <!--   <table align="center"><tr><td> -->
    <!-- 	    <div class="flash" align="center" width="800"> -->
    <!-- 	      <div class="success"> -->
    <!-- 		Successfully updated your profile. <span class="gray-text" style="font-size:10px;">Click to hide</span> -->
    <!-- 	      </div> -->
    <!-- 	    </div> -->
    <!--   </td></tr></table> -->
    <!-- </div> -->

    <div align="center" width="800">
      Hello! <%= session.getAttribute( "theUname" ) %><br />
      <%@ include file = "errormsg.jsp" %>
    </div>
    <div width="800">
      <table align="center" width="600">
	<% String uname = (String) session.getAttribute("theUname"); %>
	<jsp:declaration>
	  
	  Statement stmt;
	  Connection con;
	  String url = "jdbc:mysql://localhost:3306/proj1";
	  
      </jsp:declaration>

      <%
	 Class.forName("com.mysql.jdbc.Driver");
	 con = DriverManager.getConnection(url, "root", "root"); 
	 stmt = con.createStatement();
         ResultSet rs = stmt.executeQuery("SELECT * from task WHERE uname = '" + uname +"'" );
       
	 int counter = 0;
	 String img_path;
 	 out.println("<tr>");
         while(rs.next()) {
           String tname = rs.getString("name"); 
           String task_id = rs.getString("id");
	   img_path = "uploads/" + uname + "/" + tname + "/" + "original" + ".jpg";
  	   if(counter%3 == 0) { out.println("</tr><tr>"); counter = 0;}
      %> 
	<td class="buttons" width="500" align="center"><br>
	 <img src= <% out.print(img_path);%> alt= <% out.print(tname);%> height=100px width= 150px /> <br/>
	  <a class="regular" href=<% out.print("method.jsp?taskid="+task_id); %> > <% out.print(tname); %> </td>
        <%
	 counter++;
         }
         con.close();
	%>
	</tr>
      </table>
    </div>
    <div align="center">
    <table>
      <tr><td align="center"><br> <br>
	  
      <form method=post action="savetask.jsp">
      	New Task :
	<div class="field"> <input type=text name= name size=20 placeholder="Task Name"> </div>
	<div class="field"> <input type=text name= count size= 50 placeholder="2"> </div>
	<br>
	<div class="buttons"> 

	  <button type="create" class="positive" name="save"> 
	    <img src="images/apply2.png" alt=""/>
	    Create
	  </button>

	  <a href="task.jsp" class="regular">
            <img src="images/textfield_key.png" alt=""/>
            Reset
	  </a>   <a href="index.jsp" class="negative">
            <img src="images/cross.png" alt=""/>
	    Back
	  </a>
	</div>
      </form>
      </td></tr></table>
      </div>
  </body>
</html>
