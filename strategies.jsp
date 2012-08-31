<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%!
      int game(int c) {
      return c*4;   
      }
      int[] challenging(int choice, int a, int b, int num_of_methods){
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

      int[] roundrobin(int choice, int a, int b, int num_of_methods) {
	  int c;
	  if(choice == 1) {
	      // do some result calculation
	  }
	  else if(choice == 2) {
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
	  return arr;
      }


%>