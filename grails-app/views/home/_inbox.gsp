<div class="panel panel-default" style="width: 600px" align="left">
    <div class="panel-heading">
        <h3 class="panel-title">Inbox</h3>
    </div>

    <div class="panel-body" style="max-height:600px;overflow: scroll">
        <g:each in="${resources}" var="rs">

            <div class="panel-body">

                    <gt:pic uid="${rs.createdBy.id}"/>

                <i>${rs.createdBy.firstName} @ ${rs.createdBy.userName}</i>

                <a href="www.google.com" style="padding-left: 140px">${rs.topic.name}</a>

                <br/> ${rs.description}
                <br/>
                <g:link controller="viewPost" action="showPost" params="[resource:rs]">View Post</g:link>



            </div>
<hr/>
        </g:each>

    </div>
</div>