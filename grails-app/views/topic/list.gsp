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
<script type="text/javascript">

    var searchInTopic=function(value)
    {
         alert(value)
           $.ajax({
            url: "${createLink(controller:"topic" ,action:"find" )}",
            type: "GET",
            data: {search: value},
            success:function(data,textStatus){jQuery('#topicList').html(data); alert("success")},
            error:function(XMLHttpRequest,textStatus,errorThrown){ alert("error")}});

        return false
    }


    </script>

</head>
<body>

<div class="container" style="width: 100%">
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>
    <div style="width: 45%;float: left">
        <div class="panel panel-default"  style="width: 500px">
            <div class="panel-heading" align="left">
                <h1 class="panel-title">Search For :<g:if test="${topic}"> ${topic.name} </g:if>
                    <g:else>All Topics</g:else>
                    <input style="float: right" type="text" onchange="searchInTopic(value)"  name="searchString">
                </h1>
            </div>

                <div class="panel-body" id="topicList">
                    <g:render template="/home/trending" model="[user: user,trendingTopics:topics]"/>

                </div>


        </div>
    </div>

    <div style="width:50%;float:right">
        <div class="panel panel-default" style="width: 600px"  >
            <div class="panel-heading" align="left">
                <h3 class="panel-title">Search For :<g:if test="${topic}"> ${topic.name} </g:if>
                <g:else>All Posts</g:else>
                    <input style="float: right" type="text" onchange="searchInTopic(value)"  name="searchString">
                </h3>
            </div>
            <div id="resourceList" class="panel-body">
                <g:render template="/home/inbox" model="[resources: resources]"/>
            </div>
        </div>
    </div>


</div>
</body>
</html>