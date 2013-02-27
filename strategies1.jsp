<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%!
      int game(int c) {
      return c*4;   
      }

    
Object[] knockout(int choice, int left, int right, int currSet, int[] setStatus, int setCount, Node[][] sheet, int methodCount, int[] score){

    //  choice = 1 : Left
    // 	       = 2 : Right

    //UPDATE SHEET, setStatus, score ACCORDING TO RECEIVED CHOICE.
    int flag, i;
    sheet[currSet][right].matches++;
    sheet[currSet][left].matches++;
    
    if(choice == 1) {// Left 
	sheet[currSet][left].win = 1;
	sheet[currSet][left].loss = 0;
	sheet[currSet][right].win = 0;
	sheet[currSet][right].loss = 1;
    }

    else if(choice == 2) { // Right
	sheet[currSet][left].win = 0;
	sheet[currSet][left].loss = 1;
	sheet[currSet][right].win = 1;
	sheet[currSet][right].loss = 0;
    }
    
    while(true) {
	int lossPlayers=0;
	for(i=0; i<methodCount; i++)
	    if(sheet[currSet][i].loss == 1) {
		lossPlayers++; // Count all lossPlayers
	    }

	if(lossPlayers == methodCount-1) // Set is Completed.
	    setStatus[currSet] = 1;

	// CHECK IF ANY SET IS ALIVE

	flag = 1; // Assume all Set are over now.
	for(i=0; i<setCount; i++)
	    if(setStatus[i] == 0) { // If a set is found that is still alive, then turn down flag and continue to play.
		flag=0;
		break;
	    }
    
	if(flag == 1) {
	    int []arr = {-1, right, currSet};
	    return new Object[]{arr, sheet, setStatus};
	}

	//   IF YES, RANDOMLY CHOOSE A SET.

	do{
	    currSet = ((int)(Math.random()*2377)) % setCount;
	}while(setStatus[currSet]==1 && (currSet < setCount));


	// PICK TWO PLAYER BY THE LOGIC. 
	// Find min Matches of player with Loss = 0 and pick players with that M & L=0

	int minMatches = methodCount;
	int minPlayerCounter = 0;
	for(i=0; i<methodCount; i++)
	    if(sheet[currSet][i].loss == 0)
		if (sheet[currSet][i].matches < minMatches) {
		    minMatches =  sheet[currSet][i].matches;
		    minPlayerCounter = 1;
		}
		else if(sheet[currSet][i].matches == minMatches)
		    minPlayerCounter++;
    
	if(minPlayerCounter == 1) {
	    for(i=0; i<methodCount; i++)
		if(sheet[currSet][i].matches == minMatches) {
		    sheet[currSet][i].matches++;
		    sheet[currSet][i].win = 1;
		    sheet[currSet][i].loss = 0;
		}
	    continue;
	}
	    

	do{
	    left = (int)(Math.random()*2377) % methodCount;
	}while((sheet[currSet][left].loss!=0) || (sheet[currSet][left].matches!=minMatches)); // No need to check Player.win because winner will always have matches =non_zero.
    
    
	// PICK SOME RANDOM PLAYER WITH MATCHES =minMatches AND loss =0
	do{
	    right = (int)(Math.random()*2377) % methodCount;
	}while((sheet[currSet][right].loss!=0) || (sheet[currSet][right].matches!=minMatches) || (left==right)); // No need to check Player.win because winner will always have matches =non_zero.
    
    
	int []arr = {left, right, currSet};
	return new Object[]{arr, sheet, setStatus};
    }    
}


Object[] challenging(int choice, int left, int right, int currSet, int[] setStatus, int setCount, Node[][] sheet, int methodCount, int[] score){

    //  choice = 1 : Left
    // 	       = 2 : Right

    //UPDATE SHEET, setStatus, score ACCORDING TO RECEIVED CHOICE.

    int flag, i;
    
    sheet[currSet][right].matches = 1;
    sheet[currSet][left].matches = 1;
    
    if(choice == 1) {// Left 
	sheet[currSet][left].win = 1;
	sheet[currSet][right].win = 0;
    }
    else if(choice == 2) { // Right
	sheet[currSet][left].win = 0;
	sheet[currSet][right].win = 1;
    }
    
    flag = 1; // Assume all methods have played one match.
    for(i=0; i<methodCount; i++)
	if(sheet[currSet][i].matches == 0) { // If any method is found which has not played any match then turn down flag.
	    flag=0;
	    break;
	}

    if(flag == 1) // If flag still up then change the status of that Set as 1 i.e. all matches done.
	setStatus[currSet] = 1;



    // CHECK IF ANY SET IS ALIVE

    flag = 1; // Assume all Set are over now.
    for(i=0; i<setCount; i++)
	if(setStatus[i] == 0) { // If a set is found that is still alive, then turn down flag and continue to play.
	    flag=0;
	    break;
	}
    
    if(flag == 1) {
	int []arr = {-1, right, currSet};
	return new Object[]{arr, sheet, setStatus};
    }

    //   IF YES, RANDOMLY CHOOSE A SET.;

    do{
	currSet = ((int)(Math.random()*2377)) % setCount;
    }while(setStatus[currSet]==1 && (currSet < setCount));


    // PICK TWO PLAYER BY THE LOGIC. FYI ONE WILL BE SELECTED RANDOMLY HERE.
    
    // PICK THE WINNER
    int flag_winner_exits = 0;
    for(i=0; i<methodCount; i++)
	if(sheet[currSet][i].win == 1) { // The winner of currSet found
	    left = i;            // Just see if you want to keep winner on left always.
	    flag_winner_exits = 1;
	    break;
	}
    
    // IF A SET IS PICKED FOR THE FIRST TIME THEN OBVIOUSLY THERE WILL BE NO WINNER
    if(flag_winner_exits ==0) 
	do{
	    left = (int)(Math.random()*2377) % methodCount;
	}while(sheet[currSet][left].matches == 1); // No need to check Player.win because winner will always have matches =non_zero.
    
    
    // PICK SOME RANDOM PLAYER WITH MATCHES =0 AND WIN =0
    do{
	right = (int)(Math.random()*2377) % methodCount;
    }while((sheet[currSet][right].matches==1) || (left==right) ); // No need to check Player.win because winner will always have matches =non_zero.


    int []arr = {left, right, currSet};
    return new Object[]{arr, sheet, setStatus};
}

