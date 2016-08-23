<%--
  Created by IntelliJ IDEA.
  User: MaryJoOon
  Date: 8/19/2016
  Time: 2:11 PM
--%>

<%@ page import="nicefamilytree.FamilyMember" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Nice Family Tree</title>
    <meta name="layout" content="rowLayout"/>
    <g:javascript src="go.js"/>
    <link href="../assets/css/goSamples.css" rel="stylesheet" type="text/css"/>  <!-- you don't need to use this -->

</head>

<body>
<script type="text/javascript">
    jQuery(document).ready(function() {
        jQuery("#search").click(function () {
            if( jQuery("#searchText").val()!=undefined && jQuery("#searchText").val()!=""){
                jQuery.ajax({
                    url: '<g:createLink action="searchAjax"/>',
                    data: {searchText: $("#searchText").val()},
                    type: "POST",
                    success: function (response) {
                        if (response.username != undefined) {
                            jQuery("#username").val(response.username)
                            jQuery("#password").val(response.password)
                            jQuery("#memberId").val(response.memberId)
                            jQuery("#message").html("");
                        } else if (response.error != undefined) {
                            jQuery("#message").html("Error:" + response.error);
                        } else {
                            jQuery("#message").html("No result");
                        }
                    },
                    error: function () {
                        $("#message").html("Error");
                    }
                })
            }
        })
        $("#createUser").click(function () {
            if ($("#username").val()!="" && $("#username").val()!=undefined  &&
                    $("#password").val()!="" && $("#password").val()!=undefined &&
                    $("#memberId").val()!="" && $("#memberId").val()!=undefined
            ) {
                jQuery.ajax({
                    url: '<g:createLink action="createUserAjax"/>',
                    data: {
                        username: $("#username").val(),
                        password: $("#password").val(),
                        memberId: $("#memberId").val()
                    },
                    type: "POST",
                    success: function (response) {
                        if (response.status != undefined) {
                            $("#message").html(response.status);
                        } else {
                            $("#message").html("Error status" );
                        }
                    },
                    error: function () {
                        $("#message").html("Error");
                    }
                })
            }
        })
    })
    function init(){}
</script>
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-10">

        <g:form>
            <div class="row">
                <div class="col-md-2"><input type="text" id="searchText"/></div>
                <div class="col-md-2"><input type='button' id="search" class="btn btn-sm" value='Search'></div>
            </div>
            <br/>
            <div id="message"></div>
            <br/>
            <br/>
            <div class="row">
                <div class="col-md-2">UserName</div>
                <div class="col-md-6">
                    <input type="text" id="username">
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">Password</div>
                <div class="col-md-6">
                    <input type="text" id="password">
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">Member</div>
                <div class="col-md-6">
                    <g:select name="memberId" from="${nicefamilytree.FamilyMember.list()}" noSelection="['':'choose one']" optionKey="id"/>
                </div>
            </div>
            <br/>
            <br/>
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-4">
                    <input type='button' id="createUser" class="btn btn-sm" value='Save'>
                </div>
            </div>
        </g:form>

    </div>
</div>
</body>
</html>