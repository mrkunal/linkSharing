<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dash_head">
    <title>LinkSharing</title>

</head>


<body>
<div style="border:solid thick " >
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>

    <div class="panel panel-default" align="left">
        <div class="panel-heading">
            <h3 class="panel-title">Share Document</h3>
        </div>
        <div class="panel-body"  >
            <g:uploadForm action="save">
                <div class="form-group">
                    <label for="file">Document</label>
                    <input type="file" id="file" name="file">
                    <p class="help-block">Upload Document you want to Share.</p>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea class="form-control" rows="5" id="description" name="description" placeholder="Description"></textarea>
                </div>
                <label>Topic</label>

                <g:select name="topic" from="${topics.id}"
                />
                <button type="submit" class="btn btn-default">Share</button>
                <button class="btn btn-default">Cancel</button>
            </g:uploadForm>
        </div>
    </div>


</div>
</body>
</html>