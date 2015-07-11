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
    <meta name="layout" content="dash_head">

    <script type="text/javascript">
        var findtoppost=function(value){
            var sort=value
            <g:remoteFunction controller="login" action="topPostAjax" update="one" params='{sort:sort}'/>
        }
        var forgotPassword=function()
        {
            window.open("${g.createLink(controller: 'login', action: 'forgot')}",'', 'width=400,height=300');

        }
   </script>

</head>
<body>
<div class="container" style="border:thin; width: 100%">
    <g:if test="${flash.message}">
        <div class="message" role="status" style="color:red;"align="right">${flash.message}</div>
    </g:if>

    <div style="width: 40%;float: left">
    <div class="panel panel-default" style="width: 550px">
                    <div class="panel-heading" align="left">
                        <h3 class="panel-title">Recent Shares</h3>
                    </div>

                 <g:render template="recentShare" model="[resources: resources]"/>

                </div>

                %{----------------------------------------- --}%
                %{--TOP post--}%
                <br/><br/>
        <br/><br/><br/><br/><br/><br/><br/><br/><br/>
        <br/><br/><br/><br/><br/>
                <div class="panel panel-default" style="width: 550px">
                    <div class="panel-heading" >
                        <h3 class="panel-title">Top Posts

                            <select id="sort" style="float: right" name="sort" onchange="findtoppost(value)">
                                <option value="today">Today</option>
                                <option value="week">1 Week</option>
                                <option value="month">1 Month</option>
                                <option value="year">1 Year</option>
                            </select>


                        </h3>
                    </div>
                   <div id="one"> <g:render id="one" template="recentShare" model="[resources: toppost]"/>
                   </div>
                </div>
    </div>



%{--######################################################################################--}%
    <div style="width: 40%;float: right">
    %{-- loginform --------------------}%
        <div class="panel panel-default" style="width: 400px;float:right">
                    <div class="panel-heading">
                        <h3 class="panel-title">Login</h3>
                    </div>


                    <div class="panel-body">


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
                                <td><a href="" onclick="forgotPassword();return false">
                                    Forgot Password</a><td><g:submitButton name="submit"/></td>

                                </tr>

                            </table>
                        </g:form>
                    </div>
                </div>

                %{-----------------------------------------}%

                %{--Register Form----}%
                <div class="panel panel-default" style="width: 400px;float: right">
                    <div class="panel-heading" align="left">
                        <h3 class="panel-title">Register Form</h3>
                    </div>


                    <div class="panel-body">

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
                </div>
</div>
                %{-------------------------------------}%

    <br/>

<br/>
</div>
</body>
</html>