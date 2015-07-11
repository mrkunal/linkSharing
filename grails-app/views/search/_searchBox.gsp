<%@ page import="linksharing.*" %>

    <div class="panel-body" style="max-height:600px;overflow: scroll" align="left">
        <g:each in="${resources}" var="rs">

            <div class="panel-body">

                    <ApplicationTag:pic uid="${rs.createdBy.id}"/>

<b><i>${rs.createdBy.firstName} @ ${rs.createdBy.userName}</i></b>
                <i> <ApplicationTag:time time="${rs.lastUpdated}"/></i>


                 &emsp; <span style="padding-left:68px;"></span>     <g:link> ${rs.topic.name}</g:link>

                <br/> ${rs.description}
                <br/>

            &ensp;<span style="padding-left:68px;"></span>

                <% if (rs.instanceOf(LinkResource)){ %>
                <a href="${rs.url}" target="_blank">View Full Site</a>
                     <% }
                     else{ %>
                <g:link controller="documentResource" action="document_download" params="[id:rs.id]">Download</g:link>
                     <% }%>
            &ensp;
                <% if(ReadingItem.findByResourceAndUser(rs,User.findByUserName(session['userName']))!=null) { %>
                <g:link controller="readingItem" action="markAsUnread" params="[resource:rs.id]">Mark As Unread</g:link>
            <% }  else { %>
                <g:link controller="readingItem" action="markAsRead" params="[resource:rs.id]">Mark As read</g:link>
                <% }  %>
            &ensp;

                <g:link controller="viewPost" action="showPost" params="[resource:rs]">View Post</g:link>



            </div>
<hr/>
        </g:each>

    </div>
