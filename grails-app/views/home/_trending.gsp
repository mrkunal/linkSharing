<%@ page import="linksharing.*" %>

<div class="panel-body" style="max-height:300px;width:500px;overflow: scroll">
        <g:each in="${trendingTopics}" var="topic">

            <div class="panel-body">

                <div style="width: 100%;float: left">

                    <div style="width:40%;float:left">

                <gt:pic uid="${topic.createdBy.id}"/>

            </div>
                    <g:if test="${topic.createdBy!=user && user.admin==false}">
            <div style="width: 50%;float: left">
                <g:link controller="topic" action="show" params="[topicId: topic.id]"> ${topic.name} </g:link>

                <br/><b><i>${topic.createdBy.userName}</i></b>
      <br/><br/>
            &ensp;
                Subscriptions
                <g:link><gt:subscriptionCount uid="${topic.createdBy.id}"/></g:link>
            &ensp;
                Posts
                <g:link><gt:postCount uid="${topic.createdBy.id}"/></g:link>
                <br/>
            &ensp;
                <%  def sub1=Subscription.findByUserAndTopic(user,topic)
                    if (sub1){ %>
                <g:link controller="subscription" action="unSubscribe" params="[topicId:topic.id]">Unsubscribe</g:link>
            &ensp;
                <g:select id="seriousness" name="seriousness" from="${['Casual','Very Serious','Serious']}" keys="${[Seriousness.CASUAL,Seriousness.VERYSERIOUS,Seriousness.SERIOUS]}"
                          value="${sub1.seriousness}" />

            &nbsp;&nbsp; <g:link action="invitation" controller="home" params="[topicId:topic.id]">
           <br/>     <span class="glyphicon glyphicon-envelope" style="float: right" aria-hidden="true"></span>
            </g:link>
                <% }
                else{ %>
                <g:link controller="subscription" action="subscribe" params="[topicId:topic.id]">Subscribe</g:link>
                <g:select id="seriousness" name="seriousness" from="${['Casual','Very Serious','Serious']}" keys="${[Seriousness.CASUAL,Seriousness.VERYSERIOUS,Seriousness.SERIOUS]}"
                          value="" />
                <% }%>

            </div>
    </g:if>
    <g:if test="${topic.createdBy==user || user.admin==true}">
        <div style="width: 50%;float: left">
            <g:link controller="topic" action="show" params="[topicId: topic.id]">  ${topic.name} </g:link>
     <br/>
            <b><i>${topic.createdBy.userName}</i></b>
            <br/><br/>
        &ensp;
            Subscriptions
            <g:link><gt:subscriptionCount uid="${topic.createdBy.id}"/></g:link>
        &ensp;
            Posts
            <g:link><gt:postCount uid="${topic.createdBy.id}"/></g:link>
            <br/>
        &ensp;
            <%  def sub=Subscription.findByUserAndTopic(user,topic)
                if (sub){ %>
            <g:link controller="subscription" action="unSubscribe" params="[topicId:topic.id]">Unsubscribe</g:link>
        <br/>
        &ensp;
            <g:select id="seriousness" name="seriousness" from="${['Casual','Very Serious','Serious']}" keys="${[Seriousness.CASUAL,Seriousness.VERYSERIOUS,Seriousness.SERIOUS]}"
                      value="${sub.seriousness}" />

            <g:select id="visibility" name="visibility" from="${['Private','Public']}" keys="${[Visibility.PRIVATE,Visibility.PUBLIC]}"
                      value="${topic.visibility}" />

<br/>
       <div style="float: right"> <g:link action="invitation" controller="home" params="[topicId:topic.id]">
            <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
        </g:link>
        &nbsp;&nbsp;
            <g:link action="invitation" controller="home">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
            </g:link>
        &nbsp;&nbsp;
            <g:link action="invitation" controller="home">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
            </g:link>
       </div>
            <% }
            else{ %>
            <g:link controller="subscription" action="subscribe" params="[topicId:topic.id]">Subscribe</g:link>

            <g:select id="seriousness" name="seriousness" from="${['Casual','Very Serious','Serious']}" keys="${[Seriousness.CASUAL,Seriousness.VERYSERIOUS,Seriousness.SERIOUS]}"
                      value="" />
            <% }%>

        </div>

    </g:if>

</div>

            </div>
            <hr/>
        </g:each>

    </div>
