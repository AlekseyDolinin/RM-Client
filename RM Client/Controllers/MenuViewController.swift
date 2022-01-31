import UIKit

class MenuViewController: UIViewController {

    var viewSelf: MenuView! {
        guard isViewLoaded else {return nil}
        return (view as! MenuView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    ///
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "userAuthData")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootNC")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    ///
    @IBAction func logout(_ sender: UIButton) {
        let alert = UIAlertController(title: "Выйти из аккаунта?", message: "Для входа потребуется ввод данных для авторизации", preferredStyle: .alert)
        let outAction = UIAlertAction(title: "LogOut", style: .destructive) { UIAlertAction in
            self.logOut()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        alert.addAction(outAction)
        present(alert, animated: true)
        
    }
}

