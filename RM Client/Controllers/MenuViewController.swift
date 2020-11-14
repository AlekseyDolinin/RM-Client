import UIKit

class MenuViewController: UIViewController {

    var menuView: MenuView! {
        guard isViewLoaded else {return nil}
        return (view as! MenuView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        menuView.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        


    }
}

