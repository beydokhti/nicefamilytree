package nicefamilytree

import grails.converters.JSON
import org.bouncycastle.util.encoders.Base64
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUser
import org.imgscalr.Scalr

import javax.imageio.ImageIO
import javax.swing.ImageIcon
import java.awt.Image
import java.awt.image.BufferedImage

/**
 * Member Controller
 *
 * @author Manohar Viswanathan
 */
class MemberController {
    def grailsApplication
    def memberService
    def springSecurityService

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    // default action                      
    def index = { redirect(action: display, params: params) }

    // list all family members
    def list = {
        if (!params.max) params.max = 40
        if (!params.sort) params.sort = "birthDate"
        if (!params.order) params.order = "asc"

        [memberList: FamilyMember.list(params)]
    }

    // show member. TODO is it used?
    def show = {
        [member: FamilyMember.get(params.id)]
    }

    def profile = {
        println(new Date().toString() + " profile params: " + params)
        def memberId=params.id
        def wedding
        def member
        def model=[:]
        if (memberId){
            member = FamilyMember.get(memberId)
        }else {
            def uinfo = springSecurityService.getPrincipal()
            if (uinfo && uinfo instanceof GrailsUser) {
                member = FamilyMember.findByAuthUser(AuthUser.get(uinfo.id))
            } else {
                //todo-mtb change redirect
                return redirect(action: "index")
            }
        }
        if (member) {
            model.parentsData = member?.parent?.mainMember?.name + "," + member?.parent?.spouseMember?.name
            model.name = member.name
            model.id = member.id
            model.title = member.nickname
            model.cibilings = member?.parent?.children?.collect { its -> its.name }
            model.spouseWedding = ""
            model.mainWedding = ""
            model.mainChildren = ""
            model.spouseChildren = ""
            wedding = Wedding.findAllByMainMember(member)
            if (wedding) {
                model.spouseWedding = wedding.spouseMember.collect { itw -> itw.name }
                model.spouseChildren = wedding.children.collect { itd -> itd.name }
            }
            wedding = Wedding.findAllBySpouseMember(member)
            if (wedding) {
                model.mainWedding = model.spouse + wedding.mainMember.collect { itf -> itf.name }
                model.mainChildren = model.children + wedding.children.collect { itx -> itx.name }
            }

            if(member?.avatar?.length > 0 && member.avatarMime)
            {
                model.avatar="${request.contextPath}/member/avatar/${member.id}"
            }else{
                if(member && member?.gender=="MALE")
                    model.avatar="${request.contextPath}/images/avatar_default_man.png"
                else if(member && member?.gender=="FEMALE")
                    model.avatar="${request.contextPath}/images/avatar_default_woman.png"
                else
                    model.avatar="${request.contextPath}/images/avatar_default_unknownGender.png"
            }
        }

        [member: model]
    }

    def updateAvatar = {
        println(new Date().toString() + " updateAvatar params: " + params)

        def member = FamilyMember.get(params.id)
        if (member) {
            def file = request.getFile("avatar")
            member.avatar=file.getBytes()
            member.avatarMime = member.avatar?.length > 0 ? file?.contentType : null
            saveSmallAvatar(member.id)
        } else {
            //add message to page
            flash.message = "FamilyMember not found with id ${params.id}"
        }
        redirect(action: "profile", id: params.id)

    }

    // delete family member
    def delete = {
        def member = memberService.get(params.id)
        if (member && !member.children && !member.root) {
            def result = memberService.deleteFamilyMember(params.id)
            if (result) {
                flash.message = "${member.nickname} has been deleted"
                redirect(action: list)
            } else {
                flash.message = "${member.nickname} cannot be deleted"
                redirect(action: display, id: params.id)
            }
        } else {
            flash.message = "Family root and other members who have children cannot be deleted"
            redirect(action: display, id: params.id)
        }
    }

    // edit family member
    def edit = {
        def member = FamilyMember.get(params.id)
        if (!member) {
            flash.message = "FamilyMember not found with id ${params.id}"
            redirect(action: list)
        } else {
            def eligibleParentList = memberService.listEligibleParents(member)
            return [member: member, eligibleParentList: eligibleParentList]
        }
    }

