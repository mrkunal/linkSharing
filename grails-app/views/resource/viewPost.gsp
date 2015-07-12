<%--
  Created by IntelliJ IDEA.
  User: ubuntu
  Date: 30/6/15
  Time: 1:27 PM
--%>

<%@ page import="linksharing.*" contentType="text/html;charset=UTF-8" %>
<head>
    <title>Main Page</title>
    <meta name="layout" content="dash_head">
    <script type="text/javascript">
        var rate = function (val) {

            var k = val
            for (i = 1; i <= k; i++) {
                document.getElementById(i).src = "${resource(dir: 'images', file: 'star-1.png')}"
            }
            for (j = ++k; j <= 5; j++) {
                document.getElementById(j).src = "${resource(dir: 'images', file: 'star-0.png')}"
            }
            <g:remoteFunction controller="resource" action="rate" update="temp" onSuccess="update()"
         params='{rate:val,resource:${resource.id}}'/>


        }
        var update = function () {
            var text = $('#temp').text()
            var idx = text.indexOf(',')
            var rate = text.substring(1, idx)
            var users = text.substring(idx + 1, text.length - 1)

            document.getElementById("rating").innerHTML = rate;
            document.getElementById("usersRate").innerHTML = users;


        }

        $(document).ready(function () {
            var k =
            ${userRating}

            for (i = 1; i <= k; i++) {
                document.getElementById(i).src = "${resource(dir: 'images', file: 'star-1.png')}"
            }
            for (j = ++k; j <= 5; j++) {
                document.getElementById(j).src = "${resource(dir: 'images', file: 'star-0.png')}"
            }


        })

    </script>
</head>

<body>
<div class="container" style="border:thin; width: 100%">
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;" align="right">${flash.message}</div>
    </g:if>

    <div class="panel panel-default" style="width:40%;float: left">
        <div class="panel-body">
            <div style="width: 30%;float: left">
                <ApplicationTag:pic uid="${resource.createdBy.id}"/>
            </div>

            <div style="width: 60%;float: left">
                <b>${resource.createdBy.firstName} ${resource.createdBy.lastName}</b>
                <g:link controller="topic" action="show" params="[topicId: resource.topic.id]"
                        style="float: right">${resource.topic.name}</g:link>

                <br/> @${resource.createdBy.userName}

                <p style="float:right"><ApplicationTag:exactTime time="${resource.lastUpdated}"/>
                </p><br/>

                <p style="float: right;">
                    <img id="1" src="${resource(dir: 'images', file: 'star-0.png')}" onclick="rate(id)"/>
                    <img id="2" src="${resource(dir: 'images', file: 'star-0.png')}" onclick="rate(id)"/>
                    <img id="3" src="${resource(dir: 'images', file: 'star-0.png')}" onclick="rate(id)"/>
                    <img id="4" src="${resource(dir: 'images', file: 'star-0.png')}" onclick="rate(id)"/>
                    <img id="5" src="${resource(dir: 'images', file: 'star-0.png')}" onclick="rate(id)"/>
                </p>

            </div>
            <br/><br/>

            <p style="float: right;margin-right: 40px"><span id="rating">${ratings}</span> Ratings (
                <span id="usersRate">${usersRate}</span> users)</p>

            <p style="float: left ">
                <br/><br/>${resource.description}
            </p>
            <br/>

            <p style="float: right">
                <% if (access) { %>
                <g:link controller="resource" action="delete" params="[resource: resource.id]">Delete</g:link>&ensp;

                <% }



                if (resource.instanceOf(LinkResource)) { %>
                <g:link controller="linkResource" action="create" params="[resourceId: resource.id]">Edit</g:link>&ensp;
                <a href="${resource.url}" target="_blank">View Full Site</a>&ensp;
                <% } else { %>
                <g:link controller="documentResource" action="create" params="[resourceId: resource.id]">Edit</g:link>&ensp;

                <g:link controller="documentResource" action="document_download"
                        params="[id: resource.id]">Download</g:link>&ensp;
                <% } %>
            </p>

        </div>
    </div>

    <div style="width: 50%;float: right">

        <div class="panel panel-default" style="width: 500px">
            <div class="panel-heading" align="left">
                <h3 class="panel-title">Trending Topics
                </h3></div>
            <g:render template="/home/trending" model="[user: user, trendingTopics: trendingTopics]"/>
        </div>

    </div>

</div>

<div style="visibility: hidden" id="temp"></div>
</body>
</html>