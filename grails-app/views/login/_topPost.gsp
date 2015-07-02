<h3>Top Post</h3>
<div style="overflow:scroll;height:150px;width: 550px;border:solid;border-color:lightgrey">

<g:each in="${toppost}" var="rs">

    <gt:pic uid="${rs.createdBy.id}"/>

    <i>${rs.createdBy.firstName} @${rs.createdBy.userName}</i>
    <g:link controller="topic" action="show" params="[topicId: rs.topic.id]"> ${rs.topic.name} </g:link>

    <br/>
    <br/>
    ${rs.description}

    <g:link controller="resource" action="viewPost" params="[resource:rs.id]">View Post</g:link>

    <br/>
</g:each>

</table>
</div>

