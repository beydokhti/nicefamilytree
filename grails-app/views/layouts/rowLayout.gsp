<head>
    %{--<meta name="layout" content="main"/>--}%

    <title>FamilyTree</title>

    <!-- Bootstrap Core CSS -->
        <link href="${resource(dir:"/css",file: "bootstrap.css")}"rel="stylesheet">

    <!-- Custom CSS -->
        <link href="${resource(dir:"/css",file: "agency.css")}"rel="stylesheet">
        <link href="${resource(dir:"/css",file: "main.css")}"rel="stylesheet">
    <!-- Custom Fonts -->
        <link href="${resource(dir:"/font-awesome/css",file: "font-awesome.min.css")}"rel="stylesheet">

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet'
          %{--type='text/css'>--}%
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <g:javascript library="jquery" plugin="jquery"/>
    <script type="text/javascript" src="${resource(dir:'/assets/js',file:'go.js')}"></script>
    <script type="text/javascript" src="${resource(dir:'/assets/js/',file:'goSamples.js')}"></script>


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    %{--<script type="text/javascript" src="${resource(dir:"/js/prototype",file: "prototype.js")}"></script>--}%
    %{--<script type="text/javascript" src="${resource(dir:"/js/prototype",file: "scriptaculous.js")}"></script>--}%
    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body onload="init()">
<nav class="navbar navbar-default navbar-fixed-top navbar-shrink" style="position: inherit !important;margin-bottom: 25px !important" >
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll" style="position: relative !important;height: 80px">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="navbar-brand page-scroll">Your Family Tree</div>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
            %{--<li class="hidden">--}%
            %{--<a href="#page-top"></a>--}%
            %{--</li>--}%
            %{--<sec:ifAllGranted roles="ROLE_ADMIN">--}%
            %{--<li>--}%
            %{--<g:link controller="" action="">Create Member</g:link>--}%
            %{--</li>--}%
            %{--</sec:ifAllGranted>--}%
                <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_USER">
                    <li>
                        <g:link controller="member" action="display">Display Member</g:link>
                    </li>
                </sec:ifAnyGranted>
                <sec:ifAllGranted roles="ROLE_USER">
                    <li>
                        <g:link controller="member" action="profile">Profile</g:link>
                    </li>
                </sec:ifAllGranted>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li>
                        <g:link controller="member" action="create">Create Member</g:link>
                    </li>
                </sec:ifAllGranted>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li>
                        <g:link controller="member" action="userCreate">Create User</g:link>
                    </li>
                </sec:ifAllGranted>
                <li>
                    <g:link controller="logout" action="index">Logout</g:link>
                </li>

            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>

<g:layoutBody/>
<r:layoutResources/>
</body>
</html>
