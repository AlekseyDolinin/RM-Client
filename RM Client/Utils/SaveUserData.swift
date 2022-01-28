import UIKit

class SaveUserData: NSObject {
    
    class func save(server: String, apikey: String, login: String, password: String) {
        let userAuthData = ["server": server, "apikey": apikey, "login": login, "password": password]
        UserDefaults.standard.set(userAuthData, forKey: "userAuthData")
    }
}
