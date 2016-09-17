<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="rowLayout"/>
    <title>Profile</title>
    <link href="${resource(dir:"/css",file:"profile.css")}" rel="stylesheet">
</head>

<body>
<script type="text/javascript">
    function init(){}
    jQuery(document).ready(function() {
        jQuery(".btn-pref .btn").click(function () {
            jQuery(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default");
            // $(".tab").addClass("active"); // instead of this do the below
            jQuery(this).removeClass("btn-default").addClass("btn-primary");
            var id=jQuery(this).attr('href');
            jQuery('.tab-pane').removeClass("active")
            jQuery(id).addClass("active");
        });
    });
</script>
<div class="col-lg-2"></div>
<div class="col-lg-8">
    <div class="card hovercard">
        %{--<div class="card-background">--}%
            %{--<img class="card-bkimg" alt="" src="http://lorempixel.com/100/100/people/9/">--}%
            %{--<!-- http://lorempixel.com/850/280/people/9/ -->--}%
        %{--</div>--}%
        <div class="useravatar">
            %{--<img alt="" src="http://lorempixel.com/100/100/people/9/">--}%
            <img alt="" src="${member.avatar}">

        </div>
        <div class="card-info"> <span class="card-title">${member.name}</span>

        </div>
    </div>
    <div class="btn-pref btn-group btn-group-justified btn-group-lg" role="group" aria-label="...">
        <div class="btn-group" role="group">
            <button type="button" id="stars" class="btn btn-default" href="#tab1" data-toggle="tab" ><span class="glyphicon glyphicon-star" aria-hidden="true"></span>
                <div class="hidden-xs">Posts</div>
            </button>
        </div>
        <div class="btn-group" role="group">
            <button type="button" id="favorites" class="btn btn-default" href="#tab2" data-toggle="tab" ><span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
                <div class="hidden-xs">About</div>
            </button>
        </div>
        <div class="btn-group" role="group">
            <button type="button" id="following" class="btn btn-primary" href="#tab3" data-toggle="tab" ><span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                <div class="hidden-xs">Family Information</div>
            </button>
        </div>
    </div>


    <div class="well tab-container">
        <div class="tab-content">
            <div class="tab-pane fade in " id="tab1">
                <h3>This is tab 1</h3>
            </div>
            <div class="tab-pane fade in" id="tab2">
                <h3>This is tab 2</h3>
            </div>
            <div class="tab-pane fade in active" id="tab3">

                <div class="row">
                    <div class="col-lg-1"></div>

                    <div class="col-lg-6" id="title">${member.title}</div>

                    <div class="col-lg-3 header" style="font-size: 16pt"><g:message code="member.display.popup.title"/></div>

                    <div class="col-lg-1"></div>
                </div>

                <div class="row">
                    <div class="col-lg-1"></div>

                    <div class="col-lg-6" id="parents">${member.parentsData}</div>

                    <div class="col-lg-3 header" style="font-size: 16pt"><g:message code="member.display.popup.parent"/></div>

                    <div class="col-lg-1"></div>
                </div>


                <div class="row">
                    <div class="col-lg-1"></div>

                    <div class="col-lg-6" id="cibilings">${member.cibilings}</div>

                    <div class="col-lg-3 header" style="font-size: 16pt"><g:message code="member.display.popup.cibiling"/></div>

                    <div class="col-lg-1"></div>
                </div>

                <div class="row">
                    <div class="col-lg-1"></div>

                    <div class="col-lg-6" id="spouse"></div>

                    <div class="col-lg-3 header" style="font-size: 16pt"><g:message code="member.display.popup.spouse"/></div>

                    <div class="col-lg-1"></div>
                </div>


                <div class="row">
                    <div class="col-lg-1"></div>

                    <div class="col-lg-6" id="children"></div>

                    <div class="col-lg-3 header" style="font-size: 16pt"><g:message code="member.display.popup.children"/></div>

                    <div class="col-lg-1"></div>
                </div>

            </div>
        </div>
    </div>

</div>
<div class="col-lg-2"></div>
</body>
</html>
