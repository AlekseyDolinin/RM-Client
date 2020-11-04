class User {
    
    var admin: Bool?
    var api_key: String?
    var login: String?
    var last_login_on: String?
    var mail: String?
    var lastname: String?
    var firstname: String?
    var id: Int?
    var created_on: String?
    
    init(admin: Bool? = nil,
         api_key: String? = nil,
         login: String? = nil,
         last_login_on: String? = nil,
         mail: String? = nil,
         lastname: String? = nil,
         firstname: String? = nil,
         id: Int? = nil,
         created_on: String? = nil){
        
        self.admin = admin
        self.api_key = api_key
        self.login = login
        self.last_login_on = last_login_on
        self.mail = mail
        self.lastname = lastname
        self.firstname = firstname
        self.id = id
        self.created_on = created_on
    }
}
