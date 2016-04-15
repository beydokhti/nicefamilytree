<%@ page import="com.mano.familytree.data.Gender" %>      

<div class="member_form">

   <div class="member_item">
      <div class="member_title">General Details</div>
      <div class="member_details">Lets start with few basic information needed</div>
      
      <div class="member_name">Name:</div>
      <div class="member_value ${hasErrors(bean:member,field:'name','errors')}">
        <input type="text" id='name' name='name' value="${fieldValue(bean:member,field:'name')}"/>
        <span class="required">*</span>
      </div>

      <div class="member_name">Nickname:</div>
      <div class="member_value ${hasErrors(bean:member,field:'nickname','errors')}">
        <input type="text" id='nickname' name='nickname' value="${fieldValue(bean:member,field:'nickname')}"/>
        <span class="required">*</span>
      </div>

      <div class="member_name">Birth Date:</div>
      <div class="member_value ${hasErrors(bean:member,field:'birthDate','errors')}">
         <g:datePicker name='birthDate' value="${member?.birthDate}" precision="day" default="none" noSelection="['':'']" years="${1700..2015}"></g:datePicker>
         <span class="required">*</span>
      </div>

      <div class="member_name">Death Date:</div>
      <div class="member_value ${hasErrors(bean:member,field:'deathDate','errors')}">
         <g:datePicker name='deathDate' value="${member?.deathDate}" precision="day" default="none" noSelection="['':'']" years="${1700..2015}"></g:datePicker>
      </div>

      <div class="member_name">Gender:</div>
      <div class="member_value ${hasErrors(bean:member,field:'gender','errors')}">
         <g:select id='gender' name='gender' value="${fieldValue(bean:member,field:'gender')}" from="${Gender.values()}" noSelection="['':'-Choose-']" onchange="genderChanged(this.value)"/>
         <span class="required">*</span>
      </div>
                              
   </div>
  
   <div class="member_item">
      <div class="member_title">Now, tell us how you are related to this family</div>
      <div class="member_details">Complete one of the two sections below. To be added to this family, either your parent or your spouse must be a family member</div>
      <div class="half ${hasErrors(bean:member,field:'parent','errors')}" style="clear:left">
        <p>My parent is a family member:</p>
        <g:if test="${member.root}">Family Root<input type="hidden" name="parent.id" value="0"></g:if>
        <g:else><g:select id='parent' name='parent.id' value="${member.parent?.id}" from="${eligibleParentList}" optionKey="id"  noSelection="['-1':'-Choose-']"/></g:else>
      </div>
      <g:if test="${spouseDetails}">
      <div class="half ${hasErrors(bean:member,field:'parent','errors')}" style="border-left:2px solid #000;">
        <p>My spouse is a family member</p>
        
        <g:radio name="activeFlag" id="activeFlag" value="true" checked="${params.activeFlag}" onclick="showSpouseList(true)" /> I'm married to:  
        <g:select name="spouseId" id="spouseId" value="${params.spouseId}" from="${eligibleSpouseList}" optionKey="id" optionValue="nickname" noSelection="['0':'-Choose-']" />
        <br>
        
        <g:radio name="activeFlag" id="inActiveFlag" value="" checked="${!params.activeFlag}" onclick="showSpouseList(false)"  /> I was married to:  
        <g:select name="prevSpouseId" id="prevSpouseId" value="${params.prevSpouseId}" from="${previousSpouseList}" optionKey="id" optionValue="nickname" noSelection="['0':'-Choose-']" />
        <p>&nbsp;</p>
                                   
        Wedding date:<br>
        <g:datePicker name="weddingDate" precision="day" value="${wedding?.weddingDate}" years="${1700..2015}"/>
      </div>
      </g:if>
   </div>

   <div class="member_item">
      <div class="member_title">How about adding your picture (Optional)</div>
      <div class="member_details">This step is optional. You can always add or change your avatar anytime. 
      Please limit your image size to 50K. Your avatar will be resized to 130px x 130px.</div>
      <div class="member_name">Avatar:</div>
      <div class="member_value ${hasErrors(bean:member,field:'avatar','errors')}">
        <input type='file' id='avatar' name='avatar' />
      </div>
   </div>
        
</div>

<div style="height:10px;clear:both">&nbsp;</div>

              