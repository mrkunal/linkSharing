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

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>

<body>
<table>
    <tr>
        <td>
 <div class="container" style="width: 650px" >
                <gt:pic uid="${user.id}"></gt:pic>
                <h2> ${user.firstName} ${user.lastName} </h2>
                <h4> ${user.userName}</h4>


 </div>
        </td>
        <td>
        <div>
            <g:render template="inbox" model="[r:r]"/>
        </div>
        </td>
    </tr>
</table>

This is simple text


</body>
</html>