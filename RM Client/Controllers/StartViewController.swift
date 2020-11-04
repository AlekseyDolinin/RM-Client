import UIKit

class StartViewController: UIViewController {
    
    static var userData = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth()
    }
    
    func checkAuth() {
        API.shared.authentication { (resultAuth) in
            if resultAuth == true {
                
                
//                API.shared.getJSON(endPoint: "/projects/271/memberships") { (json) in
//                    print(json)
//                }
//
//                API.shared.getJSON(endPoint: "/issues/78716/relations") { (json) in
//                    print(json)
//                }
//
//                API.shared.getJSON(endPoint: "/queries") { (json) in
//                    print(json)
//                }
//
//                // список статусов задач
//                API.shared.getJSON(endPoint: "/issue_statuses") { (json) in
//                    print(json)
//                }
//
//                // список трекеров задач
//                API.shared.getJSON(endPoint: "/trackers") { (json) in
//                    print(json)
//                }
//
//                // список приоритетов задач (низкий, нормальный, высокий)
//                API.shared.getJSON(endPoint: "/enumerations/issue_priorities") { (json) in
//                    print(json)
//                }
//
//                // категории задач, доступные для проекта с заданным идентификатором
//                API.shared.getJSON(endPoint: "/projects/309/issue_categories") { (json) in
//                    print(json)
//                }
//
//                // список ролей в компании
//                API.shared.getJSON(endPoint: "/roles") { (json) in
//                    print(json)
//                }
                
                
                // данные по аккаунту
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