    // update family member
    def update = { FamilyMemberCommand cmd ->
        if (!params.deathDate_day && !params.deathDate_month && !params.deathDate_year) {
            params.deathDate = null
        }
        if (!params.birthDate_day && !params.birthDate_month && !params.birththDate_year) {
            params.birthDate = null
        }
        def member = new FamilyMember(params)
        if (member) {
            member.id = params.id.toInteger()
            def exsistingRoot = memberService.getRootMember()
            if (member.parent?.id == 0 && exsistingRoot && exsistingRoot.id != member.id) {
                member.errors.rejectValue('parent', 'root.already.exists')
            }
            def file = request.getFile("avatar")
            member.avatarMime = member.avatar?.length > 0 ? file?.contentType : null

            if (!member.hasErrors() && member.validate()) {
                if (member.parent?.id == 0) {
                    member.parent = null
                    member.root = true
                } else {
                    member.root = false
                }
                member = memberService.updateFamilyMember(member)
                flash.message = "${member.nickname} details have been updated"
                redirect(action: display, id: member.id)
            } else {
                def eligibleParentList = memberService.listEligibleParents(member)
                render(view: 'edit', model: [member: member, eligibleParentList: eligibleParentList])
            }
        } else {
            flash.message = "FamilyMember not found with id ${params.id}"
            redirect(action: edit, id: params.id)
        }
    }

    // create new family member
    def create = {
        def member = new FamilyMember()
        member.properties = params
        params.activeFlag = true
        def spouse
        def eligibleSpouseList = params.spouseId ? [FamilyMember.get(params.spouseId.toInteger())] : []
        def previousSpouseList = params.prevSpouseId ? [FamilyMember.get(params.prevSpouseId.toInteger())] : []
        def eligibleParentList = memberService.listEligibleParents(member)

        return ['member': member, eligibleSpouseList: eligibleSpouseList, previousSpouseList: previousSpouseList, eligibleParentList: eligibleParentList]
    }

    // save family member
    def save = { FamilyMemberCommand cmd ->
        // Sanitize params
        if (!params.deathDate_day && !params.deathDate_month && !params.deathDate_year) {
            params.deathDate = null
        }
        if (!params.birthDate_day && !params.birthDate_month && !params.birthDate_year) {
            params.birthDate = null
        }
        def member = new FamilyMember(params)

        def file = request.getFile("avatar")
        member.avatarMime = member.avatar?.length > 0 ? file?.contentType : null

        if (member.parent?.id == -1 && ((!params.prevSpouseId && params.spouseId == "0") || (!params.spouseId && params.prevSpouseId == "0"))) {
            member.errors.rejectValue('parent', 'parent.spouse.both.not.chosen')
        }
        if (member.parent?.id == 0 && memberService.getRootMember()) {
            member.errors.rejectValue('parent', 'root.already.exists')
        }

        def spouseId = params.activeFlag ? params.spouseId : params.prevSpouseId
        def spouse = memberService.get(spouseId)
        def wedding
        if (spouse) {
            wedding = new Wedding()
            wedding.mainMember = spouse
            wedding.spouseMember = member
            wedding.weddingDate = cmd.weddingDate
            wedding.active = params.activeFlag
        }
        if (!member.hasErrors() && member.validate() && (!wedding || (!wedding?.hasErrors() && wedding?.validate()))) {
            if (member.parent?.id == 0) {
                member.parent = null
                member.root = true
            }
            member = memberService.createFamilyMember(member, wedding)
            if(member.avatar)
                saveSmallAvatar(member.id)
            flash.message = "${member.nickname} has been added to the family"
            redirect(action: display, id: member.id)
        } else {
            // validator error. back to create page
            def eligibleSpouseList = member?.gender ? memberService.listEligibleSpouses(member, true) : null
            def previousSpouseList = member?.gender ? memberService.listEligibleSpouses(member, false) : null
            def eligibleParentList = memberService.listEligibleParents(member)
            render(view: 'create', model: [member: member, eligibleSpouseList: eligibleSpouseList, eligibleParentList: eligibleParentList, previousSpouseList: previousSpouseList, wedding: wedding])
        }
    }

    // render avatar image
    def avatar = {
        def member = FamilyMember.get(params.id)
        if (member && member.avatar) {
            response.contentType = member.avatarMime
            response.contentLength = member.avatar.length
            response.outputStream.write(member.avatar)
            response.outputStream.flush()
        }
    }

    def avatarsm = {
        def member = FamilyMember.get(params.key)

        if (member && member.avatar) {


        }
    }

