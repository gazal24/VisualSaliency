<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<jsp:declaration>
      
Statement stmt;
Connection con;
String url = "jdbc:mysql://localhost:3306/proj1";
ResultSet rs,rs1;   
</jsp:declaration>

<%
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
stmt = con.createStatement();
%>


<%@ page import="webp_rmi.*" %>  // Required for appconfig class
<%@ page import="java.rmi.registry.*" %> // Required for Registry class
<%@ page import="com.thoughtworks.xstream.XStream"%> // Required for xstream
<%@ page import="com.sun.rowset.CachedRowSetImpl"%> // Required for CachedRowSetImpl class

<%
// RMI Layer
String params = "";
CachedRowSetImpl crs = null;
ArrayList paramList = new ArrayList();
%>

<%!
public CachedRowSetImpl execQuery(int qNum, ArrayList paramList) {

    String params = "";
    
    appconfig pinfo=new appconfig();
    int thisPort=Integer.parseInt(pinfo.blport);
    String thisAddress=pinfo.netaddr;
    XStream xstream = new XStream();
    CachedRowSetImpl crs = null;// = new CachedRowSetImpl();
    String xml=null;
    jdbcrmi jrObj=null;
    
    try
	{
	    Registry registry=LocateRegistry.getRegistry(thisAddress, thisPort);
	    jrObj=(jdbcrmi)(registry.lookup("jdbcrmi"));
	    xml=jrObj.ExecuteSql(qNum, paramList);
	    crs = (CachedRowSetImpl)xstream.fromXML(xml);// de-serialize from XML
	}
    catch (Exception e)
	{
	    System.out.println("Error in creating connection via rmi layer. Check <br></br>" + e.toString());
	}
    return crs;
}
%>