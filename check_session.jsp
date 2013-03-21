<%
String isValid = (String)session.getAttribute("isValid");
if (isValid == null) {
    session.setAttribute("errMsg", "Please Login to continue.");
%>
    <jsp:forward page="login.jsp" />
<%
}
%>
