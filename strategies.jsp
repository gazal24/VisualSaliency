<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%!
      int game(int c) {
      return c*4;   
      }
      
      int[] knockout(int choice, int a, int b, int num_of_methods,  int [][]adjGraph, int[] score){
	  int [] arr = {0,1};
	  return  arr;  
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