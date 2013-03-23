<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp" %>
<%@ include file="check_session.jsp"%>

<%
      String task_id = (String) session.getAttribute( "theTask_ID" );
       String tname = (String) session.getAttribute("theTaskName");
%>  

<html>
  <head>
    <script src="helper_script.js"></script>
    <link href="style.css" rel="stylesheet" type="text/css">
    <title>File Uploading Form</title>
  </head>
  <body>
    <table align = center>
      <form id="upload_form" action="saveimage.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm_upload(this);">
	<tr><td colspan =2 align = center> Select files to upload 
	    <br /><br /></td></tr>
	<tr class="field">
	  <td> Dataset Name </td>
	   <td colspan='2'> <input type="text" name="set_name" value="" placeholder="Dataset Name"/></td>

</tr>
	<tr>
	  <td>Original Image </td>
	   <td>	<input type="hidden" name="mname" value= "Original Image"/>	</td>
	   <td>	<input type="file" name="original" /></td>
	</tr>
	<%
	   paramList.clear();
           paramList.add(task_id);
           //String query = "SELECT * FROM `method` WHERE `task_id` = " + task_id;
           rs = execQuery(120, paramList);
           int i=0;
	   String m_name;
           while(rs.next()) { 
	       i++;
	       m_name = rs.getString("name");
        %>
	 <tr>
	   <td> <% out.print(m_name); %> </td>
	   <td>	<input type="hidden" name="mname" value= <% out.print("'" + m_name + "'"); %>/>	</td>
	   <td>	<input type="file" name= <% out.print("file"+i); %> />	</td>
	 </tr>
	 
	 <% }
	    con.close();
	 %>
	 <tr><td><br /><br /> <input type="submit" value="Upload File"/> </td></tr>
    </form>
  </body>
</html>
