import UIKit
import GoogleMobileAds

class TaskDetailViewController: UIViewController, UIGestureRecognizerDelegate, GADBannerViewDelegate {
    
    var taskDetailView: TaskDetailView! {
        guard isViewLoaded else {return nil}
        return (view as! TaskDetailView)
    }
    
    var idSelectTask = Int()
    var selectTask: Task?
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskDetailView.configure()
        
        navigationController?.interactivePopGestureRecognizer!.delegate = self
        
        taskDetailView.tableDetailInfoTask.delegate = self
        taskDetailView.tableDetailInfoTask.dataSource = self
        
//        for task in mainStore.state.userTasks {
//            if task.idTask == idSelectTask {
//                selectTask = task
//                taskDetailView.setParametersHeader(task)
//            }
//        }
        setGadBanner()
    }
    
    // авторесайз хедера таблицы
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let headerView = taskDetailView.tableDetailInfoTask.tableHeaderView else { return }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            taskDetailView.tableDetailInfoTask.tableHeaderView = headerView
            taskDetailView.tableDetailInfoTask.layoutIfNeeded()
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
  
}
