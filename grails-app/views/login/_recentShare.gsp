
<div style="overflow:scroll;height:300px;width: 550px;border:solid;border-color:lightgrey;float:left" >

<g:each in="${resources}" var="rs">

  <div style="height:110px;width:140px;float:left;padding:5px">
    <gt:pic uid="${rs.createdBy.id}"/>
</div>
   <br/> <div style="float:left;padding-left: 5px;height:150px;width: 330px">
   <b>  <i>${rs.createdBy.firstName} @ ${rs.createdBy.userName}</i></b>
<i> <gt:time time="${rs.lastUpdated}"/></i>

    <a href="www.google.com" style="padding-left: 60px">${rs.topic.name}</a>

   <br/> ${rs.description}
<br/>
  <p align="right"><g:link controller="viewPost" action="showPost" params="[resource:rs]">View Post</g:link>

  </p>
    <hr/>
</div>

    </g:each>

</table>
</div>










