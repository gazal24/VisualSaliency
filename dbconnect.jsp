<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<jsp:declaration>
      
Statement stmt;
Connection con;
String url = "jdbc:mysql://localhost:3306/proj1";
ResultSet rs1;   
</jsp:declaration>

<%
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
stmt = con.createStatement();
%>

<%
    // Context object is used to get context-param from WEB-INF/web.xml.
    ServletContext context = pageContext.getServletContext();
%>

 <!-- Required for appconfig class -->
<%@ page import="webp_rmi.*" %> 

<!-- Required for Registry class -->
<%@ page import="java.rmi.registry.*" %> 

<!-- Required for xstream -->
<%@ page import="com.thoughtworks.xstream.XStream"%> 

<!-- Required for CachedRowSetImpl class -->
<%@ page import="com.sun.rowset.CachedRowSetImpl"%> 

<%
// RMI Layer
String params = "";
CachedRowSetImpl crs = null, rs = null;
ArrayList paramList = new ArrayList();
%>

<%!

public jdbcrmi getConnector() {
    appconfig pinfo=new appconfig();
    int thisPort=Integer.parseInt(pinfo.blport);
    String thisAddress=pinfo.netaddr;
    jdbcrmi jrObj=null;
    try {
	Registry registry=LocateRegistry.getRegistry(thisAddress, thisPort);
	jrObj=(jdbcrmi)(registry.lookup("jdbcrmi"));
    }
    catch (Exception e)	{
	System.out.println("Error in creating connection via rmi layer. Check <br></br>" + e.toString());
    }
    return jrObj;
  }

public CachedRowSetImpl execQuery(int qNum, ArrayList paramList) {
    XStream xstream = new XStream();
    CachedRowSetImpl rs = null;// = new CachedRowSetImpl();
    String xml=null;
    jdbcrmi jrObj = getConnector();
    try {
	xml=jrObj.ExecuteSql(qNum, paramList);
	rs = (CachedRowSetImpl)xstream.fromXML(xml);
    }

    catch (Exception e) {
	System.out.println("Error calling function ExecuteSql(). Check" + e.toString());
    }

    return rs;
}

public int execUpdate(int qNum, ArrayList paramList) {
    XStream xstream = new XStream();
    Integer query_status = new Integer(0);
    String xml=null;
    jdbcrmi jrObj = getConnector();
    try
	{
	    xml=jrObj.ExecuteSql(qNum, paramList);
	    query_status = (Integer)xstream.fromXML(xml);
	}
    catch (Exception e)
	{
	    System.out.println("Error in calling function ExecuteSql(). Check <br></br>" + e.toString());
	}
    return query_status;
}
%>
