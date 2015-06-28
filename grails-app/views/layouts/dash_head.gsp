<!DOCTYPE html>
<head>
    <title><g:layoutTitle default="Dashboard"/></title>

    %{--<!-- Latest compiled and minified CSS -->--}%
    %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">--}%

    %{--<!-- Optional theme -->--}%
    %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">--}%

    %{--<!-- Latest compiled and minified JavaScript -->--}%
    %{--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>--}%

    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap.min.css')}" >
    <script rel="script"  src="${resource(dir: 'js',file: 'bootstrap.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap-them.min.css')}" >

    <g:layoutHead/>

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
     <td> &nbsp;<form class="form-search">
         <input type="text" class="input-medium search-query">
         <button type="submit" class="btn">Search</button>
     </form>
     </td>
<g:if test="${session['userName']}">
     <td>  &nbsp;&nbsp; <g:link action="invitation" controller="home">
        <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
    </g:link>
        &nbsp;
    <g:link action="create" controller="linkResource">
    <span class="glyphicon glyphicon-paperclip" aria-hidden="true"></span>
    </g:link>
    &nbsp;
    <g:link action="create" controller="documentResource">
        <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
    </g:link>
   &nbsp;
    <g:link action="create" controller="topic">
        <span class="glyphicon glyphicon-text-width" aria-hidden="true"></span>
    </g:link>
 </td>

     <td>
&nbsp;&nbsp;<span class="glyphicon glyphicon-user" aria-hidden="true"></span> ${session['userName']}



 </td>
</g:if>
 </tr>
</h2>
</table>
</div>


<g:layoutBody/>
</body>
</html>
