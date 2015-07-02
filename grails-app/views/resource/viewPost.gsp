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

</head>
<body>
<div class="container" style="border:thin; width: 100%">
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>

    <div class="panel panel-default" style="width:40%;float: left;margin-top: 10%">
        <div class="panel-body">
           <div style="width: 30%;float: left">
            <gt:pic uid="${resource.createdBy.id}"/>
           </div>
           <div style="width: 60%;float: left">
            <b>${resource.createdBy.firstName} ${resource.createdBy.lastName} </b>
               <g:link controller="topic" action="show" style="float: right"> ${resource.topic.name} </g:link>

               <br/> @${resource.createdBy.userName}

    <p style="float:right">     <gt:time time="${resource.lastUpdated}"/>
           </p>
        <g:form style="float: right" controller="resource" action="rate" params="[resource:resource.id]">
           ${usersRate} users
           <g:submitButton name="rate" value="1"  />
           <g:submitButton name="rate" value="2" />
           <g:submitButton name="rate" value="3" />
           <g:submitButton name="rate" value="4" />
           <g:submitButton name="rate" value="5" />
          </g:form>
           </div>
         <br/><br/><br/><br/>
            ${resource.description}

            <br/><p style="float: right">
            <% if (access){ %>
            <g:link controller="resource" action="delete" params="[resource:resource.id]">Delete</g:link>&ensp;
            <g:link controller="resource" action="edit" params="[resource:resource.id]">Edit</g:link>&ensp;

            <% }



             if (resource.instanceOf(LinkResource)){ %>
            <a href="${resource.url}" target="_blank">View Full Site</a>&ensp;
            <% }
            else{ %>
            <g:link controller="documentResource" action="document_download" params="[id:resource.id]">Download</g:link>&ensp;
            <% }%>
        </p>


        </div>
    </div>
<div style="width: 50%;float: right;margin-top: 10%">

    <div class="panel panel-default" style="width: 500px"  >
        <div class="panel-heading" align="left">
            <h3 class="panel-title">Trending Topics
            </h3></div>
        <g:render template="/home/trending" model="[user: user,trendingTopics:trendingTopics]"/>
    </div>

</div>



 </div>
</body>
</html>