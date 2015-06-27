<!DOCTYPE html>
<head>
    <title><g:layoutTitle default="Dashboard"/></title>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <g:layoutHead/>

</head>
<body>
<div style="background-color: gainsboro;border-width: thick;border-color:black" >
<h1 align="center">   Link Sharing Application</h1>

<h4 align="right">

    <g:link action="create" controller="linkResource"> Share link</g:link>
    <g:link action="create" controller="documentResource"> Share Document</g:link>
    <g:link action="create" controller="topic">Create Topic</g:link>
    <form class="form-search">
    <input type="text" class="input-medium search-query">
    <button type="submit" class="btn">Search</button>
</form>  Hi ,${session['userName']}
</h4></div>


<g:layoutBody/>
</body>
</html>
