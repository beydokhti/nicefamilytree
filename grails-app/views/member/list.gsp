  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="mainInside" />
    </head>
    <body>
        <div class="body">
            <h1>Family Members</h1>
            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="name" title="Name" />
                        
                   	        <g:sortableColumn property="nickname" title="Nickname" />
                        
                   	        <g:sortableColumn property="birthDate" title="Birth Date" />
                        
                            <g:sortableColumn property="deathDate" title="Death Date" />
                            
                   	        <g:sortableColumn property="parent" title="Parent" />
                        
                            <th>Spouse</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${memberList}" status="i" var="member">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                                
                            <td><g:link action="display" id="${member.id}">${member.name?.encodeAsHTML()}</g:link></td>
                        
                            <td><g:link action="display" id="${member.id}">${member.nickname?.encodeAsHTML()}</g:link></td>
                        
                            <td><g:formatDate date="${member.birthDate}" format="MMMMM dd, yyyy" /></td>
                        
                            <td><g:formatDate date="${member.deathDate}" format="MMMMM dd, yyyy" /></td>
                            
                            <td>${member.parent}</td>
                        
                            <td>${member.spouse?.name}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${FamilyMember.count()}" />
            </div>
            
            <p>&nbsp;</p>
            
            <g:form action="create">
                <g:actionSubmit value="New Member" class="button" action="create" />
            </g:form>
            
        </div>
    </body>
</html>
