<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dash_head">
    <title>LinkSharing</title>

</head>


<body>
<div class="panel panel-default" align="left">

    <form action="search">

        <input type="search" class="form-control" placeholder="Search" name="search" style="float:right;width: 100px;margin-right: 40px">
        <g:submitButton name="Search" class="btn btn-default" style="float: right"/>

    <div class="panel-heading" >Users
            <select name="sort" style="float:right">
                <option value="all">All Users</option>
                <option value="inactive">InActive</option>
                <option value="active">Active</option>
            </select>
</form>
    </div>

    <div class="panel-body">

        <table class="table table-bordered">
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>FirstName</th>
                <th>LastName</th>
                <th>Username</th>
                <th>Active</th>
                <th>Manage</th>
            </tr>
            <g:each in="${user}" var="users">
                <tr>
                    <td>${users.id}</td>
                    <td>${users.email}</td>
                    <td>${users.firstName}</td>
                    <td>${users.lastName}</td>
                    <td>${users.userName}</td>
                    <td>${users.active}</td>
                    <td><g:if test="${users.active==true}">
                        <g:form controller="user" action="access">
                            <g:hiddenField name="active" value="${users.userName}"/>
                            <g:submitButton name="Deactivate" class="btn btn-primary"/>
                        </g:form>
                    </g:if>
                    <g:elseif test="${users.active==false}">
                        <g:form controller="user" action="access">
                            <g:hiddenField name="active" value="${users.userName}"/>
                            <g:submitButton name="Activate" class="btn btn-info"/>
                        </g:form>
                    </g:elseif>
                    </td>
                </tr>
            </g:each>
        </table>
    </div>
</div>


</body>
</html>