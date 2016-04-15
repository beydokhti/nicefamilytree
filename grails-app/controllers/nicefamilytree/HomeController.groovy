package nicefamilytree

import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import nicefamilytree.ChartMember
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class HomeController {
    def springSecurityService
    @Secured ("IS_AUTHENTICATED_ANONYMOUSLY")
    def index() {

        //service part
        def cm
        ArrayList chartMemebers = new ArrayList()

        def rootMember = FamilyMember.findByRoot(true)
        cm = new ChartMember("key": rootMember.id, "name": rootMember.name, "title": rootMember.nickname)
        chartMemebers.add(cm)


        def familyMembers = FamilyMember.findAll()
        for (member in familyMembers) {

            if (member.parent) {
                cm = new ChartMember("key": member.id, "name": member.name, "title": member.nickname)
                cm.parent = member.parent.mainMember.id
                chartMemebers.add(cm)
            }
        }
        def chartJSON = ("{ \"class\": \"go.TreeModel\",\t\"nodeDataArray\": " + (chartMemebers as JSON) + "}").replaceAll("\"parent\":null,", "")

        //login part
        def config = SpringSecurityUtils.securityConfig

        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"

        [chartMemebers      : chartJSON, postUrl: postUrl,
         rememberMeParameter: config.rememberMe.parameter]
    }
}
