import UIKit

class TabbarViewController: UITabBarController {
    
    var currentTab = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        setupVCs()

    }
    
    ///
    func setupVCs() {
        let tasks   = UIStoryboard(name: "Tasks",   bundle: nil).instantiateViewController(withIdentifier: "TasksViewController")
        let projects = UIStoryboard(name: "Projects", bundle: nil).instantiateViewController(withIdentifier: "ProjectsViewController")
//        let testing = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController")
        let menu = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController")
        
        viewControllers = [
            createNavController(for: tasks,     title: "Tasks",       image: UIImage(named: "taskIconTabBar")!),
            createNavController(for: projects,   title: "Projects",    image: UIImage(named: "projectIconTabBar")!),
//            createNavController(for: testing,   title: "Испытания",     image: UIImage(named: "testing")!),
            createNavController(for: menu,   title: "Menu",    image: UIImage(named: "menuIconTabBar")!)
        ]
    }
    
//    ///
//    @objc func setBadge() {
//        let traningBadge = GeneralViewController.nCount.arenaNCount
//        let testingBadge =  GeneralViewController.nCount.arenaTrialsNCount + GeneralViewController.nCount.questNCount + GeneralViewController.nCount.tournamentNCount
//        for (index, value) in (viewControllers!).enumerated() {
//            switch index {
//            case 1:
//                value.tabBarItem.badgeValue = traningBadge == 0 ? nil : "\(traningBadge)"
//            case 2:
//                value.tabBarItem.badgeValue = testingBadge == 0 ? nil : "\(testingBadge)"
//            default:
//                break
//            }
//        }
//    }
    
    ///
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
