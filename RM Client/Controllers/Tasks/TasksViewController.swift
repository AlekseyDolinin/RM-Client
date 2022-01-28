import UIKit

class TasksViewController: UIViewController, UIGestureRecognizerDelegate {
    
    static let shared = TasksViewController()
    
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
        
        navigationController?.navigationBar.isHidden = true
        
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
            self.viewSelf.countAllTasks.text = String(json["issues"].count)
            self.listAllTasks = []
            for i in json["issues"].arrayValue {
                Parse.parseTask(json: i) { task in
                    self.listAllTasks.append(task)
                    self.viewSelf.tableTasks.reloadData()
                }
                if self.listAllTasks.count == json["issues"].count {
                    Parse.parseTasksForStatus(tasks: self.listAllTasks) {
                        self.selectFilterTasks()
                    }
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
        let currentNameFilter = Parse.listTasksStatuses[currentIndexFilter]
        self.listCurrentTasks = Parse.listTasksSort[currentNameFilter] ?? [Task]()
        viewSelf.collectionStatusButton.reloadData()
        viewSelf.tableTasks.reloadData()
    }
}
