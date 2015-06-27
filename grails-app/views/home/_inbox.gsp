<%@ page import="linksharing.LinkResource" %>
<div class="panel panel-default" style="width: 600px"  >
    <div class="panel-heading" align="left">
        <h3 class="panel-title">Inbox</h3>
    </div>

    <div class="panel-body" style="max-height:600px;overflow: scroll" align="left">
        <g:each in="${resources}" var="rs">

            <div class="panel-body">

                    <gt:pic uid="${rs.createdBy.id}"/>

<b><i>${rs.createdBy.firstName} @ ${rs.createdBy.userName}</i></b>
                <i> <gt:time time="${rs.lastUpdated}"/></i>


                 &emsp; <span style="padding-left:68px;"></span>     <g:link> ${rs.topic.name}</g:link>

                <br/> ${rs.description}
                <br/>

            &ensp;<span style="padding-left:68px;"></span>
                <% if (rs.instanceOf(LinkResource)){ %>
                <a href="${rs.url}" target="_blank">View Full Site</a>
                     <% }
                     else{ %>
                <g:link controller="home" action="document_download" params="[id:rs.id]">Download</g:link>
                     <% }%>
            &ensp;
                <g:link controller="viewPost" action="showPost" params="[resource:rs]">Mark As Read</g:link>
            &ensp;
                <g:link controller="viewPost" action="showPost" params="[resource:rs]">View Post</g:link>



            </div>
<hr/>
        </g:each>

    </div>
</div>