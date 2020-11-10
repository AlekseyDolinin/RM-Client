import UIKit

class RootTasksViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    static let shared = RootTasksViewController()
    
    var rootTasksView: RootTasksView! {
        guard isViewLoaded else {return nil}
        return (view as! RootTasksView)
    }
    
    var currentIndexFilter = 0
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer!.delegate = self
        
        rootTasksView.configure()
        
        rootTasksView.collectionStatusButton.delegate = self
        rootTasksView.collectionStatusButton.dataSource = self
        
        registerNib()
        rootTasksView.scrollView.delegate = self
        createVC()
        
        rootTasksView.countAllTasks.text = String(mainStore.state.userTasks.count)
        selectFilterTasks(currentIndexFilter)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        rootTasksView.collectionStatusButton.reloadData()
        rootTasksView.showContent()
    }
    
    func createVC() {
        let scroll = rootTasksView.scrollView!
        for i in 1...mainStore.state.statusTasks.count {
            let vcTab = self.storyboard?.instantiateViewController(withIdentifier: "TasksVC") as UIViewController?
            addChild(vcTab!)
            scroll.addSubview((vcTab?.view)!)
            vcTab?.didMove(toParent: self)
            vcTab?.view.frame = scroll.bounds
            
            if i != 1 {
                var vcFrame: CGRect = vcTab!.view.frame
                vcFrame.origin.x = (self.view.frame.width) * CGFloat(i - 1)
                vcTab?.view.frame = vcFrame
            }
        }
        scroll.contentSize = CGSize(width: self.view.frame.width * CGFloat(mainStore.state.statusTasks.count), height: scroll.frame.height)
    }
    
    func registerNib() {
        let nib = UINib(nibName: StatusCell.nibName, bundle: nil)
        rootTasksView.collectionStatusButton?.register(nib, forCellWithReuseIdentifier: StatusCell.reuseIdentifier)
        if let flowLayout = rootTasksView.collectionStatusButton?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func selectFilterTasks(_ index: Int) {
//        print("выбрана фильтрация: \(mainStore.state.statusTasks[index].name)")
        
        // переключение таблиц с тасками (скрол)
        let width = view.frame.width
        rootTasksView.scrollView.setContentOffset(CGPoint(x: width * CGFloat(index), y: 0), animated: true)
        
        // нажатие таба при скроле
        currentIndexFilter = index
        rootTasksView.collectionStatusButton.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        rootTasksView.collectionStatusButton.reloadData()
        
        // задачи по выбранному фильтру
        let tasks: [Task] = mainStore.state.statusTasks[index].arrayTasks
        
        let message: [String: [Task]] = ["tasks": tasks]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTasks"), object: nil, userInfo: message)
    }
}

extension RootTasksViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // переключение табов скролом таблиц
        if scrollView == rootTasksView.scrollView {
            if scrollView.currentPage > 0 {
                selectFilterTasks(scrollView.currentPage - 1)
            }
        }
    }
}