    def saveSmallAvatar(memberId){
        try {
            String absolutePath = getServletContext().getRealPath(grailsApplication.config.avatar.small.temp.path);
            def member = FamilyMember.get(memberId)
//            String imageFormat = member.avatarMime.replaceAll("image/","")
            String imageFormat = "png"
            Integer targetWidth = 39
            Integer targetHeight = 50
            InputStream is = new ByteArrayInputStream(member.avatar);
            BufferedImage image = ImageIO.read(is)
            BufferedImage scaledImg = Scalr.resize(image, Scalr.Method.QUALITY, Scalr.Mode.FIT_EXACT,
                    targetWidth, targetHeight, Scalr.OP_ANTIALIAS)

            ByteArrayOutputStream baos = new ByteArrayOutputStream()
            ImageIO.write(scaledImg, imageFormat, baos)
            baos.flush()
            byte[] scaledImageInByte = baos.toByteArray()
            baos.close()

            FileOutputStream os = new FileOutputStream(absolutePath+"/" + member.id + "." + imageFormat)
            os.write(scaledImageInByte)
            os.close()
        }catch (Exception e)
        {
            println "Error in saveSmallAvatar"
            println e.getMessage()
            e.printStackTrace()
        }
    }

    def jsonMemberDetails() {
        println(new Date().toString() + " jsonMemberDetails params: " + params)
        def model = [:]
        def member = FamilyMember.get(params.id)
        def wedding

        try {
            if (member) {
                model.parentsData = member?.parent?.mainMember?.name + "," + member?.parent?.spouseMember?.name
                model.name = member.name
                model.title = member.nickname
                model.cibilings = member?.parent?.children?.collect { it -> it.name }
                model.spouseWedding = ""
                model.mainWedding = ""
                model.mainChildren = ""
                model.spouseChildren = ""
                wedding = Wedding.findAllByMainMember(member)
                if (wedding) {
                    model.spouseWedding = wedding.spouseMember.collect { it -> it.name }
                    model.spouseChildren = wedding.children.collect { it -> it.name }
                }
                wedding = Wedding.findAllBySpouseMember(member)
                if (wedding) {
                    model.mainWedding = model.spouse + wedding.mainMember.collect { it -> it.name }
                    model.mainChildren = model.children + wedding.children.collect { it -> it.name }
                }

                if(member?.avatar?.length > 0 && member.avatarMime)
                {
                    model.avatar="${request.contextPath}/member/avatar/${member.id}"
                }else{
                    if(member && member?.gender=="MALE")
                        model.avatar="${request.contextPath}/images/avatar_default_man.png"
                    else if(member && member?.gender=="FEMALE")
                        model.avatar="${request.contextPath}/images/avatar_default_woman.png"
                    else
                        model.avatar="${request.contextPath}/images/avatar_default_unknownGender.png"
                }
            }
        } catch (Exception ex) {
            println("---------------------------------------------------------------------------------------")
            println(new Date().toString() + " Error in /nicefamilytree/member/jsonMemberDetails :")
            println(ex.message)
            ex.printStackTrace()
            model.error="Error"
        }
        render([model: model] as JSON)

    }

    // display member
    def display = {
        def cm
        def memberWithAvatar=[:]
        ArrayList chartMemebers = new ArrayList()

        def rootMember = FamilyMember.findByRoot(true)
        cm = new ChartMember("key": rootMember.id, "name": rootMember.name, "title": rootMember.nickname)
        chartMemebers.add(cm)
        if (rootMember.avatarMime)
            memberWithAvatar.put(rootMember.id.toString(),rootMember.avatarMime.replaceAll("image/",""))

        def familyMembers = FamilyMember.findAll()
        for (member in familyMembers) {

            if (member.parent) {
                cm = new ChartMember("key": member.id, "name": member.name, "title": member.nickname, "comments": member.parent.spouseMember.name)
                cm.parent = member.parent.mainMember.id
                chartMemebers.add(cm)
                if (member.avatarMime)
                    memberWithAvatar.put(member.id.toString(),member.avatarMime.replaceAll("image/",""))
            }
        }
        def chartJSON = ("{ \"class\": \"go.TreeModel\",\t\"nodeDataArray\": " + (chartMemebers as JSON) + "}").replaceAll("\"parent\":null,", "")
//        def memberWithAvatar=FamilyMember.findAllByAvatarMimeIsNotNull().collect{it.id.toString()};
        [chartMemebers: chartJSON,memberWithAvatar:memberWithAvatar as JSON]

    }

