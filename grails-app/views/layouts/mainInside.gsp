<head>
    %{--<meta name="layout" content="main"/>--}%

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>FamilyTree</title>

    <!-- Bootstrap Core CSS -->
    %{--<link href="/css/bootstrap.min.css" rel="stylesheet">--}%
    <link href="${resource(dir:"/css",file: "bootstrap.min.css")}"rel="stylesheet">

    <!-- Custom CSS -->
    %{--<link href="/css/agency.css" rel="stylesheet">--}%
    <link href="${resource(dir:"/css",file: "agency.css")}"rel="stylesheet">
    <!-- Custom Fonts -->
    %{--<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">--}%
    <link href="${resource(dir:"/font-awesome/css",file: "font-awesome.min.css")}"rel="stylesheet">

    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <g:javascript library="jquery" plugin="jquery"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript" src="${resource(dir:"/js/prototype",file: "prototype.js")}"></script>
<script type="text/javascript" src="${resource(dir:"/js/prototype",file: "scriptaculous.js")}"></script>
    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body>
<nav class="navbar navbar-default navbar-fixed-top navbar-shrink">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll">
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
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li>
                        <g:link controller="member" action="display">Display Member</g:link>
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
