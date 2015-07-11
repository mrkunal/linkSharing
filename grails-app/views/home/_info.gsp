<div class="panel panel-default" align="left">
    <div class="panel-body" style="width: 500px" >
        <div style="width:40%;float: left; ">
        <ApplicationTag:pic uid="${user.id}"/></div>
        <div style="float: left;width: 50%">
    <h2> ${user.firstName} ${user.lastName} </h2>
    <h4> ${user.userName}</h4>
    Topics :<g:link controller="topic" action="list" params="[uid:user.id,operation:'topic']">
    <ApplicationTag:topicCount uid="${user.id}"/>
    </g:link>
    Subscriptions :<g:link controller="topic" action="list" params="[uid:user.id,operation: 'subscriptions']">
    <ApplicationTag:subscriptionCount uid="${user.id}"/></g:link>

        </div>
</div>
</div>