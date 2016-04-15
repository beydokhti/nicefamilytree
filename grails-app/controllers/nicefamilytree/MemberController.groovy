package nicefamilytree
/**
 * Member Controller
 *
 * @author Manohar Viswanathan
 */
class MemberController   {

    def memberService
//    AuthenticateService authenticateService

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    // default action                      
    def index = { redirect(action: list, params: params) }

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
//        def uinfo = authenticateService.userDomain()
//        def member
//        if (uinfo) {
//            member = FamilyMember.findByAuthUser(AuthUser.get(uinfo.id))
//
//        } else {
//            redirect(action: "index")
//        }
//        [member: member]
//        [ member : FamilyMember.get( params.id ) ]
    }

    def updateAvatar={
        def member = new FamilyMember(params)
        if(member) {
            def file = request.getFile("avatar")
            member.avatarMime = member.avatar?.length>0? file?.contentType : null

            if(!member.hasErrors() && member.validate()) {
                member = memberService.updateFamilyMember(member)
                flash.message = "${member.nickname} Picture have been updated"
                redirect(action:properties,member:member)
            } else {
                redirect(action:properties,member:member)
            }
        } else {
            flash.message = "FamilyMember not found with id ${params.id}"
            redirect(action:"profile",id:params.id)
        }

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

    // display member
    def display = {
        def root = memberService.getRootMember()
        def s = new StringBuffer()
        constructTree(root, s)
        def member
        if (params.id) member = FamilyMember.get(params.id.toString())
        ["data": s.toString(), member: member]
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

}


