<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:javascript library="jquery"/>
    <script rel="script"  src="${resource(dir: 'js',file: 'bootstrap.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap.min.css')}" >
    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap-theme.min.css')}" >
    <title>Invitation</title>

    <script  type="text/javascript">

        var exit=function()
        {
            window.close()
        }

    </script>

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

            <g:select name="topic" from="${subscribed}" optionKey="id" optionValue="name" value="${topic}"/>
           <br/>
            <button type="submit" class="btn btn-default">Invite</button>
        </form>
        <button class="btn btn-default" onclick="exit()" style="float: right ">Cancel</button>

    </div>
</div>
</body>
</html>