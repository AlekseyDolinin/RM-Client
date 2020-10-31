class User {
    
    var admin: Bool
    var api_key: String
    var login: String
    var last_login_on: String
    var mail: String
    var lastname: String
    var firstname: String
    var id: Int
    var created_on: String
    
    init(admin: Bool,
         api_key: String,
         login: String,
         last_login_on: String,
         mail: String,
         lastname: String,
         firstname: String,
         id: Int,
         created_on: String){
        
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
