package nicefamilytree

class Role {

    String authority

    static mapping = {
        cache true
        table 'ft_role'
    }

    static constraints = {
        authority blank: false, unique: true
    }
}
