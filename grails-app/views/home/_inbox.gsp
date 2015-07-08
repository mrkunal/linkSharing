<%@ page import="linksharing.*" %>
<script type="text/javascript">
  var read=function(value){
      var rid=value
      <g:remoteFunction controller="readingItem" action="readOrUnread" update="rid" params='{sort:rid}'/>
  }

</script>

<div class="panel-body" style="max-height:600px;overflow: scroll" align="left">
        <g:each in="${resources}" var="rs">

            <div class="panel-body">

                    <gt:pic uid="${rs.createdBy.id}"/>

<b><i>${rs.createdBy.firstName} @ ${rs.createdBy.userName}</i></b>
                <i> <gt:time time="${rs.lastUpdated}"/></i>


                 &emsp; <span style="padding-left:68px;"></span>
                <g:link controller="topic" action="show" params="[topicId:rs.topic.id]"> ${rs.topic.name}</g:link>

                <br/> <gt:description rid="${rs.id}"></gt:description>

                <br/>

            &ensp;<span style="padding-left:68px;"></span>

                <% if (rs.instanceOf(LinkResource)){ %>
                <a href="${rs.url}" target="_blank">View Full Site</a>
                     <% }
                     else{ %>
                <g:link controller="documentResource" action="document_download" params="[id:rs.id]">Download</g:link>
                     <% }%>
            &ensp;

                %{--Testing---------------------}%
                <% if(ReadingItem.findByResourceAndUser(rs,User.findByUserName(session['userName']))!=null) { %>

                <g:remoteLink controller="readingItem" action="readOrUnread" params="{rid:${rs.id}}" update="${rs.id}"> <span id="${rs.id}">

                Mark As Unread </span> </g:remoteLink>
                 %{--<g:link controller="readingItem" action="markAsUnread" params="[resource:rs.id]">Mark As Unread</g:link>--}%
                <% }  else { %>
                <g:remoteLink controller="readingItem" action="readOrUnread" params="{rid:${rs.id}}" update="${rs.id}">
                    <span id="${rs.id}">

                    Mark As Read </span> </g:remoteLink>

            %{--<g:link controller="readingItem" action="markAsRead" params="[resource:rs.id]">Mark As read</g:link>--}%
                <% }  %>
            &ensp;


                %{--Testing-------------------------}%


                <g:link controller="resource" action="viewPost" params="[resource:rs.id]">View Post</g:link>



            </div>
<hr/>
        </g:each>

    </div>
