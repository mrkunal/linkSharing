<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>LinkSharing</title>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>

<body>
<div >


    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="left">${flash.message}</div>
    </g:if>
<div class="panel panel-default" align="left">
    <div class="panel-heading">
        <h3 class="panel-title">Forgot Password</h3>
    </div>
    <div class="panel-body"  >
<g:form controller="login" action="query">
        <div class="form-group">
            <label for="email">Email address</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="Email">
           <br/> <br/> <button type="submit" class="btn btn-default">Send Password</button>
        </div>
</g:form>
    </div>
</div>




    </div>

</body>
</html>