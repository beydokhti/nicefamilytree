<%@ page import="nicefamilytree.data.Gender" %>
  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="mainInside" />
        <title>Edit Member</title>
            <g:javascript library="yui/yahoo/yahoo" />
    <g:javascript library="yui/event/event" />
        <script>
           function genderChanged(gender) {
           clearSelect();
              if(gender) {
              new Ajax.Request('${request.contextPath}/member/listEligibleSpousesAjax/${member?.id}',{asynchronous:true,evalScripts:true,onSuccess:function(e){spouseHandler(e);}});
      
              } else {
                 
              }
              
           }

	  function spouseHandler(req) {
	    var data = eval('(' + req.responseText + ')');
	    buildSelect("spouseId", data.options);
	    $("spouseId").value = "${member?.spouse?.id}";
	  }
	  
	  // builds a select element
	  function buildSelect(id, data) {
	    var selectElement = document.getElementById(id);

        if(selectElement) {
          selectElement.disabled = false;
	      for (var i=0;i<data.length;i++) {
	        var theOption=document.createElement("OPTION");
	        theOption.setAttribute("value",data[i].key);
	        theOption.appendChild(document.createTextNode(data[i].value));
	        selectElement.appendChild(theOption);
	      }
	    }	    
	  }
	  
	  function spouseSelected(spouseId) {
	     if (spouseId && spouseId != '0') {
	       $('weddingDate').style.display="";
	     } else {
	       $('weddingDate').style.display="none";
	     }
	  }
	  
	  function clearSelect() {
	    var selectElement = document.getElementById("spouseId");

        if(selectElement) {
	      selectElement.innerHTML = "";
	      var theOption=document.createElement("OPTION");
	      theOption.setAttribute("value","0");
	      theOption.appendChild(document.createTextNode("-Choose-"));
	      selectElement.appendChild(theOption);
	      selectElement.disabled = true;        
        }
	  }
	

      </script>        
    </head>
    <body>
        <div class="body">
            <h1>Edit Member</h1>

            <g:hasErrors bean="${member}">
            <div class="errors">
                <g:renderErrors bean="${member}" as="list" />
            </div>
            </g:hasErrors>
            

            <g:form controller="member" action="update" method="post"  enctype="multipart/form-data">
                <input type="hidden" name="id" value="${member?.id}" />

                <g:render template="member" model="['member':member, 'spouseDetails':false]" />
                 <p>&nbsp;</p>
       
                 <g:actionSubmit class="button" value="Update" action="update" />
                 <g:actionSubmit class="button" value="Cancel" action="display" />
            </g:form>

            
        </div>
    </body>
</html>
