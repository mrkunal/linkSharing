<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dash_head">
    <title>LinkSharing</title>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>

<body>
<div style="border:solid thick " >


    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="left">${flash.message}</div>
    </g:if>
    <div class="panel panel-default" align="left">
        <div class="panel-heading">
            <h3 class="panel-title">Create Topic</h3>
        </div>
        <div class="panel-body">
            <g:form controller="topic" action="save">

                <input type="text" class="form-control" placeholder="Topic Name" name="name">

                <select class="form-control" name="visibility">
                    <option value="PUBLIC">PUBLIC</option>
                    <option value="PRIVATE">PRIVATE</option>
                </select>

                <button type="submit" class="btn btn-default">Share</button>
                <button class="btn btn-default">Cancel</button>
            </g:form>
        </div>
    </div>




</div>

</body>
</html>