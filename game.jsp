<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp"%>
<%@ include file="strategies.jsp" %>
<%
      
    int choice = Integer.parseInt(request.getParameter("choice"));

if(choice == 0) {
    session.setAttribute("left", 1);
    session.setAttribute("right", 2);

    int task_id = (Integer)session.getAttribute( "theTask_ID" );
    String uname = (String) session.getAttribute("theUname");
    rs = stmt.executeQuery("Select * from task WHERE id=" + task_id);
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
    
    int[][] adjGraph = new int[i][i];
    int [] score = new int[i];
    int methodCount =  i;

    session.setAttribute("theMethodCount", methodCount);    
    session.setAttribute("theMethodArray", method);
    session.setAttribute("theAdjGraph", adjGraph);
    session.setAttribute("theScore", score);

    int strategy = (Integer)session.getAttribute("theStrategy");
    //  Special initializations for Knockout
    int currentSize = (int) Math.round(Math.pow(2, Math.ceil(Math.log(methodCount)/Math.log(2))));
    int[] currentRound = new int[currentSize];
    int[] nextRound = new int[currentSize/2];
    
    if(strategy == 0) {

	int player = 0;
	for(i=0; i<currentSize-1; i+=2) // To fill ODD places.
	    currentRound[i] = ++player;
	for(i=1; i<currentSize; i+=2) { // To fill EVEN places.
	    if(player == methodCount || player == 0) 
		player = 0;
	    else ++player;
	    currentRound[i] = player;
	}
	session.setAttribute("theCurrentRound", currentRound);
	session.setAttribute("theNextRound", nextRound);
	session.setAttribute("theCurrentSize", currentSize);
    }


    if(strategy == 0) {
	    
    String img_path1 = "uploads/" + uname + "/" + tname + "/" + method[currentRound[0]-1] + ".jpg";
    String img_path2 = "uploads/" + uname + "/" + tname + "/" + method[currentRound[1]-1] + ".jpg";

    out.print("{");
    out.print("\"left\": \"" + img_path1+ "\",");
    out.print("\"left_method\": \"" + method[currentRound[0]-1]+ "\",");
    out.print("\"right\": \"" + img_path2+ "\",");
    out.print("\"right_method\": \"" + method[currentRound[1]-1]+ "\"");
    out.print("}");

    }

    else {
    String img_path1 = "uploads/" + uname + "/" + tname + "/" + method[0] + ".jpg";
    String img_path2 = "uploads/" + uname + "/" + tname + "/" + method[1] + ".jpg";

    out.print("{");
    out.print("\"left\": \"" + img_path1+ "\",");
    out.print("\"left_method\": \"" + method[0]+ "\",");
    out.print("\"right\": \"" + img_path2+ "\",");
    out.print("\"right_method\": \"" + method[1]+ "\"");
    out.print("}");
    }
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
    int [][]adjGraph = (int[][])session.getAttribute("theAdjGraph");
    int []score = (int[])session.getAttribute("theScore");
    
    int [] val = {};
    Object[] obj = new Object[10];
    int []currentRound = new int[10];
    if(strategy == 0) {
	currentRound = (int[])session.getAttribute("theCurrentRound");    
	int []nextRound = (int[])session.getAttribute("theNextRound");    
	int currentSize = (Integer)session.getAttribute("theCurrentSize");

	obj = knockout(choice, a,b, adjGraph, score, currentRound, nextRound, currentSize);
	currentRound = (int [])obj[3];
	nextRound = (int [])obj[4];
	currentSize = (Integer)obj[5];

	session.setAttribute("theCurrentRound", currentRound);
	session.setAttribute("theNextRound", nextRound);
	session.setAttribute("theCurrentSize", currentSize);
    }

    if(strategy == 1)
	obj = challenging(choice, a,b, methodCount, adjGraph, score);
    if(strategy == 2)
	obj = roundrobin(choice, a,b, methodCount, adjGraph, score);
    
    val = (int [])obj[0];
    
    if(val[0] == -1) {
	out.print("{");
	out.print("\"left\": \"" + "gameOver" + "\",");
	out.print("\"right\": \"" + "gameOver" + "\"");
	out.print("}");
	
    }

    else {
	adjGraph = (int [][])obj[1];
	score = (int [])obj[2];
	session.setAttribute("theAdjGraph", adjGraph);
	session.setAttribute("theScore", score);

	session.setAttribute("left", val[0]);
	session.setAttribute("right", val[1]);

	if(strategy == 0) {
	    String img_path1 = "uploads/" + uname + "/" + tname + "/" + method[currentRound[val[0]-1]-1] + ".jpg";
	    String img_path2 = "uploads/" + uname + "/" + tname + "/" + method[currentRound[val[1]-1]-1] + ".jpg";
	    
	    out.print("{");
	    out.print("\"left\": \"" + img_path1+ "\",");
	    out.print("\"left_method\": \"" + method[currentRound[val[0]-1]-1]+ "\",");
	    out.print("\"right\": \"" + img_path2+ "\",");
	    out.print("\"right_method\": \"" + method[currentRound[val[1]-1]-1]+ "\"");
	    out.print("}");
	}

	else {

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
}
%>
