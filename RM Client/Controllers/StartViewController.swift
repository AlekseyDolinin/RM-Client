import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        checkAuth()

    }
    
    func checkAuth() {
        API.shared.authentication { (resultAuth) in
            if resultAuth == true {
                print("переход после авторизации")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                self.navigationController?.pushViewController(vc!, animated: false)
            }
        }
    }
}
