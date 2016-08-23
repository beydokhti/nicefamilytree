
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



<div style="height:225px;padding: 5px;">
    <img src="<g:avatar member="${member}" />" class="avatar_tab">
    <div class="tab_fullname">${member.name}</div>

    <div class="tab_name">Born: </div> <div class="tab_value"><g:formatDate date="${member.birthDate}" format="MMM dd, yyyy" /> </div>
    <g:if test="${member.deathDate}">
        <div class="tab_name">Died: </div> <div class="tab_value"><g:formatDate date="${member.deathDate}" format="MMM dd, yyyy" /> </div>
    </g:if>
    <g:if test="${member.spouse}">
        <div class="tab_name">Spouse: </div> <div class="tab_value">${member?.spouse?.nickname} </div>
        <div class="tab_name">Wedding: </div> <div class="tab_value"><g:formatDate date="${member?.wedding?.weddingDate}" format="MMM dd, yyyy" /> </div>
    </g:if>

    <g:if test="${member.inactiveWeddings}">
        <div class="tab_name">Prev spouses: </div>
        <div class="tab_value">
            <g:each in="${member?.inactiveWeddings}" var="w">
                <g:set var="s" value="${w.mainMember==member? w.spouseMember:w.mainMember}" />
                <a href="javascript:display(${s.id});"><span class="person">${s.nickname}</span></a>
            </g:each>
        </div>
    </g:if>

    <div class="tab_siblings">
        <g:if test="${member.parent?.children?.size() > 1}">
            <b>Siblings:</b>
            <g:each in="${member.parent?.childrenSorted}">
                <g:if test="${it != member}">
                    <a href="javascript:display(${it.id});"><span class="person">${it.nickname}</span></a>
                </g:if>
            </g:each>
        </g:if>
    </div>

</div>

 
 <div class="display_member_children">
   <g:if test="${member.children}"><img src="${createLinkTo(dir:'images',file:'arrow.jpeg')}" alt="arrow" /> <br><br></g:if>
   <g:each in="${member.children}">
     <span class="display_member_child ${it.gender}">
       <a href="javascript:display('${it.id}');">${it.nickname}</a>
     </span>
   </g:each>
 </div>
 
