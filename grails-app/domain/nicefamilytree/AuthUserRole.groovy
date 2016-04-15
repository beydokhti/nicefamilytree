package nicefamilytree

import org.apache.commons.lang.builder.HashCodeBuilder

class AuthUserRole implements Serializable {

    private static final long serialVersionUID = 1

    AuthUser authUser
    Role role

    boolean equals(other) {
        if (!(other instanceof AuthUserRole)) {
            return false
        }

        other.authUser?.id == authUser?.id &&
                other.role?.id == role?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (authUser) builder.append(authUser.id)
        if (role) builder.append(role.id)
        builder.toHashCode()
    }

    static AuthUserRole get(long authUserId, long roleId) {
        find 'from AuthUserRole where authUser.id=:authUserId and role.id=:roleId',
                [authUserId: authUserId, roleId: roleId]
    }

    static AuthUserRole create(AuthUser authUser, Role role, boolean flush = false) {
        new AuthUserRole(authUser: authUser, role: role).save(flush: flush, insert: true)
    }

    static boolean remove(AuthUser authUser, Role role, boolean flush = false) {
        AuthUserRole instance = AuthUserRole.findByAuthUserAndRole(authUser, role)
        if (!instance) {
            return false
        }

        instance.delete(flush: flush)
        true
    }

    static void removeAll(AuthUser authUser) {
        executeUpdate 'DELETE FROM AuthUserRole WHERE authUser=:authUser', [authUser: authUser]
    }

    static void removeAll(Role role) {
        executeUpdate 'DELETE FROM AuthUserRole WHERE role=:role', [role: role]
    }

    static mapping = {
        id composite: ['role', 'authUser']
        version false
        table 'ft_auth_user_role'
    }
}
