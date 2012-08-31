<%@ include file="strategies.jsp" %>
<%
      
    int choice = Integer.parseInt(request.getParameter("choice"));

if(choice == 0) {
    session.setAttribute("left", 1);
    session.setAttribute("right", 2);

    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/proj1";

    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", "root"); 
    stmt = con.createStatement();

    int task_id = (Integer)session.getAttribute( "theTask_ID" );
    String uname = (String) session.getAttribute("theUname");
    ResultSet rs = stmt.executeQuery("Select * from task WHERE id=" + task_id);
    rs.next();
    String tname = rs.getString("name");
    session.setAttribute("theTaskName", tname);

    rs = stmt.executeQuery("SELECT * from method WHERE task_id=" + task_id );

    int i=0;

    rs.last();
    int size = rs.getRow();
    rs.beforeFirst();

    String method[] = new String[size];

    while(rs.next()) {
	method[i++] = rs.getString("name");
    }
    
    session.setAttribute("theMethodCount", i);    
    session.setAttribute("theMethodArray", method);
    String img_path1 = "uploads/" + uname + "/" + tname + "/" + method[0] + ".jpg";
    String img_path2 = "uploads/" + uname + "/" + tname + "/" + method[1] + ".jpg";

    out.print("{");
    out.print("\"left\": \"" + img_path1+ "\",");
    out.print("\"left_method\": \"" + method[0]+ "\",");
    out.print("\"right\": \"" + img_path2+ "\",");
    out.print("\"right_method\": \"" + method[1]+ "\"");
    out.print("}");
}

//out.println(initGame());
else {
    String uname = (String) session.getAttribute("theUname");
    String tname = (String) session.getAttribute("theTaskName");
    String[] method =(String[]) session.getAttribute("theMethodArray");

    int methodCount =  (Integer)session.getAttribute( "theMethodCount" );
    
    int a =  (Integer) session.getAttribute( "left" );
    int b = (Integer)session.getAttribute( "right" );
    int strategy = (Integer)session.getAttribute("theStrategy");
    
    int [] val = {};
    if(strategy == 0)
	val = knockout(choice, a,b, methodCount);
    if(strategy == 1)
	val = challenging(choice, a,b, methodCount);
    if(strategy == 2)
	val = roundrobin(choice, a,b, methodCount);
    
    if(val[0] == -1) {
	out.print("{");
	out.print("\"left\": \"" + "over" + "\",");
	out.print("\"right\": \"" + "over" + "\"");
	out.print("}");
    }
    else {
	session.setAttribute("left", val[0]);
	session.setAttribute("right", val[1]);

	String img_path1 = "uploads/" + uname + "/" + tname + "/" + method[val[0]-1] + ".jpg";
	String img_path2 = "uploads/" + uname + "/" + tname + "/" + method[val[1]-1] + ".jpg";

	out.print("{");
	out.print("\"left\": \"" + img_path1+ "\",");
	out.print("\"left_method\": \"" + method[val[0]-1]+ "\",");
	out.print("\"right\": \"" + img_path2+ "\",");
	out.print("\"right_method\": \"" + method[val[1]-1]+ "\"");
	out.print("}");
    }
}
%>
