<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="rowLayout"/>
    <title>Profile</title>
    <script type="text/javascript">
        function init(){}
        $(".hover").mouseleave(
                function () {
                    $(this).removeClass("hover");
                }
        );
    </script>
</head>

<body>



<figure class="snip1344"><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/331810/profile-sample1.jpg" alt="profile-sample1" class="background"/><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/331810/profile-sample1.jpg" alt="profile-sample1" class="profile"/>
    <figcaption>
        <h3>Besnik Hetemi<span>Straße 7</span><span>12345 Bhaus</span><span>01234567</span><span>mail@mail.com</span></h3>
        <div class="icons"><a href="#"><i class="ion-ios-email-outline"></i></a><a href="#"> <i class="ion-lock-combination"></i></a><a href="#"> <i class="ion-ios-personadd-outline"></i></a></div>
    </figcaption>
</figure>
%{--<div class="row">--}%
    %{--<div class="col-sm-1 alert-warning"></div>--}%
    %{--<div class="col-md-4 alert-warning">--}%
        %{--<br/>--}%
        %{--<div class="row">--}%
            %{--<div class="col-md-2"></div>--}%
            %{--<div class="col-md-10" id="imgMember"><img src="${member.avatar}" width="200px"/> </div>--}%
        %{--</div>--}%
    %{--<div class="row">--}%
        %{--<div class="col-md-3"></div>--}%
        %{--<div class="col-md-9" >--}%
            %{--<g:form controller="member" action="updateAvatar" method="post" enctype="multipart/form-data">--}%
                %{--<input type="hidden" id="memberId" value="${member.id}"/>--}%
                    %{--<g:actionSubmit class="button" value="Update" action="updateAvatar" /><input type='file' id='avatar' name='avatar'/>--}%
           %{--</g:form>--}%
        %{--</div>--}%
    %{--</div>--}%

    %{--<br>--}%
    %{--<div class="row">--}%
        %{--<div class="col-lg-1"></div>--}%
        %{--<div class="col-lg-8" id="name">${member.name}</div>--}%
        %{--<div class="col-lg-3 header"><g:message code="member.display.popup.name"/></div>--}%
    %{--</div>--}%

    %{--<div class="row">--}%
        %{--<div class="col-lg-1"></div>--}%
        %{--<div class="col-lg-8" id="title">${member.title}</div>--}%
        %{--<div class="col-lg-3 header"><g:message code="member.display.popup.title"/></div>--}%
    %{--</div>--}%

    %{--<div class="row">--}%
        %{--<div class="col-lg-1"></div>--}%
        %{--<div class="col-lg-8" id="parents">${member.parentsData}</div>--}%
        %{--<div class="col-lg-3 header"><g:message code="member.display.popup.parent"/></div>--}%
    %{--</div>--}%

    %{--<div class="row">--}%
        %{--<div class="col-lg-1"></div>--}%
        %{--<div class="col-lg-8" id="cibilings">${member.cibilings}</div>--}%
        %{--<div class="col-lg-3 header"><g:message code="member.display.popup.cibiling"/></div>--}%
    %{--</div>--}%

    %{--<div class="row">--}%
        %{--<div class="col-lg-1"></div>--}%
        %{--<div class="col-lg-8" id="spouse">${member.spouseWedding},${member.mainWedding}</div>--}%
        %{--<div class="col-lg-3 header"><g:message code="member.display.popup.spouse"/></div>--}%
    %{--</div>--}%

    %{--<div class="row">--}%
        %{--<div class="col-lg-1"></div>--}%
        %{--<div class="col-lg-8" id="children">${member.spouseChildren},${member.mainChildren}</div>--}%
        %{--<div class="col-lg-3 header"><g:message code="member.display.popup.children"/></div>--}%
    %{--</div>--}%
%{--</div>--}%
%{--</div>--}%
    %{--<div class="col-md-6"></div>--}%
    %{--<div class="col-md-1"></div>--}%

</body>
</html>
