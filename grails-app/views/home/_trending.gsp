<%@ page import="linksharing.*" %>
<div class="panel panel-default" style="width: 500px"  >
    <div class="panel-heading" align="left">
        <h3 class="panel-title">Trending Topics<g:link style="float:right">View All</g:link>
        </h3></div>

    <div class="panel-body" style="max-height:300px;width:500px;overflow: scroll">
        <g:each in="${trendingTopics}" var="topic">

            <div class="panel-body">

                <gt:pic uid="${topic.createdBy.id}"/>
                <g:link> ${topic.name}</g:link>

                <br/><b><i>${topic.createdBy.userName}</i></b>



            &ensp;<span style="padding-left:68px;"></span>
                <% if (Subscription.findByUserAndTopic(user,topic)){ %>
                <g:link>Unsubscribe</g:link>
                <% }
                else{ %>
                <g:link>Subscribe</g:link>
                <% }%>
            &ensp;
                Subscriptions
                <g:link>50</g:link>
            &ensp;
                Posts
                <g:link>50</g:link>



            </div>
            <hr/>
        </g:each>

    </div>
</div>