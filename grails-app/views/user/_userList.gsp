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