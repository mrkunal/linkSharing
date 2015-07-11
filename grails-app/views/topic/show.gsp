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
    var searchInTopic=function(search){
        <g:remoteFunction controller="topic" action="search" update="resourceList"
        params='{searchString:search,topicId:${topic.id}}'/>
       // alert(eb)
    }
</script>
</head>
<body>

<div class="container" style="width: 100%;margin-top:4%">
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>
    <div style="width: 45%;float: left">
        <div class="panel panel-default"  style="width: 500px">
            <div class="panel-heading" align="left">
                <h3 class="panel-title">Topic :${topic.name}</h3>
            </div>
            <div>
                <g:render template="/home/trending" model="[user: user,trendingTopics:topic]"/>

            </div>





        </div>

        <div class="panel panel-default"  style="width: 550px">
            <div class="panel-heading" align="left">
                <h3 class="panel-title">Users : ${topic.name}</h3>
            </div>
               <div>
               <g:each in="${users}" var="us">
                   <g:render template="/home/info" model="[user: us]"/>

                </g:each>
               </div>
        </div>
    </div>


        <div style="width:50%;float:right">
            <div class="panel panel-default" style="width: 600px"  >
                <div class="panel-heading" align="left">
                    <h3 class="panel-title">Posts:" ${topic.name} "
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