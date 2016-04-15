<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
      <meta name="layout" content="mainInside" />
      <title>Show Member</title>
      <g:javascript library="yui/yahoo-dom-event/yahoo-dom-event" />  
      <g:javascript library="yui/element/element-beta" />  
      <g:javascript library="yui/button/button" />  
      <g:javascript library="yui/container/container" />  
      <g:javascript library="yui/dragdrop/dragdrop" /> 
      <link rel="stylesheet" href="${createLinkTo(dir:'js',file:'yui/fonts/fonts-min.css')}" />
      <link rel="stylesheet" href="${createLinkTo(dir:'js',file:'yui/button/assets/skins/sam/button.css')}" />
      <link rel="stylesheet" href="${createLinkTo(dir:'js',file:'yui/container/assets/skins/sam/container.css')}" />
         
      <script>
        function done(req) {
          if (req.responseText == "true") {
            $('edit_wedding_result').setStyle({color:006600}).update('Updated successfully. <g:link controller="member" action="show" id="${member.id}">Continue</g:link>');
            $('wedding_save_button').addClassName('disabled').disabled = "disabled";
          } else {
            $('edit_wedding_result').setStyle({color:660000}).update('Sorry! ' + req.responseText); 
          }
        }
        
         function memberEditComplete(req) {
          if (req.responseText == "true")
            $('edit_member_result').innerHTML = 'Updated successfully. <g:link controller="member" action="show" id="${member.id}">Continue</g:link>';
            
          
        } 
  
         var weddingPanel;
         var deleteDialog;
         function init() {
	
	       // Define various event handlers for Dialog
	       var handleYes = function() {
	         document.forms.member_form.action = "<g:createLink action="delete" id="${member.id}" />";
		     document.forms.member_form.submit();
		     this.hide();
	       };
	       var handleNo = function() {
		     this.hide();
	       };

            weddingPanel = new YAHOO.widget.Panel("weddingPanel", { width:"425px", visible:false, fixedcenter: true, constraintoviewport:true, draggable:true, modal: true, underlay:false } );
			weddingPanel.render();
         // Instantiate the Dialog
	       deleteDialog = new YAHOO.widget.SimpleDialog("deleteDialog", 
																			 { width: "300px",
																			   fixedcenter: true,
																			   visible: false,
																			   draggable: false,
																			   close: true,
																			   modal: true,
																			   text: "Deleting family member will permanently remove this member from the system.",																			 
																			   constraintoviewport: true,
																			   underlay: false,
																			   buttons: [ { text:"Yes", handler:handleYes },
																						  { text:"No",  handler:handleNo, isDefault:true } ]
																			 } );
	       deleteDialog.setHeader("Do you want really want to delete?");
	       deleteDialog.render();

	       YAHOO.util.Event.addListener("delete_button", "click", deleteDialog.show, deleteDialog, true);
          
		 }

         function showWeddingPanel(id) {
            clearWeddingPanel();
            weddingPanel.show();
            new Ajax.Updater('weddingPanelBody','${request.contextPath}/wedding/edit/'+id,{asynchronous:true,evalScripts:true});
         
         }
         
         function clearWeddingPanel() {
            $('weddingPanelBody').update('<img src="${request.contextPath}/images/rotating_arrow.gif">');
         }
         
                  
         YAHOO.util.Event.addListener(window, "load", init);         
      </script>
   </head>
   <body>
    <div class="body">
      <h1>Show Member</h1>

      <div class="dialog">
                <table>
                    <tbody>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name">Name:</td>
                            
                            <td valign="top" class="value">${member.name}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Nickname:</td>
                            
                            <td valign="top" class="value">${member.nickname}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Birth Date:</td>
                            
                            <td valign="top" class="value"><g:formatDate date="${member?.birthDate}" format="MMMMM dd, yyyy" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Death Date:</td>
                            
                            <td valign="top" class="value"><g:formatDate date="${member?.deathDate}" format="MMMMM dd, yyyy" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Avatar:</td>
                            
                            <td valign="top" class="value">
                              <img src="<g:avatar member="${member}" />">
                            </td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Parent:</td>
                            
                            <td valign="top" class="value">
                               <g:if test="${member?.parent}">
                                 <g:link action="show" id="${member.parent.mainMember.id}"><span class="person">${member.parent.mainMember.nickname}</span></g:link>
                                  &amp;&nbsp;
                                  <g:link action="show" id="${member.parent.spouseMember.id}"><span class="person">${member.parent.spouseMember.nickname}</span></g:link>
                               </g:if>
                               <g:elseif test="${member.root}">Root</g:elseif>
                               
                            </td>
                            
                        </tr>

                        
                        <tr class="prop">
                            <td valign="top" class="name">Siblings:</td>
                            
                            <td valign="top" class="value">
					          <g:if test="${member.parent?.children?.size() > 1}">
						       <g:each in="${member.parent?.childrenSorted}" var="c">
						        <g:if test="${c != member}">
						          <g:link action="show" id="${c.id}"><span class="person">${c.nickname}</span></g:link>
						        </g:if>
						      </g:each>
						      </g:if>                           
                               
                            </td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name">Children:</td>
                            
                            <td valign="top" class="value">
					          
						       <g:each in="${member.children}" var="c">
						        <g:if test="${c != member}">
						          <g:link action="show" id="${c.id}"><span class="person">${c.nickname}</span></g:link>
						        </g:if>
						      </g:each>
						                                
                               
                            </td>
                            
                        </tr>
                                            
                        <tr class="prop">
                            <td valign="top" class="name">Wedding:</td>
                            
                            <td valign="top" class="value">
                              <g:if test="${member.wedding}">
                                Married to <g:link action="show" id="${member.spouse.id}"><span class="person">${member.spouse.nickname}</span></g:link> on <g:formatDate date="${member.wedding.weddingDate}" format="MMMMM dd, yyyy" />
                                 <g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN">
                                <a href="javascript:showWeddingPanel('${member.wedding.id}')">Edit</a> &nbsp;
							      <g:link action="create" params="['parent.id':member.wedding.id,gender:'MALE']">Add son</g:link> &nbsp;
                                   <g:link action="create" params="['parent.id':member.wedding.id,gender:'FEMALE']">Add daughter</g:link>
                                                             
                                   </g:ifAnyGranted>
                              </g:if>
                            </td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Previous marriages:</td>
                            
                            <td valign="top" class="value">
                              <g:if test="${member.inactiveWeddings}">
                          
                                 <g:each in="${member.inactiveWeddings}" var="w">
                                   <g:set var="spouse" value="${w.mainMember.id==member.id? w.spouseMember:w.mainMember}" />
                                   Was married to <g:link action="show" id="${spouse.id}"><span class="person">${spouse.nickname}</span></g:link> on <g:formatDate date="${w.weddingDate}" format="MMMMM dd, yyyy" /> 
                                   <g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN">
                                   <a href="javascript:showWeddingPanel('${w.id}')">Edit</a> &nbsp;
                                   <g:link action="create" params="['parent.id':w.id,gender:'MALE']">Add son</g:link> &nbsp;
                                   <g:link action="create" params="['parent.id':w.id,gender:'FEMALE']">Add daughter</g:link>
                                   </g:ifAnyGranted>
                                   <br>
                                 </g:each>
                              
                                
                              </g:if>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Gender:</td>
                            
                            <td valign="top" class="value">${member.gender}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
      </div>
            
      <p>&nbsp;</p>
        <b>Quick links:</b> 
          <g:if test="${!member.wedding}"><g:link action="create" params="[spouseId:member.id,gender:member.oppositeGender]">Add spouse</g:link> &nbsp;</g:if>
          <g:link action="create" params="[prevSpouseId:member.id,gender:member.oppositeGender]">Add previous spouse</g:link> &nbsp;
          <g:if test="${member.wedding}">
            <g:link action="create" params="['parent.id':member.wedding.id,gender:'MALE']">Add son</g:link> &nbsp;
            <g:link action="create" params="['parent.id':member.wedding.id,gender:'FEMALE']">Add daughter</g:link>
          </g:if>
          <g:if test="${member.parent}">
            <g:link action="create" params="['parent.id':member.parent.id,gender:'MALE']">Add brother</g:link> &nbsp;
            <g:link action="create" params="['parent.id':member.parent.id,gender:'FEMALE']">Add sister</g:link>          
          </g:if>
          <p>&nbsp;</p>     
      <g:form controller="member id="${member?.id}"  name="member_form">
                   
                    <g:actionSubmit class="button" value="Display" />
                    <g:ifAnyGranted role="ROLE_MANAGER,ROLE_ADMIN">
                    <g:actionSubmit class="button" value="New member" action="create" />
                   <g:actionSubmit class="button" value="Edit" />

                   <g:if test="${member?.avatar?.length > 0 && member.avatarMime}">
                     <g:actionSubmit class="button" value="Reset Avatar" onclick="return confirm('This will reset your avatar to default image. Do you want to continue?');" />
                   </g:if>
                   <g:else>
                     <input type="button" class="button disabled" disabled="disabled" value="Reset Avatar" />
                   </g:else>
                   
                    <g:if test="${member.weddings}">
                      <input type="button" class="button disabled" disabled="disabled" value="Delete">
                    </g:if>
                    <g:else>
                      <input type="button" class="button" name="_action_Delete" id="delete_button" value="Delete" />
                    </g:else>
                     </g:ifAnyGranted>
      </g:form>

    <div id="deleteDialog"></div>
        
     <div id="weddingPanel" style="visibility:hidden;text-align:left">
		<div class="hd">Manage Wedding</div>
		<div class="bd" id="weddingPanelBody">&nbsp;</div>
	</div>

     
	</div>
		
     </div>   
      
    </body>
</html>
