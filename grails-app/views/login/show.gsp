<%--
  Created by IntelliJ IDEA.
  User: ubuntu
  Date: 20/6/15
  Time: 9:51 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>asdadad</title>
</head>

<body>

<g:if test="${flash.message}">
    <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>

</g:if>
<g:render template="recentShare" model="[resources:resources]"/>

<gt:pic uid="3"></gt:pic>
</body>
</html>