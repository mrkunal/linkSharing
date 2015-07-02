<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dash_head">
    <title>LinkSharing</title>

</head>


<body>
<div >
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if><div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Send Invitation</h3>
    </div>
    <div class="panel-body">

        <form action="invite">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="text" class="form-control" placeholder="email" id="email" name="email">
            </div>
            <label>Topic</label>

            <g:select name="topic" from="${subscribed}" optionKey="id" optionValue="name"
            />
            <button type="submit" class="btn btn-default">Invite</button>
            <button class="btn btn-default">Cancel</button>
        </form>

    </div>
</div>

</body>
</html>