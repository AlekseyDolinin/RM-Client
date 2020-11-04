import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
       
//        API.shared.getJSON(endPoint: "/issues/74899") { (json) in
//            print(json)
//        }
        
        
        API.shared.getJSONPagination(endPoint: "/issues/74899", offset: 1, limit: 100) { (json) in
            print(json)
        }
    }
}
