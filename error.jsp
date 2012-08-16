<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>

<html>
<head>
<title>Error page</title>
<style>
    * { font-size: 12px; font-family: Verdana }
</style>
</head>
<body>
<h2>Error occured!</h2>
<p>Message <jsp:expression> exception.getMessage() </jsp:expression>

</body>
</html>
