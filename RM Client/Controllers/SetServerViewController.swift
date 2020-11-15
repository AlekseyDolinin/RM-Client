import UIKit
import SwiftyJSON
import Alamofire

class SetServerViewController: UIViewController, UITextFieldDelegate {
    
    var setServerView: SetServerView! {
        guard isViewLoaded else {return nil}
        return (view as! SetServerView)
    }
    
    var serverInputText = String()
    var userInputText = String()
    var passwordInputText = String()
    
    var userAuthData = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setServerView.inputServer.delegate = self
        setServerView.inputUser.delegate = self
        setServerView.inputPassword.delegate = self
        setServerView.configure()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.restorationIdentifier == "server" {
            serverInputText = textField.text!
        }
        if textField.restorationIdentifier == "user" {
            userInputText = textField.text!
        }
        if textField.restorationIdentifier == "password" {
            passwordInputText = textField.text!
        }
        if serverInputText != "" && userInputText != "" && passwordInputText != "" {
            setServerView.enterButton.isEnabled = true
        } else {
            setServerView.enterButton.isEnabled = false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.restorationIdentifier == "server" {
            serverInputText = textField.text!
        }
        if textField.restorationIdentifier == "user" {
            userInputText = textField.text!
        }
        if textField.restorationIdentifier == "password" {
            passwordInputText = textField.text!
        }
        if serverInputText != "" && userInputText != "" && passwordInputText != "" {
            setServerView.enterButton.isEnabled = true
        } else {
            setServerView.enterButton.isEnabled = false
        }
    }
    
    @IBAction func enterAction(_ sender: UIButton) {
        hideKBAction(UIButton())
        setServerView.loader.startAnimating()
        setServerView.enterButton.isHidden = true
        setServerView.inputServer.isUserInteractionEnabled = false
        setServerView.inputUser.isUserInteractionEnabled = false
        setServerView.inputPassword.isUserInteractionEnabled = false
        checkAuth(server: serverInputText, user: userInputText, password: passwordInputText)
    }
    
    func checkAuth(server: String, user: String, password: String) {
        let request = "https://\(user):\(password)@\(server)" + "/my/account.json"
        // проверка введенных данных по пользователю
        Alamofire.request(request, method: .get).responseJSON { [weak self] response in
            
            var json = JSON()
            let data = response.data
            do {
                json = try JSON(data: data!)
            } catch {
                print(error.localizedDescription)
            }
            
            if json.isEmpty {
                print("ERROR AUTH")
                // возврат состоиния если авторизация не успешна
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 , execute: {
                    self?.setServerView.loader.stopAnimating()
                    self?.setServerView.enterButton.isHidden = false
                    self?.setServerView.inputServer.isUserInteractionEnabled = true
                    self?.setServerView.inputUser.isUserInteractionEnabled = true
                    self?.setServerView.inputPassword.isUserInteractionEnabled = true
                    return
                })
            } else {
                print("AUTH SUCCESS")
                // если авторизовались без ошибок с новыми данными
                // запись новых данных в дефот для последующих входов
                self?.userAuthData = ["server": server, "user": user, "password": password]
                UserDefaults.standard.set(self?.userAuthData, forKey: "userAuthData")
                UserDefaults.standard.synchronize()
                self!.back()
            }
            
//            self?.dismiss(animated: true, completion: nil)
//            self?.fillUserData(json)
        }
    }
    
    func back() {
        print("back")
        dismiss(animated: true, completion: nil)
    }
    
    
//    // обработка данных при успешной авторизации
//    func fillUserData(_ userDataJson: JSON) {
//
//        let data = userDataJson["user"]
//
//        // хэш почты для получения аватара по почте
//        let md5HexMail = GetHashEmail.MD5(string: data["mail"].stringValue)
//
//        let avatarLink = "https://www.gravatar.com/avatar/\(md5HexMail)?s=200"
//
//        API.shared.getGlobalImage(link: avatarLink, completion: { (imageAvatar) in
//            let userData = User(admin: data["admin"].boolValue,
//                                api_key: data["api_key"].stringValue,
//                                login: data["login"].stringValue,
//                                last_login_on: data["last_login_on"].stringValue,
//                                mail: data["mail"].stringValue,
//                                lastname: data["lastname"].stringValue,
//                                firstname: data["firstname"].stringValue,
//                                id: data["id"].intValue,
//                                created_on: data["created_on"].stringValue,
//                                avatar: imageAvatar)
//
//            mainStore.dispatch(UserData(userData: userData))
//
//            // получение статусов задач по компании
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartVC")
//            self.navigationController?.pushViewController(vc!, animated: false)
//        })
//    }
    
    @IBAction func hideKBAction(_ sender: UIButton) {
        setServerView.inputServer.resignFirstResponder()
        setServerView.inputUser.resignFirstResponder()
        setServerView.inputPassword.resignFirstResponder()
    }
}
