<!DOCTYPE html>
<html lang="en">

<head>
	<meta name="layout" content="main"/>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">

	<title>FamilyTree</title>

	<!-- Bootstrap Core CSS -->
	<link href="css/bootstrap.min.css" rel="stylesheet">

	<!-- Custom CSS -->
	<link href="css/agency.css" rel="stylesheet">

	<!-- Custom Fonts -->
	<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
	<link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
	<g:javascript library="jquery" plugin="jquery"/>

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script type="text/javascript" src="${resource(dir:'/assets/js',file:'go.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'/assets/js/',file:'goSamples.js')}"></script>

</head>

<body id="page-top" class="index">

<!-- Navigation -->
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header page-scroll">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand page-scroll" href="#page-top">Your Family Tree</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<li class="hidden">
					<a href="#page-top"></a>
				</li>
				<li>
					<a class="page-scroll" href="#services">Family Tree</a>
				</li>
				<li>
					<a class="page-scroll" href="#login">Login</a>
				</li>
				<li>
					<a class="page-scroll" href="#topNews">Top News</a>
				</li>
				<li>
					<a class="page-scroll" href="#announcement">Announcement</a>
				</li>

			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>

<!-- Header -->
<header>
	<div class="container">
		<div class="intro-text">
			<div class="intro-lead-in">Welcome To Your Family Tree Page!</div>
			<div class="intro-heading">It's Nice To Meet You</div>
			<a href="#services" class="page-scroll btn btn-xl">Show Me!</a>
		</div>
	</div>
</header>

<!-- Services Section -->
<section id="services">
	<div class="container">
		<div class="row text-center">

			<g:render template="/common/familyTreeChart"/>
		</div>
	</div>
</section>

<!-- login Grid Section -->
<section id="login" class="bg-light-gray">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<h2 class="section-heading">login</h2>
				<h3 class="section-subheading text-muted">Login to edit profile and send mesasge.</h3>
			</div>
		</div>
		<div class="row">
		</div>
	</div>
</section>

<!-- Top News Section -->
<section id="topNews">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<h2 class="section-heading">Top News</h2>
				<h3 class="section-subheading text-muted">Find Hot News.</h3>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<ul class="timeline">
					<li>
						<div class="timeline-image">
							<img class="img-circle img-responsive" src="img/about/1.jpg" alt="">
						</div>
						<div class="timeline-panel">
							<div class="timeline-heading">
								<h4>2009-2011</h4>
								<h4 class="subheading">Our Humble Beginnings</h4>
							</div>
							<div class="timeline-body">
								<p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt ut voluptatum eius sapiente, totam reiciendis temporibus qui quibusdam, recusandae sit vero unde, sed, incidunt et ea quo dolore laudantium consectetur!</p>
							</div>
						</div>
					</li>
					<li class="timeline-inverted">
						<div class="timeline-image">
							<img class="img-circle img-responsive" src="img/about/2.jpg" alt="">
						</div>
						<div class="timeline-panel">
							<div class="timeline-heading">
								<h4>March 2011</h4>
								<h4 class="subheading">An Agency is Born</h4>
							</div>
							<div class="timeline-body">
								<p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt ut voluptatum eius sapiente, totam reiciendis temporibus qui quibusdam, recusandae sit vero unde, sed, incidunt et ea quo dolore laudantium consectetur!</p>
							</div>
						</div>
					</li>
					<li>
						<div class="timeline-image">
							<img class="img-circle img-responsive" src="img/about/3.jpg" alt="">
						</div>
						<div class="timeline-panel">
							<div class="timeline-heading">
								<h4>December 2012</h4>
								<h4 class="subheading">Transition to Full Service</h4>
							</div>
							<div class="timeline-body">
								<p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt ut voluptatum eius sapiente, totam reiciendis temporibus qui quibusdam, recusandae sit vero unde, sed, incidunt et ea quo dolore laudantium consectetur!</p>
							</div>
						</div>
					</li>
					<li class="timeline-inverted">
						<div class="timeline-image">
							<img class="img-circle img-responsive" src="img/about/4.jpg" alt="">
						</div>
						<div class="timeline-panel">
							<div class="timeline-heading">
								<h4>July 2014</h4>
								<h4 class="subheading">Phase Two Expansion</h4>
							</div>
							<div class="timeline-body">
								<p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt ut voluptatum eius sapiente, totam reiciendis temporibus qui quibusdam, recusandae sit vero unde, sed, incidunt et ea quo dolore laudantium consectetur!</p>
							</div>
						</div>
					</li>
					<li class="timeline-inverted">
						<div class="timeline-image">
							<h4>Be Part
								<br>Of Our
								<br>Story!</h4>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</section>

<!-- Announcement Section -->
<section id="announcement" class="bg-light-gray">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<h2 class="section-heading">Announcement</h2>
				<h3 class="section-subheading text-muted">announce event.</h3>
			</div>
		</div>
	</div>
</section>


<footer>
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<span class="copyright">Copyright &copy; Your Website 2016</span>
			</div>
			<div class="col-md-4">
				<ul class="list-inline social-buttons">
					<li><a href="#"><i class="fa fa-twitter"></i></a>
					</li>
					<li><a href="#"><i class="fa fa-facebook"></i></a>
					</li>
					<li><a href="#"><i class="fa fa-linkedin"></i></a>
					</li>
				</ul>
			</div>
			<div class="col-md-4">
				<ul class="list-inline quicklinks">
					<li><a href="#">Privacy Policy</a>
					</li>
					<li><a href="#">Terms of Use</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</footer>

<!-- jQuery -->
%{--<script src="js/jquery.js"></script>--}%

<!-- Bootstrap Core JavaScript -->
<script src="js/bootstrap.min.js"></script>

<!-- Plugin JavaScript -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<script src="js/classie.js"></script>
<script src="js/cbpAnimatedHeader.js"></script>

<!-- Contact Form JavaScript -->
<script src="js/jqBootstrapValidation.js"></script>
<script src="js/contact_me.js"></script>

<!-- Custom Theme JavaScript -->
<script src="js/agency.js"></script>



</body>

</html>
