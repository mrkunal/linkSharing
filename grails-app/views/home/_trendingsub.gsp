<%@ page import="linksharing.*" %>


<div style="width: 100%;float: left">

    <div style="width:40%;float:left">

        <ApplicationTag:pic uid="${topic.createdBy.id}"/>

    </div>
    <g:if test="${topic.createdBy != user && user.admin == false}">
        <div style="width: 50%;float: left">
            <div name="topicName${topic.id}">
                <g:link controller="topic" action="show" params="[topicId: topic.id]">${topic.name}</g:link>
            </div>

          <b><i>${topic.createdBy.userName}</i></b>
            <br/><br/>
        &ensp;
            Subscriptions
            <g:link controller="topic" action="show" params="[topicId: topic.id]"><ApplicationTag:topicSubscriptionCount
                    tid="${topic.id}"/></g:link>
        &ensp;
            Posts
            <g:link controller="topic" action="show" params="[topicId: topic.id]"><ApplicationTag:topicPostCount
                    tid="${topic.id}"/></g:link>
            <br/>
        &ensp;
            <% def sub1 = Subscription.findByUserAndTopic(user, topic)
            if (sub1) { %>


            <g:remoteLink controller="subscription" action="subscribeAndUnsubscribe" params="{topicId:${topic.id}}"
                          onSuccess="jQuery('[name=${topic.id}]').html(data);"><span id="${topic.id}">

                Unsubscribe</span></g:remoteLink>


        &ensp;
            <g:select id="seriousness" name="seriousness" from="${['Casual', 'Very Serious', 'Serious']}"
                      keys="${[Seriousness.CASUAL, Seriousness.VERYSERIOUS, Seriousness.SERIOUS]}"
                      value="${sub1.seriousness}" onchange="seriousnessChange(value,${topic.id})" style="float: right"/>

            &nbsp;&nbsp; <a href="" onclick="sendInvitation(${topic.id});
        return false">
            <br/>     <span class="glyphicon glyphicon-envelope" style="float: right" aria-hidden="true"></span>
        </a>
            <% } else { %>




            <g:remoteLink controller="subscription" action="subscribeAndUnsubscribe" params="{topicId:${topic.id}}"
                          onSuccess="jQuery('[name=${topic.id}]').html(data);"><span id="${topic.id}">

                Subscribe</span></g:remoteLink>


            <g:select id="seriousness" name="seriousness" from="${['Casual', 'Very Serious', 'Serious']}"
                      keys="${[Seriousness.CASUAL, Seriousness.VERYSERIOUS, Seriousness.SERIOUS]}"
                      value="" onchange="seriousnessChange(value,${topic.id})" style="float: right"/>
            <% } %>

        </div>
    </g:if>
    <g:if test="${topic.createdBy == user || user.admin}">

        <div style="width: 50%;float: left">

                <g:link controller="topic" action="show" params="[topicId: topic.id]">
                    <div id="topicName${topic.id}">
                    ${topic.name}
                    </div></g:link>


            <div style="display:none" id="topicEdit${topic.id}">

                    <div class="form-group">
                        <input type="text" class="form-control" value="${topic.name}" id="input${topic.id}">
                    </div>
                    <button class="btn btn-default" onclick="changeName(${topic.id})">Save</button>
                    <button class="btn btn-default" onclick="editCancel(${topic.id})">Cancel</button>

            </div>



            <b><i>${topic.createdBy.userName}</i></b>
            <br/><br/>
        &ensp;
            Subscriptions
            <g:link controller="topic" action="show" params="[topicId: topic.id]"><ApplicationTag:topicSubscriptionCount
                    tid="${topic.id}"/></g:link>
        &ensp;
            Posts
            <g:link controller="topic" action="show" params="[topicId: topic.id]">
                <ApplicationTag:topicPostCount tid="${topic.id}"/></g:link>
            <br/>
        &ensp;
            <% def sub = Subscription.findByUserAndTopic(user, topic)
            if (sub) { %>



            <g:remoteLink controller="subscription" action="subscribeAndUnsubscribe" params="{topicId:${topic.id}}"
                          onSuccess="jQuery('[name=${topic.id}]').html(data);"><span id="${topic.id}">

                Unsubscribe</span></g:remoteLink>



            <br/>
        &ensp;
            <g:select id="seriousness" name="seriousness" from="${['Casual', 'Very Serious', 'Serious']}"
                      keys="${[Seriousness.CASUAL, Seriousness.VERYSERIOUS, Seriousness.SERIOUS]}"
                      value="${sub.seriousness}" onchange="seriousnessChange(value,${topic.id})"/>

            <g:select id="visibility" name="visibility" from="${['Private', 'Public']}"
                      keys="${[Visibility.PRIVATE, Visibility.PUBLIC]}"
                      value="${topic.visibility}" onchange="visibilityChange(value,${topic.id})"/>

            <br/>

            <div style="float: right">
                <a href="" onclick="sendInvitation(${topic.id});
                return false">
                    <span class="glyphicon glyphicon-envelope" aria-hidden="true" id="inv${topic.id}"></span>
                </a>
                &nbsp;&nbsp;


                <a href="" onclick="topicEdit(${topic.id});return false">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                </a>


                &nbsp;&nbsp;
                <a onclick="del(${topic.id});
                return false" href="">
                    <span class="glyphicon glyphicon-trash" aria-hidden="true"/>
                </a>
            </div>
            <% } else { %>


            <g:remoteLink controller="subscription" action="subscribeAndUnsubscribe" params="{topicId:${topic.id}}"
                          onSuccess="jQuery('[name=${topic.id}]').html(data);"><span id="${topic.id}">

                Subscribe</span></g:remoteLink>


            <g:select id="seriousness" name="seriousness" from="${['Casual', 'Very Serious', 'Serious']}"
                      keys="${[Seriousness.CASUAL, Seriousness.VERYSERIOUS, Seriousness.SERIOUS]}"
                      value="" onchange="seriousnessChange(key,${topic.id})"/>
            <% } %>

        </div>

    </g:if>

</div>
