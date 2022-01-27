import UIKit

class RootTasksViewController: UIViewController, UIGestureRecognizerDelegate {
    
    static let shared = RootTasksViewController()
    
    var viewSelf: RootTasksView! {
        guard isViewLoaded else {return nil}
        return (view as! RootTasksView)
    }
    
    let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = ._blue
        refresh.addTarget(self, action: #selector(refrechAction), for: .valueChanged)
        return refresh
    }()
    
    var currentIndexFilter = 0
    var offset = 0
    var listAllTasks = [Task]()
    var listCurrentTasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSelf.tableTasks.delegate = self
        viewSelf.tableTasks.dataSource = self
        viewSelf.collectionStatusButton.delegate = self
        viewSelf.collectionStatusButton.dataSource = self
        viewSelf.tableTasks.refreshControl = refreshControl
        
        getStatusTasks()
        registerNib()
    }
    
    ///
    @objc func refrechAction(sender: UIRefreshControl?) {
        DispatchQueue.main.async {
            self.getTasks()
        }
    }
    
    ///
    func getStatusTasks() {
        API.shared.getJSON(endPoint: "/issue_statuses") { (json) in
            Parse.parseTasksStatuses(json: json["issue_statuses"]) {
                self.viewSelf.collectionStatusButton.reloadData()
                self.selectFilterTasks()
            }
            self.getTasks()
        }
    }
    
    ///
    func getTasks() {
        let endPoint = "/issues.json?assigned_to_id=\(Parse.user.id)&include=attachments&"
        API.shared.getJSONPagination(endPoint: endPoint, offset: offset, limit: 100, completion: { json in
            self.refreshControl.endRefreshing()
            self.listAllTasks = []
            for i in json["issues"].arrayValue {
                Parse.parseTask(json: i) { task in
                    self.listAllTasks.append(task)
                    self.viewSelf.tableTasks.reloadData()
                }
            }
        })
    }

    ///
    func registerNib() {
        let nib = UINib(nibName: "StatusCell", bundle: nil)
        viewSelf.collectionStatusButton?.register(nib, forCellWithReuseIdentifier: "StatusCell")
        if let flowLayout = viewSelf.collectionStatusButton?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    ///
    func selectFilterTasks() {
        
//        currentColor = Parse.listColorsStatus[index]
        
//        print("выбрана фильтрация: \(Parse.listTasksStatuses[index].name)")
//        //
//        currentIndexFilter = index
//        viewSelf.collectionStatusButton.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        
//        
//        switch index {
//        case 0:
//            listCurrentTasks = listAllTasks.filter({$0.status == .new})
//        case 1:
//            listCurrentTasks = listAllTasks.filter({$0.status == .new})
//        case 1:
//            listCurrentTasks = listAllTasks.filter({$0.status == .new})
//        case 1:
//            listCurrentTasks = listAllTasks.filter({$0.status == .new})
//        case 1:
//            listCurrentTasks = listAllTasks.filter({$0.status == .new})
//        case 1:
//            listCurrentTasks = listAllTasks.filter({$0.status == .new})
//        default:
//            break
//        }
        
        
        
        
        // задачи по выбранному фильтру
//        let tasks: [Task] = mainStore.state.statusTasks[index].arrayTasks
        
//        let message: [String: [Task]] = ["tasks": tasks]
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTasks"), object: nil, userInfo: message)
        
        
        viewSelf.collectionStatusButton.reloadData()
    }
}
