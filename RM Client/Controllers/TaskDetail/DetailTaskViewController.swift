import UIKit
import GoogleMobileAds

class TaskDetailViewController: UIViewController, UIGestureRecognizerDelegate, GADBannerViewDelegate {
    
    var viewSelf: TaskDetailView! {
        guard isViewLoaded else {return nil}
        return (view as! TaskDetailView)
    }
    
    var task: Task!
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSelf.tableDetailInfoTask.delegate = self
        viewSelf.tableDetailInfoTask.dataSource = self
        navigationController?.interactivePopGestureRecognizer!.delegate = self
        
        viewSelf.task = self.task
        viewSelf.configure()

        setGadBanner()
    }
    
    // авторесайз хедера таблицы
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let headerView = viewSelf.tableDetailInfoTask.tableHeaderView else { return }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            viewSelf.tableDetailInfoTask.tableHeaderView = headerView
            viewSelf.tableDetailInfoTask.layoutIfNeeded()
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
