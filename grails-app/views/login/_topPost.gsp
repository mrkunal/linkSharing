<h3>Top Post</h3>
<div style="overflow:scroll;height:150px;width: 550px;border:solid;border-color:lightgrey">

<g:each in="${toppost}" var="rs">

    <gt:pic uid="${rs.user.id}"/>

    <i>${rs.user.firstName} @${rs.user.userName}</i> <a href="www.google.com">${rs.topic.name}</a>
    <br/>
    <br/>
    ${rs.description}

    <a href="www.google.com">view Post</a>

    <br/>
</g:each>

</table>
</div>

