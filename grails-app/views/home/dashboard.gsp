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

</head>

<body>
<div>
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;" align="right">${flash.message}</div>
    </g:if>
    <div style="width:  100%">
        <div style="width:40% ;float:left">

            <g:render template="info" model="[user: user]"/>

            <div class="panel panel-default" style="width: 500px">
                <div class="panel-heading" align="left">
                    <h3 class="panel-title">Subscriptions     <span style="float: right">
                        <g:link controller="topic" action="list" params="[uid: user.id, operation: 'subscriptions']">
                            View All</g:link>
                    </span>
                    </h3></div>
                <g:render template="trending" model="[user: user, trendingTopics: subscribedTopic]"/>
            </div>

            <div class="panel panel-default" style="width: 500px">
                <div class="panel-heading" align="left">
                    <h3 class="panel-title">Trending Topics
                    </h3></div>
                <g:render template="trending" model="[user: user, trendingTopics: trendingTopics]"/>
            </div>

        </div>

        <div style="width: 50%; float: right">
            <td>
                <div>
                    <div class="panel panel-default" style="width: 600px;overflow: hidden">
                        <div class="panel-heading" align="left">
                            <h3 class="panel-title">Inbox &nbsp;<span class="badge">${resources.size()}</span>
                                <input type="text" class="form-control" placeholder="Search"
                                       style="float: right;width: 100px"></h3>
                        </div>

                        <g:render template="inbox" model="[resources: resources]"/>
                    </div>
                </div>
        </div>
    </div>

</div>

</body>
</html>