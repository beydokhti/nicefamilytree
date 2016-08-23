
      %{--<richui:tabContent>--}%
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
	           <a href="javascript:display(${s.id});"><span class="person">${s.nickname}</span></a><g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN">(<a href="javascript:showWeddingPanel('${w.id}')">Edit</a>)</g:ifAnyGranted>
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
	      
	      <div class="tab_controls">
	      <g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN">
            <g:if test="${!member.wedding}">
              <span id="linkbuttonAdd" class="yui-button yui-link-button"><em class="first-child"><g:link action="create" params="[spouseId:member.id,gender:member.oppositeGender]">Spouse</g:link></em></span>
            </g:if>
         
            <g:if test="${member.wedding}">
              <span id="linkbuttonAdd" class="yui-button yui-link-button"><em class="first-child"><g:link action="create" params="['parent.id':member.wedding.id,gender:'MALE']">Son</g:link></em></span>
              <span id="linkbuttonAdd" class="yui-button yui-link-button"><em class="first-child"><g:link action="create" params="['parent.id':member.wedding.id,gender:'FEMALE']">Daughter</g:link></em></span>
              <span id="linkbuttonEdit" class="yui-button yui-link-button"><em class="first-child"><a href="javascript:showWeddingPanel('${member.wedding.id}')">Wedding</a></em></span>
            </g:if>
            <g:if test="${member.parent}">
              <span id="linkbuttonAdd" class="yui-button yui-link-button"><em class="first-child"><g:link action="create" params="['parent.id':member.parent.id,gender:'MALE']">Brother</g:link></em></span> 
              <span id="linkbuttonAdd" class="yui-button yui-link-button"><em class="first-child"><g:link action="create" params="['parent.id':member.parent.id,gender:'FEMALE']">Sister</g:link></em></span>          
            </g:if> 
            <span id="linkbuttonEdit" class="yui-button yui-link-button"><em class="first-child"><g:link action="edit" id="${member.id}">Profile</g:link></em></span>   
            <g:if test="${!member.children && !member.root}"><span id="linkbuttonDelete" class="yui-button yui-link-button"><em class="first-child"><a href="javascript:showDeleteDialog('${member.id}','${member.nickname}')">Delete</a></em></span></g:if>   
            <g:if test="${member?.avatar?.length > 0 && member.avatarMime}">
              <span id="linkbuttonReset" class="yui-button yui-link-button"><em class="first-child"><a href="javascript:showResetDialog('${member.id}','${member.nickname}')">Avatar</a></em></span>
            </g:if>                           	      
	      </g:ifAnyGranted>
	      </div>
	      
	    </div>  
	  %{--</richui:tabContent>--}%
