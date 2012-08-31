<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%!
      int game(int c) {
      return c*4;   
      }
      int[] challenging(int choice, int a, int b, String [] method){
	  int c;
	  if(a>b) c = a;
	  else c = b;
	  if(choice == 1) //left image
	      {
		  int [] arr = {a,++c};
		  return arr;
	      }
	  else if (choice == 2) //right image
	      {
		  int [] arr = {++c,b};
		  return arr;
	      }
	  int [] arr1 = {0,1};
	  return arr1;
      }
%>