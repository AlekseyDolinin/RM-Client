import UIKit

class RootTasksViewController: UIViewController, UIScrollViewDelegate {
    
    static let shared = RootTasksViewController()
    
    var rootTasksView: RootTasksView! {
        guard isViewLoaded else {return nil}
        return (view as! RootTasksView)
    }
    
    var listStatusTasks: [[String: Any]] = [
        ["tagFilter": "Новая",          "name": "Новые",            "color": UIColor._pinkStatus,   "tasks": [Task]()],
        ["tagFilter": "В работе",       "name": "В работе",         "color": UIColor._violetStatus, "tasks": [Task]()],
        ["tagFilter": "Обратная связь", "name": "Обратная связь",   "color": UIColor._orangeStatus, "tasks": [Task]()],
        ["tagFilter": "Решённые",       "name": "Решённые",         "color": UIColor._greenStatus,  "tasks": [Task]()],
        ["tagFilter": "Закрытые",       "name": "Закрытые",         "color": UIColor._yellowStatus, "tasks": [Task]()]
    ]
    
    var countTaskByStatus = [[String: Int]]()
    
    var currentIndexFilter = 0
    
    var listAllTasks = [Task]()
    
    var totalTasks = Int()
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootTasksView.configure()
        
        rootTasksView.collectionStatusButton.delegate = self
        rootTasksView.collectionStatusButton.dataSource = self
        
        registerNib()
        
        rootTasksView.scrollView.delegate = self
        
        createVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if listAllTasks.isEmpty {
            print("запрос задач")
            getTasks(offset: offset)
        }
    }
    
    func createVC() {
        let scroll = rootTasksView.scrollView!
        for i in 1...listStatusTasks.count {
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
        scroll.contentSize = CGSize(width: self.view.frame.width * CGFloat(listStatusTasks.count), height: scroll.frame.height)
    }
    
    func registerNib() {
        let nib = UINib(nibName: StatusCell.nibName, bundle: nil)
        rootTasksView.collectionStatusButton?.register(nib, forCellWithReuseIdentifier: StatusCell.reuseIdentifier)
        if let flowLayout = rootTasksView.collectionStatusButton?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func getTasks(offset: Int) {
        API.shared.getJSONPagination(
            endPoint: "/issues.json?assigned_to_id=\(StartViewController.userData.id!)",
            offset: offset,
            limit: 1000,
            completion: { (json) in
                
                self.totalTasks = json["total_count"].intValue
                self.rootTasksView.countAllTasks.text = json["total_count"].stringValue
                
                for i in json["issues"] {
                    let idTask = i.1["id"].intValue
                    
                    API.shared.getDataTask(endPoint: "/issues/\(idTask)", completion: { (json) in
                        
                        let dataTask = json["issue"]
                        
                        var listCustomFields = [CustomField]()
                        
                        for i in dataTask["custom_fields"] {
                            let customFieldData = i.1
                            let customField = CustomField(id: customFieldData["id"].intValue,
                                                          name: customFieldData["name"].stringValue,
                                                          value: customFieldData["value"].stringValue)
                            listCustomFields.append(customField)
                        }
                        
                        var listAttachments = [Attachment]()
                        
                        for i in dataTask["attachments"] {
                            let attachmentData = i.1
                            let attachment = Attachment(id: attachmentData["id"].intValue,
                                                        fileName: attachmentData["filename"].stringValue,
                                                        createdOn: attachmentData["created_on"].stringValue,
                                                        thumbnail_url: attachmentData["thumbnail_url"].stringValue,
                                                        author: attachmentData["author"]["name"].stringValue,
                                                        filesize: attachmentData["filesize"].intValue,
                                                        description: attachmentData["description"].stringValue,
                                                        content_type: attachmentData["content_type"].stringValue,
                                                        content_url: attachmentData["content_url"].stringValue)
                            listAttachments.append(attachment)
                        }
                        
                        let task = Task(doneRatio: dataTask["done_ratio"].intValue,
                                        startDate: dataTask["start_date"].stringValue,
                                        createdOn: dataTask["created_on"].stringValue,
                                        tracker: dataTask["tracker"]["name"].stringValue,
                                        author: dataTask["author"]["name"].stringValue,
                                        dueDate: dataTask["due_date"].stringValue,
                                        subject: dataTask["subject"].stringValue,
                                        isPrivate: dataTask["is_private"].boolValue,
                                        assignedTo: dataTask["assigned_to"]["name"].stringValue,
                                        category: dataTask["category"]["name"].stringValue,
                                        estimatedHours: dataTask["estimated_hours"].doubleValue,
                                        customFields: listCustomFields,
                                        priority: dataTask["priority"]["name"].stringValue,
                                        id: dataTask["id"].intValue,
                                        parent: dataTask["parent"]["id"].intValue,
                                        updatedOn: dataTask["updated_on"].stringValue,
                                        closedOn: dataTask["closed_on"].boolValue,
                                        status: dataTask["status"]["name"].stringValue,
                                        description: dataTask["description"].stringValue,
                                        project: dataTask["project"]["name"].stringValue,
                                        attachments: listAttachments)
                        
                        self.listAllTasks.append(task)
                        if self.listAllTasks.count == self.totalTasks {
                            self.separateTasks(self.listAllTasks)
                            self.selectFilterTasks(0)
                            self.rootTasksView.showContent()
                        }
                    })
                }
        })
    }
    
    func selectFilterTasks(_ index: Int) {
        print("выбрана фильтрация: \(listStatusTasks[index]["name"])")
        
        // переключение таблиц с тасками (скрол)
        let width = view.frame.width
        rootTasksView.scrollView.setContentOffset(CGPoint(x: width * CGFloat(index), y: 0), animated: true)
        
        // нажатие таба при скроле
        currentIndexFilter = index
        rootTasksView.collectionStatusButton.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        rootTasksView.collectionStatusButton.reloadData()
        
        let message: [String: [Task]] = ["tasks": listStatusTasks[index]["tasks"] as! Array<Task>]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTasks"), object: nil, userInfo: message)
        
    }
    
    func separateTasks(_ tasks: [Task]) {
        for i in 0..<listStatusTasks.count {
            let tagFilter: String = listStatusTasks[i]["tagFilter"] as! String
            listStatusTasks[i]["tasks"] = tasks.filter{ $0.status == tagFilter}
        }
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
