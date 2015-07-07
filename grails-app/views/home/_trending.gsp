<%@ page import="linksharing.*" %>

<script type="text/javascript">
    var sendInvitation=function(val)
    {
        window.open("${g.createLink(controller: 'home', action: 'invitation',params: [topicId:val])}",'', 'width=400,height=300');

    }
    var subscribeAndUnsubscribe=function(val){
        alert ("Subscribe"+val)
        var s="sub"+val

        <g:remoteFunction controller="subscription" action="subscribeAndUnsubscribe" update="s" params='{topicId:val}'/>
 //      $('#sub'+val).innerHTML="subscribe"
//
        %{--$('#div'+val).innerHTML=<g:render template="trendingsub" model="[topic:Topic.first(),user: user]"/>--}%
        %{--$('#div'+val).innerHTML= <g:render template="trendingsub" model="[topic:Topic.first(),user: user]"/>--}%

    }

    var del=function(val)
    {
        <g:remoteFunction controller="topic" action="delete" params='{topicId:val}'/>

        $('#div'+val).empty()

        $('<span style="color: green;float: right;font-size: medium">Topic Deleted Successfully</span>')
                .insertBefore('#msg')
                .delay(3000)
                .fadeOut(function() {
                    $(this).remove();
                });

    }

    var seriousnessChange=function(val,tid)
    {
        <g:remoteFunction controller="subscription" action="seriousnessChange" params='{topicId:tid,seriousness:val}'/>

        $('#div'+val).empty()

        $('<span style="color: green;float: right;font-size: medium">Seriousness Changed.</span>')
                .insertBefore('#msg')
                .delay(3000)
                .fadeOut(function() {
                    $(this).remove();
                });
    }

    var visibilityChange=function(val,tid)
    {
        <g:remoteFunction controller="subscription" action="visibilityChange" params='{topicId:tid,visibility:val}'/>

        $('#div'+val).empty()

        $('<span style="color: green;float: right;font-size: medium">Visibility Changed.</span>')
                .insertBefore('#msg')
                .delay(3000)
                .fadeOut(function() {
                    $(this).remove();
                });

    }



</script>

<div class="panel-body" style="max-height:300px;width:500px;overflow: scroll">
        <g:each in="${trendingTopics}" var="topic">
            <div class="panel-body" id="div${topic.id}">
            <g:render template="/home/trendingsub" model="[topic:topic,user:user]"/>
                <hr/>
            </div>
        </g:each>

    </div>
