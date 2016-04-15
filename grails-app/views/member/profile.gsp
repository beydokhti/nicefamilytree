<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainInside"/>
    <title>Profile</title>

</head>

<body>

<g:if test="${member}"><g:render template="displayMember" model="[member: member]"/></g:if>

<g:form controller="people" action="updateAvatar" method="post" enctype="multipart/form-data">
    <div class="body">
        <div class="member_form_nf">
            <div class="member_item">
                <div class="member_title">Add your picture</div>

                <div class="member_details">This step is optional. You can always add or change your avatar anytime.
                Please limit your image size to 50K. Your avatar will be resized to 130px x 130px.</div>

                <div class="member_name">Picture:
                    <div class="member_value ${hasErrors(bean: member, field: 'avatar', 'errors')}">
                        <input type='file' id='avatar' name='avatar'/>
                    <g:actionSubmit class="button" value="Update" action="updateAvatar" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</g:form>
</body>
</html>
