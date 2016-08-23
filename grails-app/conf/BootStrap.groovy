import nicefamilytree.AuthUser
import nicefamilytree.AuthUserRole
import nicefamilytree.Role

class BootStrap {

    def init = { servletContext ->
        def rm=Role.findByAuthority("ROLE_USER")
        if (!rm)
            rm=new Role(authority:"ROLE_USER").save()

       def adm= AuthUser.findByUsername("admin1")

        if (!adm)
            adm=new AuthUser(username:"admin1",password: "admin1",enabeld:true,accountExpired:false,
                accountLocked:false,passwordExpired:false,enabled: true,userRealName:"administrator").save()
        def radm=Role.findByAuthority("ROLE_ADMIN")
        if (!radm)
            radm=new Role(authority:"ROLE_ADMIN").save()

        def ar=AuthUserRole.findByAuthUserAndRole(adm,radm)
        if(!ar)
            ar=new AuthUserRole(authUser:adm,role:radm).save();
    }
    def destroy = {
    }
}
