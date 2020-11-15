import UIKit

class RootProjectsView: UIView {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var butonTabOne: UIButton!
    @IBOutlet weak var butonTabTwo: UIButton!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var scrollVew: UIScrollView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var allCountProjectLabel: UILabel!
    
    
    func configure() {
        
//        hideContent()
    }
    
    func hideContent() {
        viewTop.alpha = 0
        scrollVew.alpha = 0
        loader.startAnimating()
    }
    
    func showContent() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.viewTop.alpha = 1
            self?.scrollVew.alpha = 1
        }
        loader.stopAnimating()
    }

}
