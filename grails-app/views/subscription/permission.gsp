<%--
  Created by IntelliJ IDEA.
  User: ubuntu
  Date: 28/6/15
  Time: 7:18 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dash_head">
    <title></title>
</head>

<body>
Are You Sure Want to Subscribe this Topic Name : ${topic.name} Topic ID:${topic.id}  created By :${topic.createdBy}
<g:form action="proceed">
<select name="seriousness">
    <option value="SERIOUS">Serious</option>
    <option value="VERYSERIOUS">Very Serious</option>
    <option value="CASUAL">Casual</option>
</select>
    <button type="submit" class="btn btn-default">Subscribe</button>
</g:form>
<g:link action="login" controller="index"> Cancel</g:link>

</body>
</html>