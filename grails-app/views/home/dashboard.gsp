<%--
  Created by IntelliJ IDEA.
  User: ubuntu
  Date: 21/6/15
  Time: 2:03 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dash_head">
    <title>LinkSharing</title>

    %{--<!-- Latest compiled and minified CSS -->--}%
    %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">--}%

    %{--<!-- Optional theme -->--}%
    %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">--}%

    %{--<!-- Latest compiled and minified JavaScript -->--}%
    %{--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>--}%

</head>

<body>
<div style="border:solid thick " >
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>

<table align="center">
    <tr>
        <td>
<g:render template="info" model="[user:user,topic_total:topic_total,subscription_total:subscription_total]"/>
        </td>
        <td>
        <div>
            <g:render template="inbox" model="[r:r]"/>
        </div>
        </td>
    </tr>
</table>

This is simple text
    <br/>
    </div>

</body>
</html>