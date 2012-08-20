<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>

<%		
   String[] name = request.getParameterValues( "m_name" );
   Integer method_count = new Integer(1);
   method_count = Integer.parseInt(request.getParameter( "m_count" ));

   String uname = (String) session.getAttribute("theUname");
   Integer task_id = new Integer(1);
   task_id =  Integer.parseInt((String)session.getAttribute( "theTask_ID" ));
%>

<% 
   out.println("Hello " + name[0]);
   out.println("count " + method_count);
   out.println("task_id " + task_id);
%>

  <jsp:declaration>
      
    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/proj1";
    
  </jsp:declaration>

       
  <jsp:scriptlet><![CDATA[

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
int i =0;
int resultq = 0;
int flag = 0;
for(i=0; i<method_count; i++)
    {
	String query =  "INSERT INTO `method` (`task_id`, `name`) VALUES ('" + task_id + "', '" + name[i] + "')" ;
	stmt = con.createStatement();
	resultq = stmt.executeUpdate(query);
	if(resultq == 0)
	    flag = 1;
    }
ResultSet rs = stmt.executeQuery("SELECT * from method");
while(rs.next())
{
String out1 = rs.getString("name");
String out2 = rs.getString("task_id");
out.println(out1);
out.println(out2);
}
con.close();

]]></jsp:scriptlet>

<%
	 //    out.println(resultq);
    if(flag == 0)
    response.sendRedirect("upload.jsp");
    else 
    response.sendRedirect("taskmethods.jsp");
%>