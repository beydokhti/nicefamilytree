<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="layout" content="rowLayout"/>
    <title>Display a form in a lightbox</title>
    <style>
    #overlay{
        display: block;
        position: fixed;
        top: 0%;
        left: 0%;
        width: 100%;
        height: 100%;
        background-color: black;
        z-index:1001;
        -moz-opacity: 0.8;
        opacity:.80;
        filter: alpha(opacity=80);
    }

    #popup{
        display: none;
        position: absolute;
        top: 25%;
        width: 500px;
        height: 500px;
        padding: 16px;
        border: 16px solid orange;
        background-color: white;
        z-index:1002;
        overflow: auto;
    }
    </style>
</head>

<body>
<div id="popup">
    <h2>Newsletter</h2>

        <p><input id="close" onclick="closePopup" /></p>

</div>

<button onclick="showPopup">Clear Cookie</button>

<script>
    jQuery.fn.center = function () {
        this.css("position","absolute");
        this.css("top", ( $(window).height() - this.height() ) / 2+$(window).scrollTop() + "px");
        this.css("left", ( $(window).width() - this.width() ) / 2+$(window).scrollLeft() + "px");
        return this;
    }

    function closePopup(){
        $("#popup, #overlay").hide();
        $.cookie("popup", "displayed", { expires: 7 });
    };


    $("button").on("click", function(){
        $("<div>",{ id : "overlay" }).insertBefore("#popup");
        $("#popup").show().center();
    });
</script>
<div class="container">
<div class="row">
    <div class="col-lg-10">test</div>
    <div class="col-lg-1">test</div>
    <div class="col-lg-1">test</div>
</div></div>
</body>
</html>