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

<div class="container" style="width: 100%">
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>
   <div style="width: 45%;float: left">
    <div class="panel panel-default"  style="width: 500px">
        <div class="panel-heading" align="left">
            <h3 class="panel-title">Trending Topics</h3>
        </div>
            <g:render template="/home/trending" model="[resources: trendingTopics,user:user]"/>
        </div>

    <div class="panel panel-default"  style="width: 550px">
        <div class="panel-heading" align="left">
            <h3 class="panel-title">Top Posts</h3>
        </div>
            <div style="max-height: 200px;overflow: hidden">
            <g:render template="/home/inbox" model="[resources: topPost]"/>
            </div>
    </div>
   </div>

    <div style="width:50%;float:right">
        <div class="panel panel-default" style="width: 600px"  >
            <div class="panel-heading" align="left">
                <h3 class="panel-title">Search for Topic:" ${searchFor} "</h3>
            </div>

        <g:render template="/home/inbox" model="[resources: resource]"/>
</div>
    </div>

</div>
</body>
</html>