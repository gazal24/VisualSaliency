<%@ page import="java.lang.*" %>
<%@ include file="dbconnect.jsp"%>
<%@ include file="strategies1.jsp" %>
<%@ page import="Stra.Node" %>

<% 
      int choice = Integer.parseInt(request.getParameter("choice"));

if(choice == 0) {

    int task_id = (Integer)session.getAttribute( "theTask_ID" );
    String uname = (String) session.getAttribute("theUname");
    rs = stmt.executeQuery("Select * from task WHERE id=" + task_id);
    rs.next();
    String tname = rs.getString("name");
    session.setAttribute("theTaskName", tname);

    /// METHOD ///
    rs = stmt.executeQuery("SELECT * from `method` WHERE task_id=" + task_id );

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
    int methodCount = i;
    ///



    /// SET ///
    rs = stmt.executeQuery("SELECT * from `set` WHERE task_id=" + task_id );
    i = 0;
    rs.last();
    size = rs.getRow();
    rs.beforeFirst();

    String set[] = new String[size];
    
    while(rs.next()) {
	set[i++] = rs.getString("name");
    }
    
    int setCount = i;
    ///

    session.setAttribute("theMethodCount", methodCount);    
    session.setAttribute("theMethodArray", method);
    session.setAttribute("theSetCount", setCount);    
    session.setAttribute("theSetArray", set);
    session.setAttribute("theAdjGraph", adjGraph);
    session.setAttribute("theScore", score);

    int strategy = (Integer)session.getAttribute("theStrategy");



    //    Node[][] sheet = new Node[setCount][methodCount];
    Node[][] sheet = new Node[100][100];
    
    int x,y;
    for(x=0; x<= setCount; x++)
	for(y=0; y<= methodCount; y++)
	    sheet[x][y] = new Node(0,0,0);
    
    int[] setStatus = new int[setCount];

    session.setAttribute("theSheet", sheet);
    session.setAttribute("theSetStatus", setStatus);
    


    int currSet = (int)(Math.random()*2377) % setCount; 
    // 2377 is multiplied to a float number. Note: Avoid multiplying by simple number like 100, 1000
    session.setAttribute("theCurrentSet", currSet);
    
    int left = (int)(Math.random()*2377) % methodCount; 
    int right;
    do {
	right = (int)(Math.random()*2377) % methodCount; 
    }while(left == right);

    session.setAttribute("left", left);
    session.setAttribute("right", right);


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
    String img_path1 = "uploads/" + uname + "/" + tname + "/" + set[currSet] + "/" + method[left] + ".jpg";
    String img_path2 = "uploads/" + uname + "/" + tname + "/" + set[currSet] + "/" + method[right] + ".jpg";

    out.print("{");
    out.print("\"left\": \"" + img_path1+ "\",");
    out.print("\"left_method\": \"" + method[left]+ "\",");
    out.print("\"right\": \"" + img_path2+ "\",");
    out.print("\"right_method\": \"" + method[right]+ "\"");
    out.print("}");
    }
}

//out.println(initGame());
else {
    String uname = (String) session.getAttribute("theUname");
    String tname = (String) session.getAttribute("theTaskName");

    String[] method =(String[]) session.getAttribute("theMethodArray");
    int methodCount =  (Integer)session.getAttribute( "theMethodCount" );

    String[] set =(String[]) session.getAttribute("theSetArray");
    int setCount =  (Integer)session.getAttribute( "theSetCount" );

    Node[][] sheet = (Node[][])session.getAttribute("theSheet");
    int[] setStatus = (int[])session.getAttribute("theSetStatus");

    int a =  (Integer) session.getAttribute( "left" );
    int b = (Integer)session.getAttribute( "right" );
    int currSet = (Integer)session.getAttribute( "theCurrentSet" );

    int strategy = (Integer)session.getAttribute("theStrategy");
    int [][]adjGraph = (int[][])session.getAttribute("theAdjGraph");
    int []score = (int[])session.getAttribute("theScore");
    
    int [] val = {};
    Object[] obj = new Object[10];
    
    // Only for KnockOut ///////////
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
    // END knockOUt ////////////

    if(choice==1) adjGraph[a][b]++;
    else if(choice==2) adjGraph[b][a]++;

    if(strategy == 1)
	obj = challenging(choice, a, b, currSet, setStatus, setCount, sheet, methodCount, score);
    if(strategy == 2)
	obj = roundrobin(choice, a, b, currSet, setStatus, setCount, sheet, methodCount, score);
    
    val = (int [])obj[0];
    
    if(val[0] == -1) {
	out.print("{");
	out.print("\"left\": \"" + "gameOver" + "\",");
	out.print("\"right\": \"" + "gameOver" + "\"");
	out.print("}");
	
    }

    else {
	//	adjGraph = (int [][])obj[1];
	//score = (int [])obj[1];
	sheet = (Node[][])obj[1];
	setStatus = (int[])obj[2];

	session.setAttribute("theAdjGraph", adjGraph);
	session.setAttribute("theScore", score);

	session.setAttribute("theSheet", sheet);
	session.setAttribute("theSetStatus", setStatus);
	session.setAttribute("left", val[0]);
	session.setAttribute("right", val[1]);
	session.setAttribute("theCurrentSet", val[2]);
	
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
	    String img_path1 = "uploads/" + uname + "/" + tname + "/" + set[val[2]] + "/" + method[val[0]] + ".jpg";
	    String img_path2 = "uploads/" + uname + "/" + tname + "/" + set[val[2]] + "/" + method[val[1]] + ".jpg";
	    
	    out.print("{");
	    out.print("\"left\": \"" + img_path1+ "\",");
	    out.print("\"left_method\": \"" + method[val[0]]+ "\",");
	    out.print("\"right\": \"" + img_path2+ "\",");
	    out.print("\"right_method\": \"" + method[val[1]]+ "\"");
	    out.print("}");
	}
    }
}
%>
