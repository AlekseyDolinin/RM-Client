import UIKit
import SwiftyJSON

class SplashViewController: UIViewController {
    
    var userAuthData = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(12)
//        //если есть записанные данные по пользователю
//        // попытка авторизации по этим данным
//        if UserDefaults.standard.dictionary(forKey: "userAuthData") != nil {
//            userAuthData = UserDefaults.standard.dictionary(forKey: "userAuthData") as! [String : String]
//            let defaultServer: String = userAuthData["server"]!
//            let defaultUser: String = userAuthData["user"]!
//            let defaultPassword: String = userAuthData["password"]!
//            checkAuth(server: defaultServer, user: defaultUser, password: defaultPassword)
//        } else {
//            print("НЕТ ЗАПИСАНЫХ ДАННЫХ В ДЕФОЛТЕ")
//            // показ модалки для введения данных
//            let vc = storyboard?.instantiateViewController(withIdentifier: "SetServerVC")
//            navigationController?.pushViewController(vc!, animated: false)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {

        //если есть записанные данные по пользователю
        // попытка авторизации по этим данным
        if UserDefaults.standard.dictionary(forKey: "userAuthData") != nil {
            userAuthData = UserDefaults.standard.dictionary(forKey: "userAuthData") as! [String : String]
            let defaultServer: String = userAuthData["server"]!
            let defaultUser: String = userAuthData["user"]!
            let defaultPassword: String = userAuthData["password"]!
            checkAuth(server: defaultServer, user: defaultUser, password: defaultPassword)
        } else {
            print("НЕТ ЗАПИСАНЫХ ДАННЫХ В ДЕФОЛТЕ")
            // показ модалки для введения данных
            let vc = storyboard?.instantiateViewController(withIdentifier: "SetServerVC")
            vc?.modalPresentationStyle = .fullScreen
            present(vc!, animated: true, completion: nil)
        }
    }
    
    
    // авторизация
    func checkAuth(server: String, user: String, password: String) {
        // проверка введенных данных по пользователю
        API.shared.authentication(server: server, user: user, password: password) { [weak self] (response) in
            var json = JSON()
            let data = response.data
            do {
                json = try JSON(data: data!)
            } catch {
                print(error.localizedDescription)
            }
            if json.isEmpty {
                print("ERROR AUTH")
                // ошибка при авторизации по записанным данным
                // показ модалки для введения данных
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "SetServerVC")
                self?.present(vc!, animated: true, completion: nil)
            } else {
                // заполнение данных пользователя
                //если авотризация по записанным данным успешна
                self?.fillUserData(json)
            }
        }
    }
    
    // обработка данных при успешной авторизации
    func fillUserData(_ userDataJson: JSON) {
        let data = userDataJson["user"]
        
        // хэш почты для получения аватара по почте
        let md5HexMail = GetHashEmail.MD5(string: data["mail"].stringValue)
        
        let avatarLink = "https://www.gravatar.com/avatar/\(md5HexMail)?s=200"
        
        API.shared.getGlobalImage(link: avatarLink, completion: { [weak self] (imageAvatar) in
            let userData = User(admin: data["admin"].boolValue,
                                api_key: data["api_key"].stringValue,
                                login: data["login"].stringValue,
                                last_login_on: data["last_login_on"].stringValue,
                                mail: data["mail"].stringValue,
                                lastname: data["lastname"].stringValue,
                                firstname: data["firstname"].stringValue,
                                id: data["id"].intValue,
                                created_on: data["created_on"].stringValue,
                                avatar: imageAvatar)
            
            mainStore.dispatch(UserData(userData: userData))
            
            // переход далее при корректной авторизации
            // и заполнении данных пользователя
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "StartVC")
            self?.navigationController?.pushViewController(vc!, animated: false)
        })
    }
}
