<%@ include file="strategies.jsp" %>
<%

int choice = Integer.parseInt(request.getParameter("choice"));

if(choice == 0) {
    session.setAttribute("left", "1");
    session.setAttribute("right", "2");

    Statement stmt;
    Connection con;
    String url = "jdbc:mysql://localhost:3306/proj1";
    
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(url, "root", "root"); 
    stmt = con.createStatement();
    
    Integer task_id = new Integer(1);
    task_id = Integer.parseInt((String)session.getAttribute( "theTask_ID" ));
    String uname = (String) session.getAttribute("theUname");
    ResultSet rs = stmt.executeQuery("Select * from task WHERE id=" + task_id);
    rs.next();
    String tname = rs.getString("name");
    session.setAttribute("theTaskName", tname);

    rs = stmt.executeQuery("SELECT * from method WHERE task_id=" + task_id );

    int i=0;
    String method[] = new String[10]; // Change this limit;
    while(rs.next()) {
	method[i++] = rs.getString("name");
    }
    session.setAttribute("theMethodArray", method);

    out.println(method[0]);    
    out.println(method[1]);    
}

//out.println(initGame());
else {
    String uname = (String) session.getAttribute("theUname");
    String tname = (String) session.getAttribute("theTaskName");
    String[] method =(String[]) session.getAttribute("theMethodArray");
    Integer a = new Integer(1);
    a =  Integer.parseInt((String)session.getAttribute( "left" ));
    Integer b = new Integer(1);
    b =  Integer.parseInt((String)session.getAttribute( "right" ));
    int [] val = challenging(choice, a,b, method);
    
    session.setAttribute("left", String.valueOf(val[0]));
    session.setAttribute("right", String.valueOf(val[1]));

    //    out.println(val[0] +" and " + val[1]);
    String img_path1 = "uploads/" + uname + "/" + tname + "/" + method[val[0]-1] + ".jpg";
    String img_path2 = "uploads/" + uname + "/" + tname + "/" + method[val[1]-1] + ".jpg";
    out.println(img_path1 + "," + img_path2);
}
%>
