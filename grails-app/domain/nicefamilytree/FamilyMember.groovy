package nicefamilytree

class FamilyMember {

    String name
    String nickname
    Date birthDate
    String gender
    Date deathDate
    byte[] avatar
    String avatarMime
    Wedding parent
    boolean root = false
    AuthUser authUser

    static mapping = {
        table 'ft_family_member'
        version false
    }

    static constraints = {
        name(blank: false, nullable: false)
        nickname(blank: false, nullable: false)
        birthDate(blank: false, nullable: false, max: new Date())
        deathDate(blank: true, nullable: true)
        gender(blank: false, nullable: false)
        avatar(nullable: true, maxSize: 1024 * 50)
        avatarMime(blank: true, nullable: true)
        parent(nullable: true)
        authUser(nullable: true,unique: true)
    }

    // get current spouse
    def getSpouse() {
        def activeWedding = getWedding()
        activeWedding?.mainMember?.id == id ? activeWedding?.spouseMember : activeWedding?.mainMember
    }

    // get current active wedding
    def getWedding() {
        getWeddings()?.find { it.active }
    }

    // get previous inactive weddings
    def getInactiveWeddings() {
        getWeddings()?.findAll { !it.active }
    }

    // get all weddings
    def getWeddings() {
        def weddings
        weddings = id ? Wedding.executeQuery("select w from Wedding w where w.mainMember.id=:id or w.spouseMember.id=:id", [id: id]) : []
        return weddings
    }

    // get all children
    def getChildren() {
        def allchildren = []
        def weddings = getWeddings()
        weddings?.each {
            allchildren.addAll(it.childrenSorted)
        }
        return allchildren
    }

    // get opposite gender
    def getOppositeGender() {
        return gender == 'MALE' ? 'FEMALE' : 'MALE'
    }

    String toString() {
        return "${id}:${nickname}"
    }
}