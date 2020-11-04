import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
       
        API.shared.getJSON(endPoint: "/groups") { (json) in
            print(json)
        }
    }
}
