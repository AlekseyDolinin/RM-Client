import UIKit
import SwiftyJSON

class SetServerViewController: UIViewController, UITextFieldDelegate {
    
    var viewSelf: SetServerView! {
        guard isViewLoaded else {return nil}
        return (view as! SetServerView)
    }
    
    var server = String()
    var apikey = String()
    var login = String()
    var password = String()
    var userAuthData = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.inputServer.addTarget(self, action: #selector(checkInput), for: .editingChanged)
        viewSelf.inputAPIkey.addTarget(self, action: #selector(checkInput), for: .editingChanged)
        viewSelf.inputLogin.addTarget(self, action: #selector(checkInput), for: .editingChanged)
        viewSelf.inputPassword.addTarget(self, action: #selector(checkInput), for: .editingChanged)
    }
    
    ///
    @objc func checkInput() {
        self.server = viewSelf.inputServer.text!
        self.apikey = viewSelf.inputAPIkey.text!
        self.login = viewSelf.inputLogin.text!
        self.password = viewSelf.inputPassword.text!
        
        SaveUserData.save(server: self.server, apikey: self.apikey, login: self.login, password: self.password)
        viewSelf.hideShowPassword.isHidden = password.isEmpty == false ? false : true
    }
    
    ///
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    ///
    func checkInputs() -> Bool {
        
        if server.isEmpty && apikey.isEmpty && login.isEmpty && password.isEmpty {
            showAlert(message: "Необходимо ввести данные авотризации")
            return false
        }
        
        if server.isEmpty {
            showAlert(message: "Необходимо ввести сервер")
            return false
        }
        
        if apikey.isEmpty && login.isEmpty && password.isEmpty {
            showAlert(message: "Необходимо ввести apikey или логин с паролем")
            return false
        }
        
        if !login.isEmpty && password.isEmpty {
            showAlert(message: "Необходимо ввести пароль")
            return false
        }
        
        if login.isEmpty && !password.isEmpty {
            showAlert(message: "Необходимо ввести логин")
            return false
        }

        return true
    }
    
    func sendLoginData() {
        
        API.shared.auth() { response in
            self.viewSelf.unlockContent()
            var json = JSON()
            let data = response.data
            do {
                json = try JSON(data: data!)
            } catch {
                print(error.localizedDescription)
            }

            if json.isEmpty {
                print("ERROR AUTH")
                // возврат состояния если авторизация не успешна
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 , execute: {
                    self.viewSelf.unlockContent()
                    return
                })
            } else {
                print("SUCCESS AUTH")
                Parse.parseUserData(json: json) {
                    NotificationCenter.default.post(name: nEnter, object: nil, userInfo: nil)
                }
            }
        }
    }
    
    
    @IBAction func enterAction(_ sender: UIButton) {
        if checkInputs() == true {
            viewSelf.lockContent()
            sendLoginData()
        }
    }
    
}
