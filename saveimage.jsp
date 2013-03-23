<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ include file="dbconnect.jsp"%>

<% 
   String task_id = (String) session.getAttribute( "theTask_ID" );
   String uname = (String) session.getAttribute("theUname");
   String tname = (String) session.getAttribute("theTaskName");
//   String sname = (String) request.getParameter("set_name");
   String sname = "default";
   out.println(sname);
%>

<%      
String query;
paramList.clear();
paramList.add(task_id);
paramList.add(sname);
int resultq = execUpdate(130, paramList);
// String query = "INSERT INTO `set` (`task_id`, `name`) VALUES ('"+ task_id+"','"+ sname+"')";

paramList.clear();
paramList.add(task_id);
// query = "SELECT max(`id`) as set_id FROM `set` WHERE task_id='" + task_id + "'";
rs = execQuery(131, paramList);
rs.next();
String set_id = rs.getString("set_id");

paramList.clear();
paramList.add(set_id);
paramList.add(set_id);
//query = "UPDATE `set` SET `name` = '"+ set_id +"' WHERE  `set`.`id` ="+set_id+"";
execUpdate(132, paramList);

paramList.clear();
paramList.add(task_id);
//query = "SELECT * from method WHERE task_id=" + task_id;
rs = execQuery(133, paramList);

String mname;
%>

<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   //String filePath = "/var/lib/tomcat6/webapps/tournament/uploads/" + uname + "/" + tname + "/" + set_id + "/";
   String filePath = context.getInitParameter("file-upload");
   filePath =  filePath + uname + "/" + tname + "/" + set_id + "/";

   File dir = new File(filePath);
   dir.mkdir();

   // Verify the content type
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("data/"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      try{ 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);
         // Process the uploaded file items
         Iterator i = fileItems.iterator();

	 int method_flag = 0;
	 mname = "original";
         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )	
            {
            // Get the uploaded file parameters

            String fieldName = fi.getFieldName();
            String fileName = fi.getName();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // Write the file

            out.println( fileName.lastIndexOf("/"));
	    if(method_flag == 1) {
		rs.next();
		mname = rs.getString("name");
	    }
	    method_flag = 1;
	    
            // if( fileName.lastIndexOf("/") >= 0 ){

            // file = new File( filePath + fileName.substring( fileName.lastIndexOf("/"))) ;
            // }else{
            // file = new File( filePath + fileName.substring(fileName.lastIndexOf("/")+1)) ;
            // out.println(file.exists());
            // }
	    file = new File( filePath + mname + ".jpg");
	    
            fi.write( file ) ;
            out.println("Uploaded Filename: " + filePath + fileName + "<br>");
            out.println("Filename: "  + fileName + "<br>");
            }
         }
         out.println("</body>");
         out.println("</html>");
	 session.setAttribute("posMsg", "Congratulation. Image set uploaded successfully.");	 
	 response.sendRedirect("method.jsp?taskid="+task_id);
      }catch(Exception ex) {
         out.println(ex);
      }

   } else {
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>
