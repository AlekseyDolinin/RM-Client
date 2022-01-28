import UIKit
import SafariServices
import WebKit

class SafariViewController: SFSafariViewController, SFSafariViewControllerDelegate {
    
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
//        UIApplication.shared.statusBarUIView?.isHidden = true
        dismissButtonStyle = .close
        modalPresentationCapturesStatusBarAppearance = true
        
        ///
        view.backgroundColor = ._backgroundDark
        preferredControlTintColor = ._blue
        preferredBarTintColor = ._blue
    }

//    ///
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
////        appDelegate.deviceOrientation = .all
//        let value = UIInterfaceOrientation.unknown.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
//    }
      
    ///
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
////        appDelegate.deviceOrientation = .portrait
//        let value = UIInterfaceOrientation.portrait.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
////        UIApplication.shared.statusBarUIView?.isHidden = false
//    }
    
    ///
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("safariViewControllerDidFinish")
    }
    
    ///
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        print("initialLoadDidRedirectTo URL: \(URL)")
    }
    
    ///
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print("didCompleteInitialLoad")
    }
    
    ///
    func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
        return [UIActivity]()
    }
    
    ///
    func safariViewController(_ controller: SFSafariViewController, excludedActivityTypesFor URL: URL, title: String?) -> [UIActivity.ActivityType] {
        return [UIActivity.ActivityType]()
    }
}
