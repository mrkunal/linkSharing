<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:javascript library="jquery"/>
    <script rel="script" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-theme.min.css')}">
    <title>Document Create</title>

    <script type="text/javascript">

        var exit = function () {
            window.close()
        }

    </script>

</head>


<body>
<div>
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;" align="right">${flash.message}</div>
    </g:if>

    <div class="panel panel-default" align="left">
        <div class="panel-heading">
            <h3 class="panel-title">Share Document</h3>
        </div>

        <div class="panel-body">
            <g:uploadForm controller="documentResource" action="save">
                <div class="form-group">
                    <label for="file">Document</label>
                    <input type="file" id="file" name="file">

                    <p class="help-block">Upload Document you want to Share.</p>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <g:if test="${resource}">
                        <textarea class="form-control" rows="5" id="description" name="description"
                                  placeholder="Description">${resource.description}
                        </textarea>
                    </g:if>
                    <g:else>
                        <textarea class="form-control" rows="5" id="description" name="description"
                                  placeholder="Description">
                        </textarea>

                    </g:else>
                </div>


                <g:if test="${resource}">
                    <input style="display:none" value="${resource.id}" name="resourceId">
                </g:if>
                <g:else>
                    <label>Topic</label>
                    <g:select name="topic" from="${topics}" optionKey="id" optionValue="name"/>
                </g:else>
                <button type="submit" class="btn btn-default">Share</button>

            </g:uploadForm><button class="btn btn-default" onclick="exit()">Cancel</button>
        </div>
    </div>

</div>
</body>
</html>