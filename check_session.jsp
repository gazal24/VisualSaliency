<%
String s3 = (String)session.getAttribute("isValid");
if (s3 == null) {
    session.setAttribute("errMsg", "Please Login to continue.");
%>
    <jsp:forward page="index.jsp" />
<%
}
%>
