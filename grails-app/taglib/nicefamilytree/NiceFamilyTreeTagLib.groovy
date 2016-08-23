package nicefamilytree

class NiceFamilyTreeTagLib {

    def avatar = { attrs, body ->
        def avatarSize=attrs.avatarSize?attrs.avatarSize:""
        def memberKey=attrs.member

        if (memberKey) {
            def member = FamilyMember.get()

            if (member && member?.avatar?.length > 0 && member.avatarMime) {
                println "/member/avatar${avatarSize}/${member.id}"
                out << "${request.contextPath}/member/avatar${avatarSize}/${member.id}"
            } else {
                if (member && member?.gender == "MALE")
                    out << "${request.contextPath}/images/avatar_default_man.png"
                else if (member && member?.gender == "FEMALE")
                    out << "${request.contextPath}/images/avatar_default_woman.png"
                else
                    out << "${request.contextPath}/images/avatar_default_unknownGender.png"

            }
        }else
            out << "${request.contextPath}/images/avatar_default_unknownGender_sm.png"
        }
}
