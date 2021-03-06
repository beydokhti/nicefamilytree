package nicefamilytree

class AuthUser {

    transient springSecurityService

    String username
    String password
    String userRealName
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    static constraints = {
        username blank: false, unique: true
        password blank: false
    }

    static mapping = {
        password column: '`password`'
        table 'ft_auth_user'
    }

    Set<Role> getAuthorities() {
        AuthUserRole.findAllByAuthUser(this).collect { it.role } as Set
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }
}
