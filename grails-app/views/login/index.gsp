<%--
  Created by IntelliJ IDEA.
  User: ubuntu
  Date: 14/6/15
  Time: 7:56 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Main Page</title>


</head>
<body>

<div>
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>
    <h3>Recent Shares</h3>
    <g:render template="recentShare" model="[resources: resources]"/>
<div style="border: solid; border-color: lightgrey ;width:450px;float:right">
    <g:form url="[controller:'login',action:'loginHandler']">
        <table >
<caption> LogIn Form</caption>
 <br/>
            <tr>
                <td> Email:</td><td> <g:field type="email" name="email"/> </td>
            </tr>
            <tr>
                <td>Password:</td><td><g:field type="password" name="password"/></td>
            </tr>
            <tr>
                <td><g:link action="forgot"> Forgot Password</g:link><td><g:submitButton name="submit"/></td>

            </tr>

        </table>
    </g:form>

    <br/>
    <g:uploadForm url="[controller:'login',action: 'register']">

        <table > <caption> Register Form</caption>
            <tr>
                <td> First Name:</td><td> <g:field type="text" name="firstName"/> </td>
            </tr>
            <tr>
                <td> Last Name:</td><td> <g:field type="text" name="lastName"/> </td>
            </tr>

            <tr>
                <td> Email:</td><td> <g:field type="email" name="email"/> </td>
            </tr>

            <tr>
                <td> User Name:</td><td> <g:field type="text" name="userName"/> </td>
            </tr>

            <tr>
                <td>Password:</td><td><g:field type="password" name="password"/></td>
            </tr>

            <tr>
                <td>Confirm Password:</td><td><g:field type="password" name="confirmPassword"/></td>
            </tr>

            <td>Photo :</td>
                <td> <input type="file" name="pic"/></td>
           </tr>

            <tr>

                <td><g:submitButton name="submit"/></td>

            </tr>

        </table>


    </g:uploadForm>


</div>

<div style="margin-top: 27%">
    <h3>Top Posts</h3>
    %{--${toppost.description}--}%
    %{--${toppost}--}%
    %{--<g:render template="topPost" model="[toppost: toppost]"/>--}%
</div>
</div>

</body>
</html>