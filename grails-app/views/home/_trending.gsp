<%@ page import="linksharing.*" %>

<script type="text/javascript">

    var topicEdit = function (val) {
        var elem = $('#topicName' + val).hide()
        var elem1 = $('#topicEdit' + val).show()

        return false;

    }

    var changeName = function (val) {
        var elem = $('#input' + val).val()

        $.ajax({
            url: "${createLink(controller:"topic" ,action:"changeName" )}",
            type: "GET",
            data: {topicId: val,topicName:elem},
            success: function () {
                $('#topicEdit' + val).hide()
                $('#topicName'+val).text(elem)
                $('#topicName' + val).show()

            },
            error: function (request, status, error) {
                alert(error)

            }
        });

        return false

    }
    var editCancel = function (val) {
        var elem = $('#topicName' + val).show()
        var elem1 = $('#topicEdit' + val).hide()
        return false;

    }


    var del = function (val) {
        <g:remoteFunction controller="topic" action="delete" params='{topicId:val}'/>

        $('div[name=' + val + ']').empty()

        $('<span style="color: green;float: right;font-size: medium">Topic Deleted Successfully</span>')
                .insertBefore('#msg')
                .delay(3000)
                .fadeOut(function () {
                    $(this).remove();
                });

    }

    var seriousnessChange = function (val, tid) {
        <g:remoteFunction controller="subscription" action="seriousnessChange" params='{topicId:tid,seriousness:val}'/>

        $('[name=tid]').empty()
        $('<span style="color: green;float: right;font-size: medium">Seriousness Changed.</span>')
                .insertBefore('#msg')
                .delay(3000)
                .fadeOut(function () {
                    $(this).remove();
                });
    }

    var visibilityChange = function (val, tid) {
        <g:remoteFunction controller="subscription" action="visibilityChange" params='{topicId:tid,visibility:val}'/>
        $('[name=tid]').empty()

        $('<span style="color: green;float: right;font-size: medium">Visibility Changed.</span>')
                .insertBefore('#msg')
                .delay(3000)
                .fadeOut(function () {
                    $(this).remove();
                });

    }


</script>

<div class="panel-body" style="width:500px">
    <g:each in="${trendingTopics}" var="topic">

        <div class="panel-body" name="${topic.id}">

            <g:render template="/home/trendingsub" model="[topic: topic, user: user]"/>

        </div>
        <hr/>

    </g:each>

</div>
