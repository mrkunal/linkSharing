<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dash_head">
    <title>LinkSharing</title>

</head>


<div>
<div class="panel panel-default" align="left">

    <form action="list">
        <g:submitButton name="Search" class="btn btn-default" style="float: right;margin-right: 40px"/>

        <input type="search" class="form-control" placeholder="Search" name="search" style="float:right;width: 100px;margin-right: 40px">
    <div class="panel-heading" >Users

        <select name="sort" style="float:right;margin-right: 50px">
                <option value="all">All Users</option>
                <option value="inactive">InActive</option>
                <option value="active">Active</option>
            </select></div>
</form>
    </div>

    <div class="panel-body">

        <g:render template="userList" model="[user:user]"/>
    </div>



</div>


</body>
</html>