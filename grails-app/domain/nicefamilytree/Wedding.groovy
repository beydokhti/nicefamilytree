package nicefamilytree

class Wedding {

    FamilyMember mainMember
    FamilyMember spouseMember
    Date weddingDate
    Boolean active = true

    static hasMany = [children:FamilyMember]
    static mappedBy = [children:"parent"]

    static mapping = {
        table 'ft_wedding'
        version false
    }

    static constraints = {
        weddingDate(blank:true, nullable:true)
    }

    String toString() {
        if (id==0) return "Family Root"
        return "${mainMember?.nickname} and ${spouseMember?.nickname}"
    }

    def getChildrenSorted() {
        def sortedChildren = new ArrayList()
        sortedChildren.addAll(children)
        sortedChildren.sort { it.birthDate }

        return sortedChildren
    }


}