import UIKit
import GoogleMobileAds

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.unselectedItemTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4035926871)
        tabBarController?.tabBar.isTranslucent = false
    }
}