    // render member
    def renderMember = {
        def member = memberService.get(params.id)
        render(template: "displayMember", model: [member: member])
    }

    // contruct family tree
    def constructTree = { member, s ->
        if (!member) return

        if (!member?.children) {
            if (member.spouse) s.append("<member name='${member.nickname + " &amp; " + member.spouse.nickname}' id='${member.id}'/>")
            else s.append("<member name='${member.nickname}' id='${member.id}'/>")
        } else {
            if (member.spouse) s.append("<member name='${member.nickname + " &amp; " + member.spouse?.nickname}' id='${member.id}'>")
            else s.append("<member name='${member.nickname}' id='${member.id}'>")
            member.children.each { constructTree(it, s) }
            s.append("</member>")
        }
    }

    // get eligible spouses for a member
    def listEligibleSpousesAjax = {
        def member
        if (params.id) member = memberService.get(params.id)
        else {
            member = new FamilyMember()
            member.gender = params.gender
        }
        def listEligibleSpouses = memberService.listEligibleSpouses(member, params.active)
        render(builder: "json") {
            options {
                for (s in listEligibleSpouses) {
                    option(key: s.id, value: s.nickname)
                }
            }
        }
    }

    // reset avatar
    def resetAvatar = {
        memberService.resetAvatar(params.id.toInteger())
        flash.message = "Avatar reset to default image"
        redirect(action: display, id: params.id)
    }

    // search members
    def search = {
        def members = FamilyMember.findAllByNameLikeNicknameLike("%${params.query}%", "%${params.query}%")
        //Create XML response
        render(contentType: "text/xml") {
            results() {
                members.each { member ->
                    result() {
                        name(member.name + " (" + member.nickname + ")")
                        id(member.id)
                    }
                }
            }
        }
    }

    class FamilyMemberCommand {
        Date weddingDate
        Boolean divorseFlag = false
    }
//
//    def getImage() {
//        if (params.id) {
//            def attachment = FamilyMember.get(params.id)
//            response.contentType = 'image/png'
//            response.outputStream << attachment.document
//            response.outputStream.flush()
//        }
//    }

    def test() {}

    def createUser(){

    }

    def createUserAjax(){
        println new Date().toString()+ " member createUserAjax params:" +params
        def username=params.username
        def password=params.password
        def memberId=params.memberId
        def response=[:]
        try {
            if(memberId && password&& username) {
                def userMember = FamilyMember.get(memberId)

                if (userMember && !userMember.authUser) {
                    def rm=Role.findByAuthority("ROLE_USER")
                    MemberUser memberUser= new MemberUser(username:username,password: password,enabeld:true,accountExpired:false,
                            accountLocked:false,passwordExpired:false,enabled: true,userRealName:userMember.name).save(flush:true)
                    def ar=AuthUserRole.findByAuthUserAndRole(memberUser,rm)
                    if(!ar)
                        ar=new AuthUserRole(authUser:memberUser,role:rm).save(flush:true);

                    userMember.authUser= memberUser
                    response.status="operation is successful"
                } else if (userMember && userMember.authUser){
                    userMember.authUser.username=username
                    userMember.authUser.password=password
                    response.status="operation is successful"
                } else {
                    response.status="Error: member is invalid"
                }
            }

        }catch (Exception ex){
            response.status=ex.message
        }finally{
            render response as JSON
        }

    }

    def searchAjax(params){
        //todo-mtb persian name made error
        println new Date().toString()+ " member serach ajax params:" +params
        def searchText=params.searchText
        def response=[:]
        try {
            if(searchText) {
                def authUser = AuthUser.findByUsername(searchText)
                def userMember = FamilyMember.findByAuthUser(authUser)

                if (authUser) {
                    response.username = authUser.username
                    response.password = authUser.password
                    response.memberId = userMember.id
                } else {
                    def member = FamilyMember.findByNameOrNickname(searchText, searchText)
                    if (member?.authUser) {
                        response.username = authUser.username
                        response.password = authUser.password
                        response.memberId = userMember.id
                    }
                }
            }

        }catch (Exception ex){
            response.error=ex.message
            response.username=null
            response.password=null
            response.username=null
        }finally{
            render response as JSON
        }

    }

}


