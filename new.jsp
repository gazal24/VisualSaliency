<html>
  <body>
    <%
       // This is a scriptlet.  Notice that the "date"
       // variable we declare here is available in the
       // embedded expression later on.
       out.println( "Evaluating date now" );
       out.println(request.getRemoteHost());
       java.util.Date date = new java.util.Date();
       int i = 1;
       %>
    Hello!  The time is now <%= date %>
    hello!  the time is now <%= new java.util.Date() %>

    <%
       out.println("<h1> cow </h1>");
       %>
    <%= i+3 %>

  </body>
</html>
