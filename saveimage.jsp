<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<% 
   Integer task_id = new Integer(1);
   task_id =  Integer.parseInt((String)session.getAttribute( "theTask_ID" ));
   String uname = (String) session.getAttribute("theUname");
   String tname = (String) session.getAttribute("theTask");
%>

<%      
Statement stmt;
Connection con;
String url = "jdbc:mysql://localhost:3306/proj1";

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
String query = "SELECT * from method WHERE task_id=" + task_id;
stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(query);
String mname;
%>

<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = "/var/lib/tomcat6/webapps/tournament/uploads/" +uname + "/" + tname + "/";
   //String filePath = context.getInitParameter("file-upload");

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
	 session.setAttribute("posMsg", "Congratulation. Task created successfully.");	 
	 response.sendRedirect("task.jsp");
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
