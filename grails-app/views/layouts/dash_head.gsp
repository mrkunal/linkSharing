<!DOCTYPE html>
<head>
    <title><g:layoutTitle default="Dashboard"/></title>

    %{--<!-- Latest compiled and minified CSS -->--}%
    %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">--}%

    %{--<!-- Optional theme -->--}%
    %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">--}%

    %{--<!-- Latest compiled and minified JavaScript -->--}%
    %{--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>--}%

    <g:javascript library="jquery"/>
    <script rel="script"  src="${resource(dir: 'js',file: 'bootstrap.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap.min.css')}" >
    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap-theme.min.css')}" >
    <g:layoutHead/>
<script type="text/javascript">
    var createTopic=function()
    {
        window.open("${g.createLink(controller: 'topic', action: 'create')}",'', 'width=500,height=300');

    }
    var createDocumentResource=function()
    {
        window.open("${g.createLink(controller: 'documentResource', action: 'create')}",'', 'width=500,height=400');

    }

    var createLinkResource=function()
    {
        window.open("${g.createLink(controller: 'linkResource', action: 'create')}",'', 'width=500,height=400');

    }
    var sendInvitation=function()
    {
        window.open("${g.createLink(controller: 'home', action: 'invitation',params: [topicId:null])}",'', 'width=400,height=300');

    }

</script>
</head>
<body>
<div class="container" style="border-width: thick;border-color:black" >
<h1 align="center">

    <g:if test="${session['userName']}">
          <g:link controller="home" action="dashboard"> Link Sharing Application</g:link>
    </g:if>
    <g:else>
        <g:link controller="login" action="index"> Link Sharing Application</g:link>
    </g:else>

</h1>
    <table align="right">
    <h2>
 <tr>
     <td> &nbsp;<g:form class="form-search" action="find" controller="search">
         <input type="text" class="input-medium search-query" name="search">
         <button type="submit" class="btn">Search</button>
     </g:form>
     </td>
<g:if test="${session['userName']}">



    <td>  &nbsp;&nbsp; <a href="" onclick="sendInvitation();return false">
        <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
    </a>
    &nbsp;
       <a href="" onclick="createLinkResource();return false">
            <span class="glyphicon glyphicon-paperclip" aria-hidden="true"></span>
       </a>
    &nbsp;
        <a href="" onclick="createDocumentResource();return false">
            <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
    </a>
    &nbsp;
        <a href="" onclick="createTopic();return false">
            <span class="glyphicon glyphicon-text-width" aria-hidden="true"></span>
        </a>
    </td>







    <td>
&nbsp;&nbsp;<span class="glyphicon glyphicon-user" aria-hidden="true"></span> ${session.userName}

<g:link controller="user" action="profile">Profile</g:link>
     <g:link controller="user" action="list">Users</g:link>
     <g:link controller="topic" action="list" params="[uid:null,operation:null]">Topics</g:link>
     <g:link>Posts</g:link>
     <g:link controller="home" action="logout">Logout</g:link>


     </td>
</g:if>
 </tr>
</h2>
</table>
</div>
<div style="border: solid;border-color: grey">
    <span id="msg" style="color: green;float:right;font-size: medium"></span>
    <br/><br/>

    <g:layoutBody/>
</div>
</body>
</html>
