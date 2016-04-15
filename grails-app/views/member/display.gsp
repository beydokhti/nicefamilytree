<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
      <meta name="layout" content="test" />
      <title>Display Member</title>
      <resource:treeView />
      <resource:tabView />
      <resource:autoComplete skin="default"/>
      <g:javascript library="${resource(dir:'/js/yui/yahoo-dom-event',file:'yahoo-dom-event.js')}" />
      <g:javascript library="/js/yui/element/element-beta" />
      <g:javascript library="${resource(dir:'/yui/button',file:'button.js')}" />
      <g:javascript library="/js/yui/container/container" />
      <g:javascript library="/js/yui/dragdrop/dragdrop" />

       %{--<script type="text/javascript" src="${resource(dir:"/js/yui/yahoo-dom-event",file: "yahoo-dom-event.js")}"></script>--}%
       %{--<script type="text/javascript" src="${resource(dir:"/js/yui/element",file: "element.js")}"></script>--}%
       %{--<script type="text/javascript" src="${resource(dir:"/js/yui/button",file: "button.js")}"></script>--}%
       %{--<script type="text/javascript" src="${resource(dir:"/js/yui/dragdrop",file: "dragdrop.js")}"></script>--}%

      <link rel="stylesheet" href="${createLinkTo(dir:'js',file:'yui/fonts/fonts-min.css')}" />
      <link rel="stylesheet" href="${createLinkTo(dir:'js',file:'yui/button/assets/skins/sam/button.css')}" />
      <link rel="stylesheet" href="${createLinkTo(dir:'js',file:'yui/container/assets/skins/sam/container.css')}" />
             
      <script>
        // display member
        function display(id) {
          if (!id) return;
          $('search').value = "";
          $('display_details').innerHTML = '<img src="${createLinkTo(dir:'images/tree/menu',file:'loading.gif')}" border="0" style="float:left;visibility:visible;clear:both;">';
          new Ajax.Updater('display_details','${request.contextPath}/member/renderMember/'+id,{asynchronous:true,evalScripts:true});
        }

        // wedding update completed
        function done(req) {
          if (req.responseText == "true") {
            $('edit_wedding_result').setStyle({color:006600}).update('Updated successfully. <g:link controller="member" action="display" id="${member?.id}">Continue</g:link>');
            $('wedding_save_button').addClassName('disabled').disabled = "disabled";
          } else {
            $('edit_wedding_result').setStyle({color:660000}).update('Sorry! ' + req.responseText); 
          }
        }
        
        // TODO wedding updated
        function memberEditComplete(req) {
          if (req.responseText == "true")
            $('edit_member_result').innerHTML = 'Updated successfully. <g:link controller="member" action="dislay" id="${member?.id}">Continue</g:link>';
        } 

	    // Yes event handlers for delete dialog
	    var handleYesDelete = function() {
	      document.forms.member_form.action = "<g:createLink action="delete" />";
		  document.forms.member_form.submit();
		  this.hide();
	    };

        // Yes event handlers for reset avatar dialog
	    var handleYesReset = function() {
	      document.forms.member_form.action = "<g:createLink action="resetAvatar" />";
		  document.forms.member_form.submit();
		  this.hide();
	    };

        // dislay reset avatar dialog
	    function showResetDialog(id, nickname) {
	       $('a_id').value = id;
	       var resetDialog = new YAHOO.widget.SimpleDialog("resetDialog", 
			 { width: "300px",
		       fixedcenter: true,
			   visible: false,
			   draggable: false,
			   close: true,
			   modal: true,
			   text: "This will reset " + nickname + "'s avatar to the default image. ",																			 
			   constraintoviewport: true,
			   underlay: false,
			   buttons: [ { text:"Yes", handler:handleYesReset },
						  { text:"No",  handler:function() {this.hide();}, isDefault:true } ]
			 } );
	       resetDialog.setHeader("Do you want really want to reset avatar?");
	       resetDialog.render(document.body);
	       resetDialog.show(); 	     
	     }
	     
	     var weddingPanel;           
         function init() {
            weddingPanel = new YAHOO.widget.Panel("weddingPanel", { width:"425px", visible:false, fixedcenter: true, constraintoviewport:true, draggable:true, modal: true, underlay:false } );
			weddingPanel.render(document.body);
		 }

         // display delete dialog
         function showDeleteDialog(id, nickname) {
           $('a_id').value = id;
	       var deleteDialog = new YAHOO.widget.SimpleDialog("deleteDialog", 
			 { width: "300px",
		       fixedcenter: true,
			   visible: false,
			   draggable: false,
			   close: true,
			   modal: true,
			   text: "Deleting " + nickname + " will permanently remove member details from the system.",																			 
			   constraintoviewport: true,
			   underlay: false,
			   buttons: [ { text:"Yes", handler:handleYesDelete },
						  { text:"No",  handler:function() {this.hide();}, isDefault:true } ]
			 } );
	       deleteDialog.setHeader("Do you want really want to delete?");
	       deleteDialog.render(document.body);
	       deleteDialog.show();         
         }
         
         // display wedding panel
         function showWeddingPanel(id) {
            clearWeddingPanel();
            weddingPanel.show();
            new Ajax.Updater('weddingPanelBody','${request.contextPath}/wedding/edit/'+id,{asynchronous:true,evalScripts:true});
         }
         
         // clear wedding panel
         function clearWeddingPanel() {
            $('weddingPanelBody').update('<img src="${request.contextPath}/images/rotating_arrow.gif">');
         }
         
        YAHOO.util.Event.addListener(window, "load", init);
      </script>
      <style>
        .searchcontainer .yui-skin-sam { margin-left: 200px;}
        #linkbuttonEdit a  {
           padding-left: 2.25em;
           background: url(/famree/images/icon_edit.gif) 10% 50% no-repeat;
        }
        #linkbuttonAdd a { 
           padding-left: 2.25em;
           background: url(/famree/images/icon_add.gif) 10% 50% no-repeat;
        }

        #linkbuttonReset a { 
           padding-left: 2.25em;
           background: url(/famree/images/icon_reset.png) 10% 50% no-repeat;
        }
        #linkbuttonDelete a { 
           padding-left: 2.25em;
           background: url(/famree/images/icon_delete.gif) 10% 50% no-repeat;
        }
      </style>
    </head>
    <body>
        <div class="body">
            <h1>Browse Members</h1>

            <div class="display_autocomplete">
              <g:form>
                 <div style="font-weight:bold;">Search a family member:</div>
                 <richui:autoComplete name="search" action="${createLinkTo('dir': 'member/search')}" shadow="true" minQueryLength="1" onItemSelect="display(id);" style="width:250px;margin:10px 0 0 0;"/>
              </g:form>
            </div>

            <div class="quick_links">
              <b>Quick links:</b> <br>
              <g:link action="list">List all members</g:link> <br>
              <sec:ifAnyGranted roles="ROLE_ADMIN"><g:link action="create">Add new member</g:link></sec:ifAnyGranted>&nbsp;
            </div>

            <div style="clear:both;height:5px">&nbsp;</div>

            <div class="display_tree">
              <g:if test="${data}">
                <richui:treeView xml="${data}" onLabelClick="display(id);" />
              </g:if>
            </div>

            <div class="display_details" id="display_details">
                <g:if test="${member}"><g:render template="displayMember" model="[member:member]" /></g:if>
                <g:else>View a family member details by clicking on the tree or by searching</g:else>
            </div>

            <div style="clear:both">&nbsp;</div>
        </div>

        <g:form controller="member" name="member_form">
          <input type="hidden" name="id" id="a_id">
        </g:form>

       <div id="weddingPanel" style="visibility:hidden">
	  	 <div class="hd">Manage Wedding</div>
		 <div class="bd" id="weddingPanelBody">&nbsp;</div>
	   </div>

    </body>
</html>
