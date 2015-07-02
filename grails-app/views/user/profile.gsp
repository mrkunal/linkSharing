<%--
  Created by IntelliJ IDEA.
  User: ubuntu
  Date: 28/6/15
  Time: 8:53 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="dash_head">
    <title>LinkSharing</title>



</head>

<body>
<div style="width: 100%;margin-top: 5%"  >
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>


<div style="width:40%;float: left" >
    <g:render template="/home/info" model="[user:user,topic_total:topic_total,subscription_total:subscription_total]"/>
</div>

    <div style="width:50%;float:right;margin-right: 10%">

        <div class="panel panel-default" style="width: 400px;float: right">
            <div class="panel-heading" align="left">
                <h3 class="panel-title">Profile</h3>
            </div>


            <div class="panel-body">
                <g:uploadForm url="[controller:'user',action: 'updateInfo']">

                    <table >
                        <tr>
                            <td> First Name:</td><td> <g:field type="text" name="firstName" value="${user.firstName}"/> </td>
            </tr>
                    <tr>
                        <td> Last Name:</td><td> <g:field type="text" name="lastName" value="${user.lastName}"/> </td>
                    </tr>

                    <tr>
                        <td> User Name:</td><td> <g:field type="text" name="userName" value="${user.userName}"/> </td>
                    </tr>

                    <td>Photo :</td>
                    <td> <input type="file" name="pic"/></td>
                    </tr>

                    <tr>

                        <td><g:submitButton name="update"/></td>

                    </tr>

                    </table>


                </g:uploadForm>
            </div>
        </div>

        <div class="panel panel-default" style="width: 400px;float: right">
            <div class="panel-heading" align="left">
                <h3 class="panel-title">Change Password</h3>
            </div>


            <div class="panel-body">
                <g:uploadForm url="[controller:'user',action: 'changePassword']">

                    <table >
                        <tr>
                            <td> Password:</td><td> <g:field type="password" name="password" /> </td>
                        </tr>
                        <tr>
                            <td> Confirm Password:</td><td> <g:field type="password" name="confirmPassword"/> </td>
                        </tr>

                        <tr>

                            <td><g:submitButton name="Update"/></td>

                        </tr>

                    </table>


                </g:uploadForm>
            </div>
        </div>


    </div>




</div>
</body>
</html>