<%
session.setAttribute("isValid", "logout");
session.setAttribute("posMsg", "You have successfully logged out of system. Thank you for using the system.");
response.sendRedirect("index.jsp");
%>