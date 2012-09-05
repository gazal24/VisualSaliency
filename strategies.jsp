<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%!
      int game(int c) {
      return c*4;   
      }


      // int[] knockout(int choice, int a, int b, int num_of_methods,  int [][]adjGraph, int[] score){

      //    int [] arr = {0,1};
      //    return  arr;  
      // }

      Object[] knockout(int choice, int a, int b, int [][]adjGraph, int[] score,
		     int[] currentRound, int[] nextRound, int currentSize){

	  Object[] obj = new Object[10];
	  int x=currentRound[a-1];
	  int y=currentRound[b-1];
	  int i;
	  if(choice==1) { //left image
	      nextRound[a/2]=x;
	      adjGraph[x-1][y-1] ++;
	      score[x-1] = score[x-1] + score[y-1] + 1;
	  }
	  else if(choice==2) {
	      nextRound[a/2]=y;
	      adjGraph[y-1][x-1] ++;
	      score[y-1] = score[x-1] + score[y-1] + 1;
	  }

	  while(1==1) {
	      if(currentSize == 2) { // Came into Final Round
		  a=-1;
		  b=-1;
		  for(i=0; i<currentSize/2; i++)
		      currentRound[i] = nextRound[i];
		  currentSize = currentSize/2;
		  int arr[]= {a,b};
		  return new Object[]{arr, adjGraph, score, currentRound, nextRound, currentSize}; 
	      }
	      else if(a == currentSize-1) { //reached the end of currentRound
		  a=1;
		  b=2;
		  for(i=0; i<currentSize/2; i++)
		      currentRound[i] = nextRound[i];
		  currentSize = currentSize/2;
		  int arr[]= {a,b};
		  return new Object[]{arr, adjGraph, score, currentRound, nextRound, currentSize}; 
		  //copy nextRound in currentRound and initialize nextRound with zeros and return
	      }
	      else { // if not the end, take next two players and....
		  a+=2;
		  b+=2;
		  if(currentRound[b-1] == 0) { // ... if second player is zero then 'a' get BYES
		      nextRound[a/2]=currentRound[a-1];
		      continue;
		  } else {  // ... otherwise they will play a match.
		      int arr[]= {a,b};
		      return new Object[]{arr, adjGraph, score, currentRound, nextRound, currentSize}; 
		  }
	      }
	      
	  }
	  
      }
    



Object[] challenging(int choice, int a, int b, int num_of_methods, int [][]adjGraph, int[] score){
	  int c;
	  if(a>b) c = a;
	  else c = b;
	  ++c;
	  if(c > num_of_methods)
	      {
		  a = -1;
	      }
	  else {
	      if(choice == 1) //left image
		  {
		      adjGraph[a-1][b-1]++;
		      score[a-1] += score[b-1] + 1;
		      b = c;
		  }
	      else if (choice == 2) //right image
		  {
		      adjGraph[b-1][a-1]++;
		      score[b-1] += score[a-1] + 1;
		      a = c;
		  }
	  }
	  int [] arr = {a,b};
	  //	  return arr;  
	  return new Object[]{arr, adjGraph, score};
      }

Object[] roundrobin(int choice, int a, int b, int num_of_methods, int [][]adjGraph, int[] score) {
	  int c;
	  if(choice == 1) {
	      adjGraph[a-1][b-1]++;
	      score[a-1] += score[b-1] + 1;
	      // do some result calculation
	  }
	  else if(choice == 2) {
	      adjGraph[b-1][a-1]++;
	      score[b-1] += score[a-1] + 1;
	      // do some more result calculation
	  }

	  if(a < num_of_methods-1) {
	      if(b < num_of_methods)
		  b++;
	      else if(b == num_of_methods) {
		  a++;
		  b = a+1;
	      }
	  } 
	  else if (a==num_of_methods-1) {
	      a = -1;
	      b = -1;
	  }
	  int[] arr = {a,b};
	  return new Object[]{arr, adjGraph, score};
	  //	  return arr;
      }


%>