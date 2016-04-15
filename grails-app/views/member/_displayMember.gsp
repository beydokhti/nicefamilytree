
<div class="display_member_parent ${member?.parent || member?.root? 'yesparent':''}">
  <g:if test="${member?.parent}">
    <br>
    <a href="javascript:display('${member?.parent?.mainMember?.id}');">${member?.parent.mainMember.nickname}</a> &amp; 
    <a href="javascript:display('${member?.parent?.spouseMember?.id}');">${member?.parent.spouseMember.nickname}</a>
    <g:if test="${!member.parent.active}">(Inactive)</g:if><br>
    <img src="${createLinkTo(dir:'images',file:'arrow.jpeg')}" alt="arrow" /> 
  </g:if>
  <g:if test="${member?.root}">Family Root <br> <img src="${createLinkTo(dir:'images',file:'arrow.jpeg')}" alt="arrow" /></g:if>
  <g:if test="${!member?.parent && !member?.root}">&nbsp;</g:if>
</div>


<div class="display_member">  
        
<richui:tabView id="tabViewMember">
    <richui:tabLabels>
        <richui:tabLabel selected="true" title="${member.nickname}" />
        <g:if test="${member.spouse}"><richui:tabLabel title="${member.spouse.nickname}" /></g:if>
    </richui:tabLabels>

    <richui:tabContents>
      <richui:tabContent><g:render template="displayMemberContent" model="[member:member]" /></richui:tabContent>
    
    <g:if test="${member.spouse}">
	<richui:tabContent><g:render template="displayMemberContent" model="[member:member.spouse]" /></richui:tabContent>
    </g:if>
    
    </richui:tabContents>
</richui:tabView>
 
 </div>
 
 
 <div class="display_member_children">
   <g:if test="${member.children}"><img src="${createLinkTo(dir:'images',file:'arrow.jpeg')}" alt="arrow" /> <br><br></g:if>
   <g:each in="${member.children}">
     <span class="display_member_child ${it.gender}">
       <a href="javascript:display('${it.id}');">${it.nickname}</a>
     </span>
   </g:each>
 </div>
 
