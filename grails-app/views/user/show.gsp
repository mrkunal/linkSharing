<%--
  Created by IntelliJ IDEA.
  User: ubuntu
  Date: 14/6/15
  Time: 7:56 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Main Page</title>
    <meta name="layout" content="dash_head">

</head>
<body>

<div class="container" style="width: 100%;margin-top:4%">
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>
    <div style="width: 45%;float: left">

            <g:render template="/home/info" model="[user: showUser]"/>

    </div>


    <div style="width:50%;float:right">
        <div class="panel panel-default" style="width: 600px"  >
            <div class="panel-heading" align="left">
                <h3 class="panel-title">Posts
                        <input type="text" value="${params['search']}" style="float: right">

                     </h3>
            </div>

            <g:render template="/home/inbox" model="[resources: posts]"/>
        </div>
    </div>


</div>
</body>
</html>