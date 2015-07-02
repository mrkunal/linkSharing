
<div style="overflow:scroll;overflow-x: hidden; max-height:300px;width: 550px;border:solid;border-color:lightgrey;float:left" >

<g:each in="${resources}" var="rs">

  <div style="height:110px;width:140px;float:left;padding:5px">
    <gt:pic uid="${rs.createdBy.id}"/>
</div>
   <br/> <div style="float:left;padding-left: 5px;height:150px;width: 330px">
   <b>  <i>${rs.createdBy.firstName} @ ${rs.createdBy.userName}</i></b>
<i> <gt:time time="${rs.lastUpdated}"/></i>

 <span style="float: right">   <g:link controller="topic" action="show" params="[topicId: rs.topic.id]"> ${rs.topic.name} </g:link>
 </span>
   <br/> ${rs.description}
<br/>
  <p align="right"><g:link controller="resource" action="viewPost" params="[resource:rs.id]">View Post</g:link>

  </p>
    <hr/>
</div>

    </g:each>

</table>
</div>