Object[] roundrobin(int choice, int left, int right, int currSet, int[] setStatus, int setCount, Node[][] sheet, int methodCount, int[] score){

    //  choice = 1 : Left
    // 	       = 2 : Right

    //UPDATE SHEET, setStatus, score ACCORDING TO RECEIVED CHOICE.

    int flag, i;
    
    sheet[currSet][right].matches++;
    sheet[currSet][left].matches++;
    
    // if(choice == 1) {// Left 
    // 	sheet[currSet][left].win = 1;
    // 	sheet[currSet][right].win = 0;
    // }
    // else if(choice == 2) { // Right
    // 	sheet[currSet][left].win = 0;
    // 	sheet[currSet][right].win = 1;
    // }
    
    flag = 1; // Assume all methods have played methodCount-1 match.
    for(i=0; i<methodCount; i++)
	if(sheet[currSet][i].matches < (methodCount-1)) { // If any method is found which has not played any match then turn down flag.
	    flag=0;
	    break;
	}

    if(flag == 1) // If flag still up then change the status of that Set as 1 i.e. all matches done.
	setStatus[currSet] = 1;


    // CHECK IF ANY SET IS ALIVE

    flag = 1; // Assume all Set are over now.
    for(i=0; i<setCount; i++)
	if(setStatus[i] == 0) { // If a set is found that is still alive, then turn down flag and continue to play.
	    flag=0;
	    break;
	}
    
    if(flag == 1) {
	int []arr = {-1, right, currSet};
	return new Object[]{arr, sheet, setStatus};
    }

    //   IF YES, RANDOMLY CHOOSE A SET.;

    do{
	currSet = ((int)(Math.random()*2377)) % setCount;
    }while(setStatus[currSet]==1 && (currSet < setCount));
    
    
    // PICK TWO PLAYER BY THE LOGIC. Pick two player that have match count less than methodCount-1
    
    // // PICK THE WINNER
    // int flag_winner_exits = 0;
    // for(i=0; i<methodCount; i++)
    // 	if(sheet[currSet][i].win == 1) { // The winner of currSet found
    // 	    left = i;            // Just see if you want to keep winner on left always.
    // 	    flag_winner_exits = 1;
    // 	    break;
    // 	}
    
    // PICK ONE PLAYER
    do{
	left = (int)(Math.random()*2377) % methodCount;
    }while(sheet[currSet][left].matches == (methodCount-1)); // No need to check Player.win because winner will always have matches =non_zero.
    
    
    // PICK SECOND PLAYER
    do{
	right = (int)(Math.random()*2377) % methodCount;
    }while((sheet[currSet][right].matches == (methodCount-1)) || (left==right) ); // No need to check Player.win because winner will always have matches =non_zero.


    int []arr = {left, right, currSet};
    return new Object[]{arr, sheet, setStatus};


    // int c;
    // if(choice == 1) {
    // 	      adjGraph[a-1][b-1]++;
    // 	      score[a-1] += score[b-1] + 1;
    // 	      // do some result calculation
    // 	  }
    // 	  else if(choice == 2) {
    // 	      adjGraph[b-1][a-1]++;
    // 	      score[b-1] += score[a-1] + 1;
    // 	      // do some more result calculation
    // 	  }

    // 	  if(a < num_of_methods-1) {
    // 	      if(b < num_of_methods)
    // 		  b++;
    // 	      else if(b == num_of_methods) {
    // 		  a++;
    // 		  b = a+1;
    // 	      }
    // 	  } 
    // 	  else if (a==num_of_methods-1) {
    // 	      a = -1;
    // 	      b = -1;
    // 	  }
    // 	  int[] arr = {a,b};
    // 	  return new Object[]{arr, adjGraph, score};
    // 	  //	  return arr;
    //   }
    
}
%>