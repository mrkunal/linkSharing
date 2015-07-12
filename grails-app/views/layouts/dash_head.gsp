<!DOCTYPE html>
<html>
<head>
    <title><g:layoutTitle default="Dashboard"/></title>

    %{--<!-- Latest compiled and minified CSS -->--}%
    %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">--}%

    %{--<!-- Optional theme -->--}%
    %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">--}%

    %{--<!-- Latest compiled and minified JavaScript -->--}%
    %{--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>--}%
    <link rel="shortcut icon" href="${assetPath(src: 'icon1.ico')}" type="image/x-icon">

    <g:javascript library="jquery"/>
    <script rel="script" src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-theme.min.css')}">
    <g:layoutHead/>
    <script type="text/javascript">
        var createTopic = function () {
            window.open("${g.createLink(controller: 'topic', action: 'create')}", '', 'width=500,height=300');

        }
        var createDocumentResource = function () {
            window.open("${g.createLink(controller: 'documentResource', action: 'create')}", '', 'width=500,height=400');

        }

        var createLinkResource = function () {
            window.open("${g.createLink(controller: 'linkResource', action: 'create')}", '', 'width=500,height=400');

        }
        var sendInvitation = function (val) {
            window.open("${g.createLink(controller: 'home', action: 'invitation')}?topicId="+val+"", '', 'width=400,height=300');

        }

    </script>
</head>

<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

            <g:if test="${session['userName']}">
                <g:link class="navbar-brand" controller="home" action="dashboard">Link Sharing Application</g:link>
            </g:if>
            <g:else>
                <g:link class="navbar-brand" controller="login" action="index">Link Sharing Application</g:link>
            </g:else>

        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

            <ul class="nav navbar-nav navbar-right">
                <g:form class="navbar-form navbar-left" role="search" action="find" controller="search">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search" name="search" value="${params['search']}">
                    </div>
                    <button type="submit" class="btn btn-default">Search</button>
                </g:form>
        <g:if test="${session['userName']}">

            <li><a href="" onclick="createTopic();
                return false">
                    <span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
                </a></li>

                <li><a href="" onclick="sendInvitation();
                return false">
                    <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                </a></li>
                <li><a href="" onclick="createLinkResource();
                return false">
                    <span class="glyphicon glyphicon-paperclip" aria-hidden="true"></span>
                </a></li>
                <li><a href="" onclick="createDocumentResource();
                return false">
                    <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
                </a></li>

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                       aria-expanded="false"><span class="glyphicon glyphicon-user"
                                                   aria-hidden="true"></span> ${session.userName}<span
                            class="caret"></span></a>
                    <ul class="dropdown-menu">

                        <li><g:link controller="user" action="profile">Profile</g:link></li>
                        <g:if test="${session['admin']}">
                            <li role="separator" class="divider"></li>
                            <li><g:link controller="user" action="list">Users</g:link></li>
                            <li><g:link controller="topic" action="list"
                                        params="[uid: null, operation: null]">Topics</g:link></li>
                            <li><g:link>Posts</g:link></li>
                            <li role="separator" class="divider"></li>

                        </g:if>
                        <li><g:link controller="home" action="logout">Logout</g:link></li>

                    </ul>
                </li>
        </g:if>
            </ul>
        </div><!-- /.navbar-collapse -->

    </div><!-- /.container-fluid -->
</nav>

<div>
    <span id="msg" style="color: green;float:right;font-size: medium"></span>
    <br/><br/>

    <g:layoutBody/>
</div>
</body>
</html>
