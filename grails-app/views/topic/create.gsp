<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title>Create Topic</title>

    <g:javascript library="jquery"/>
    <script rel="script"  src="${resource(dir: 'js',file: 'bootstrap.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap.min.css')}" >
    <link rel="stylesheet" href="${resource(dir:'css',file: 'bootstrap-theme.min.css')}" >

    <script  type="text/javascript">
        var create=function()
        {
            var name=$('#topicName').val()
            var scope=$('#visibility').val()
            <g:remoteFunction controller="topic" action="save" update="temp" onSuccess="displaymsg()" params="{topicName:name,visibility:scope}" />


        }
        var displaymsg=function()
        { var text = $('#temp').text()
            if(text=="true") {
                $('<span style="color: green;float: right;font-size: medium">Topic Created Successfully</span>')
                        .insertAfter('#divmain')
                        .delay(3000)
                        .fadeOut(function () {
                            $(this).remove();
                        });
            }

            else
            {
                errormsg()
            }
        }
        var errormsg=function()
        {
            $('<span style="color: red;float: right;font-size: medium">Error Occured While Creating.</span>')
                    .insertAfter('#divmain')
                    .delay(3000)
                    .fadeOut(function() {
                        $(this).remove();
                    });


        }

        var exit=function()
        {
            window.close()
        }

    </script>

</head>

<body>
<div >


    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="left" id="msg2">${flash.message}</div>
    </g:if>
    <div class="panel panel-default"  style="margin-top: 10%;width: 100%;float: left" id="divmain">
        <div class="panel-heading">
            <h3 class="panel-title">Create Topic</h3>
        </div>
        <div class="panel-body">
                <table style="width: 100%" align="center"><tr>
                    <td>Topic Name :</td>
                    <td>
                <input type="text" class="form-control" placeholder="Topic Name" name="name" id="topicName" value="${params['name']}">
                    </td></tr>
                    <tr>  <td>   Visibility :</td><td>
                <select class="form-control" name="visibility" id="visibility">
                    <option value="PUBLIC">PUBLIC</option>
                    <option value="PRIVATE">PRIVATE</option>
                </select></td>
                    </tr>

                </table>


<br/>
                 <button type="submit" class="btn btn-default" style="margin-left: 10%" onclick="create()">Share</button>
                <button class="btn btn-default" style="margin-left: 10%" onclick="exit()">Cancel</button>


        </div>
    </div>




</div>
<div id="temp" style="visibility: hidden">aaaaa</div>
</body>
</html>