<h3>view Post</h3>
<div style="overflow:scroll;width: 550px;border:solid;border-color:lightgrey;float:left" >

    <div style="height:110px;width:140px;float:left;padding:5px">
        <gt:pic uid="${rs.createdBy.id}"/>
    </div>
    <br/> <div style="float:left;padding-left: 5px;height:150px;width: 330px">
    <i>${rs.createdBy.firstName} @${rs.createdBy.userName}</i> <a href="www.google.com" style="padding-left: 140px">${rs.topic.name}</a>

    <br/> ${rs.description}
    <br/>
    <p align="right">  <a href="www.google.com" style="align-self: center">view Post</a>
    </p>
    <hr/>
</div>

</table>
</div>










