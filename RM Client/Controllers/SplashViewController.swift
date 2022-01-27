import UIKit
import SwiftyJSON

let nEnter: NSNotification.Name = NSNotification.Name(rawValue: "nEnter")

class SplashViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // проверка есть ли данные для авторизации
        if UserDefaults.standard.dictionary(forKey: "userAuthData") != nil {
            // попытка авторизации по этим данным
            API.shared.auth { response in
                var json = JSON()
                let data = response.data
                do {
                    json = try JSON(data: data!)
                } catch {
                    print(error.localizedDescription)
                }
                Parse.parseUserData(json: json) {
                    NotificationCenter.default.post(name: nEnter, object: nil, userInfo: nil)
                }
            }
            
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SetServerViewController") as! SetServerViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    ///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ///
        NotificationCenter.default.addObserver(forName: nEnter, object: nil, queue: nil) { notification in
            self.dismiss(animated: true) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
}
