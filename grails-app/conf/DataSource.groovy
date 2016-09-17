dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    dialect = org.hibernate.dialect.MySQL5InnoDBDialect
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
//            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
//            url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
            username = "nicefamilytree"
            password = "nicefamilytree"
            url = "jdbc:mysql://localhost/nicefamilytree?useUnicode=yes&characterEncoding=UTF-8"

        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    production {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
            username = "nicefamilytree"
            password = "nicefamilytree"
            url = "jdbc:mysql://localhost:3306/nicefamilytree?useUnicode=yes&characterEncoding=UTF-8"
//            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
//            driverClassName = "com.mysql.jdbc.Driver"
//            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
//            username = "nicefamilytree"
//            password = "nicefamilytree"
//            url = "jdbc:mysql://localhost/nicefamilytree?useUnicode=yes&characterEncoding=UTF-8"

        }
    }
}
