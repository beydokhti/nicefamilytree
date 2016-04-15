<%@ page import="com.mano.familytree.data.Gender" %>      
  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="mainInside" />
  
        <script>
           function genderChanged(gender) {
             clearSelect("spouseId");
             clearSelect("prevSpouseId");
                       
              if(gender) {
                new Ajax.Request('${request.contextPath}/member/listEligibleSpousesAjax/${member?.id}',{asynchronous:true,evalScripts:true,parameters:'gender='+gender+'&active=true',onSuccess:function(e){spouseHandler(e);}});
                new Ajax.Request('${request.contextPath}/member/listEligibleSpousesAjax/${member?.id}',{asynchronous:true,evalScripts:true,parameters:'gender='+gender,onSuccess:function(e){prevSpouseHandler(e);}});
                showSpouseList($('activeFlag').checked);
              } else {
                 
              }
              
           }

	  function spouseHandler(req) {
	    var data = eval('(' + req.responseText + ')');
	    buildSelect("spouseId", data.options);
	  }

	  function prevSpouseHandler(req) {
	    var data = eval('(' + req.responseText + ')');
	    buildSelect("prevSpouseId", data.options);
	  }
	  	  
	  // builds a select element
	  function buildSelect(id, data) {
	    var selectElement = document.getElementById(id);

        if(selectElement) {
         // selectElement.disabled = false;
	      for (var i=0;i<data.length;i++) {
	        var theOption=document.createElement("OPTION");
	        theOption.setAttribute("value",data[i].key);
	        theOption.appendChild(document.createTextNode(data[i].value));
	        selectElement.appendChild(theOption);
	      }
	    }	    
	  }
	  
	  function clearSelect(id) {
	    var selectElement = document.getElementById(id);

        if(selectElement) {
	      selectElement.innerHTML = "";
	      var theOption=document.createElement("OPTION");
	      theOption.setAttribute("value","0");
	      theOption.appendChild(document.createTextNode("-Choose-"));
	      selectElement.appendChild(theOption);
	      selectElement.disabled = true;        
        }
	  }
	
	  function spouseSelected() {
	     var spouseId = $("spouseId").value;
	     if (spouseId && spouseId != '0') {
	       $('weddingDate').style.display="";
	     } else {
	       $('weddingDate').style.display="none";
	     }
	  }
	  
	  function showSpouseList(activeFlag) {

	    if(activeFlag) {
	      $('spouseId').disabled = false;
	      $('prevSpouseId').disabled = true;
	    }  else {
	      $('spouseId').disabled = true;
	      $('prevSpouseId').disabled = false;
	    }
	  }
	  
	  function init() {
	    
	    showSpouseList($('activeFlag').checked);
	    if ('${params.prevSpouseId}') { 
	      $('inActiveFlag').checked = true;
	      showSpouseList(false);
	    }
	   // if ('${member?.gender}') genderChanged('${member?.gender}');
	     
	  }
     </script>   
    </head>
    <body onload="init()">
        <div class="body">
            <h1>Create Member</h1>

            <g:hasErrors bean="${member}">
            <div class="errors">
                <g:renderErrors bean="${member}" as="list" />
            </div>
            </g:hasErrors>
            <g:hasErrors bean="${wedding}">
            <div class="errors">
                <g:renderErrors bean="${wedding}" as="list" />
            </div>
            </g:hasErrors>            
       
 
		            <g:form action="save" method="post"  enctype="multipart/form-data">
		               <g:render template="member" model="['member':member, 'spouseDetails':true]" />
		                   <p>&nbsp;</p>
		                    <input class="button" type="submit" value="Save"></input>
		                
		            </g:form>
		                 
               
                
             
            
        </div>
    </body>
</html>
