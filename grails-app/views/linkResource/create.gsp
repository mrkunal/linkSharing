<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:javascript library="jquery"/>
    <script rel="script"  src="${resource(dir: 'js',file: 'bootstrap.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap.min.css')}" >
    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap-theme.min.css')}" >
    <title>Link Create</title>

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
    </g:if>


<div class="panel panel-default" align="left">
    <div class="panel-heading">
        <h3 class="panel-title">Share Link</h3>
    </div>
 <div class="panel-body"  >
<form action="save">
    <div class="form-group">
        <label for="url">Link</label>
        <input type="text" class="form-control" placeholder="URL" id="url" name="url" value="${resource?.url}">
    </div>
    <div class="form-group">
        <label for="description">Description</label>
        <textarea class="form-control" rows="5" id="description" name="description" placeholder="Description">${resource?.description}
        </textarea>
    </div>
    <g:if test="${resource}">
        <input type="text" value="${resource.id}" style="display:none" name="resourceId">
    </g:if>
    <g:else>
    <label>Topic</label>
    <g:select name="topic" from="${topics}" optionKey="id" optionValue="name" />
    </g:else>
        <button type="submit" class="btn btn-default">Share</button>

</form><button class="btn btn-default" onclick="exit()">Cancel</button>
     </div>
</div>


    </div>
</body>
</html>