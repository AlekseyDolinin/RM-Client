import UIKit

class RootProjectsViewController: UIViewController, UIScrollViewDelegate {
    
    private var rootProjectsView: RootProjectsView! {
        guard isViewLoaded else {return nil}
        return (view as! RootProjectsView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootProjectsView.configure()
        
        let scrollView = rootProjectsView.scrollVew!
        
        scrollView.delegate = self
        
        let vcOneTab = self.storyboard?.instantiateViewController(withIdentifier: "TabOne") as UIViewController?
        addChild(vcOneTab!)
        scrollView.addSubview((vcOneTab?.view)!)
        vcOneTab?.didMove(toParent: self)
        vcOneTab?.view.frame = scrollView.bounds
        
        let vcTwoTab = self.storyboard?.instantiateViewController(withIdentifier: "TabTwo") as UIViewController?
        addChild(vcTwoTab!)
        scrollView.addSubview((vcTwoTab?.view)!)
        vcTwoTab?.didMove(toParent: self)
        vcTwoTab?.view.frame = scrollView.bounds
        
        var vcTwoFrame: CGRect = vcTwoTab!.view.frame
        vcTwoFrame.origin.x = self.view.frame.width
        vcTwoTab?.view.frame = vcTwoFrame
        
        scrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: scrollView.frame.height)
        
        NotificationCenter.default.addObserver(self, selector: #selector(moveTopView), name: NSNotification.Name(rawValue: "offset"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showContent), name: NSNotification.Name(rawValue: "showContent"), object: nil)
    }
    

    @objc private func moveTopView(notification: NSNotification) {
        
        if let off = notification.object {
            UIView.animate(withDuration: 0, animations: {
                self.rootProjectsView.viewTop.frame.origin.y = -(off as! CGFloat)
            })
        }
    }
    
    @objc private func showContent() {
        rootProjectsView.showContent()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.rootProjectsView.indicatorView.transform = CGAffineTransform(translationX: scrollView.contentOffset.x / 2, y: 0)
        })
    }

    
    @IBAction func selectTab(_ sender: UIButton) {
        if sender.tag == 1 {
            rootProjectsView.scrollVew.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        } else if sender.tag == 2 {
            rootProjectsView.scrollVew.setContentOffset(CGPoint(x: view.frame.width, y: 0), animated: true)
        }
    }

}
