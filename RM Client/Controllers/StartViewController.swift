import UIKit

class StartViewController: UIViewController {
    
    
    static var userData = User(admin: Bool(), api_key: "", login: "", last_login_on: "", mail: "", lastname: "", firstname: "", id: Int(), created_on: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth()
    }
    
    func checkAuth() {
        API.shared.authentication { (resultAuth) in
            if resultAuth == true {
                
                API.shared.getJSON(endPoint: "/my/account", completion: { (json) in
                    let userData = json["user"]
                    StartViewController.userData = User(admin: userData["admin"].boolValue,
                                    api_key: userData["api_key"].stringValue,
                                    login: userData["login"].stringValue,
                                    last_login_on: userData["last_login_on"].stringValue,
                                    mail: userData["mail"].stringValue,
                                    lastname: userData["lastname"].stringValue,
                                    firstname: userData["firstname"].stringValue,
                                    id: userData["id"].intValue,
                                    created_on: userData["created_on"].stringValue)
                    
                    print("переход после авторизации")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                    self.navigationController?.pushViewController(vc!, animated: false)
                })
            }
        }
    }
}
