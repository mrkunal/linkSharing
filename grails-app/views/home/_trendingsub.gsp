<%@ page import="linksharing.*" %>


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
                <g:link controller="topic" action="show" params="[topicId: topic.id]"><gt:topicSubscriptionCount tid="${topic.id}"/></g:link>
            &ensp;
                Posts
                <g:link controller="topic" action="show" params="[topicId: topic.id]"><gt:topicPostCount tid="${topic.id}"/></g:link>
                <br/>
            &ensp;
                <%  def sub1=Subscription.findByUserAndTopic(user,topic)
                if (sub1){ %>


                <g:remoteLink controller="subscription" action="subscribeAndUnsubscribe" params="{topicId:${topic.id}}" update="${topic.id}">
                    <span id="${topic.id}">

                    Unsubscribe </span> </g:remoteLink>


            &ensp;
                <g:select id="seriousness" name="seriousness" from="${['Casual','Very Serious','Serious']}" keys="${[Seriousness.CASUAL,Seriousness.VERYSERIOUS,Seriousness.SERIOUS]}"
                          value="${sub1.seriousness}" onchange="seriousnessChange(value,${topic.id})" style="float: right" />

            &nbsp;&nbsp; <a href="" onclick="sendInvitation();return false">
                <br/>     <span class="glyphicon glyphicon-envelope" style="float: right" aria-hidden="true"></span>
                    </a>
                <% }
                else{ %>




                <g:remoteLink controller="subscription" action="subscribeAndUnsubscribe" params="{topicId:${topic.id}}" update="${topic.id}">
                    <span id="${topic.id}">

                    Subscribe </span> </g:remoteLink>


                <g:select id="seriousness" name="seriousness" from="${['Casual','Very Serious','Serious']}" keys="${[Seriousness.CASUAL,Seriousness.VERYSERIOUS,Seriousness.SERIOUS]}"
                          value="" onchange="seriousnessChange(value,${topic.id})" style="float: right" />
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
                <g:link controller="topic" action="show" params="[topicId: topic.id]" ><gt:topicSubscriptionCount tid="${topic.id}"/></g:link>
            &ensp;
                Posts
                <g:link controller="topic" action="show" params="[topicId: topic.id]"><gt:topicPostCount tid="${topic.id}"/></g:link>
                <br/>
            &ensp;
                <%  def sub=Subscription.findByUserAndTopic(user,topic)
                if (sub){ %>



                <g:remoteLink controller="subscription" action="subscribeAndUnsubscribe" params="{topicId:${topic.id}}" update="${topic.id}"> <span id="${topic.id}">

                    Unsubscribe </span> </g:remoteLink>



                <br/>
            &ensp;
                <g:select id="seriousness" name="seriousness" from="${['Casual','Very Serious','Serious']}" keys="${[Seriousness.CASUAL,Seriousness.VERYSERIOUS,Seriousness.SERIOUS]}"
                          value="${sub.seriousness}" onchange="seriousnessChange(value,${topic.id})" />

                <g:select id="visibility" name="visibility" from="${['Private','Public']}" keys="${[Visibility.PRIVATE,Visibility.PUBLIC]}"
                          value="${topic.visibility}" onchange="visibilityChange(value,${topic.id})" />

                <br/>
                <div style="float: right">
                    <a href="" onclick="sendInvitation();return false">
                        <span class="glyphicon glyphicon-envelope" aria-hidden="true"  id="inv${topic.id}"></span>
                    </a>
                &nbsp;&nbsp;
                    <g:link action="invitation" controller="home">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                    </g:link>
                &nbsp;&nbsp;
                    <a onclick="del(${topic.id}); return false" href="">
                        <span class="glyphicon glyphicon-trash" aria-hidden="true"/>
                    </a>
                </div>
                <% }
                else{ %>


                <g:remoteLink controller="subscription" action="subscribeAndUnsubscribe" params="{topicId:${topic.id}}" update="${topic.id}"> <span id="${topic.id}">

                    Subscribe </span> </g:remoteLink>


                <g:select id="seriousness" name="seriousness" from="${['Casual','Very Serious','Serious']}" keys="${[Seriousness.CASUAL,Seriousness.VERYSERIOUS,Seriousness.SERIOUS]}"
                          value="" onchange="seriousnessChange(key,${topic.id})" />
                <% }%>

            </div>


        </g:if>



    </div>

