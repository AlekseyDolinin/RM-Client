import UIKit

class RootTasksViewController: UIViewController, UIScrollViewDelegate {
    
    static let shared = RootTasksViewController()
    
    var rootTasksView: RootTasksView! {
        guard isViewLoaded else {return nil}
        return (view as! RootTasksView)
    }
    
    let listStatusTasks: [[String: Any]] = [["tagFilter": "Новая",              "name": "Новые",            "color": UIColor._pinkStatus],
                                            ["tagFilter": "В работе",           "name": "В работе",         "color": UIColor._violetStatus],
                                            ["tagFilter": "Обратная связь",     "name": "Обратная связь",   "color": UIColor._orangeStatus],
                                            ["tagFilter": "Решённые",           "name": "Решённые",         "color": UIColor._greenStatus],
                                            ["tagFilter": "Закрытые",           "name": "Закрытые",         "color": UIColor._yellowStatus]]
        
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
                let taskData = i.1
                var listCustomFields = [CustomField]()
                
                for i in taskData["custom_fields"] {
                    let customFieldData = i.1
                    let customField = CustomField(id: customFieldData["id"].intValue, name: customFieldData["name"].stringValue, value: customFieldData["value"].stringValue)
                    listCustomFields.append(customField)
                }
                let task = Task(doneRatio: taskData["done_ratio"].intValue,
                                startDate: taskData["start_date"].stringValue,
                                createdOn: taskData["created_on"].stringValue,
                                tracker: taskData["tracker"]["name"].stringValue,
                                author: taskData["author"]["name"].stringValue,
                                dueDate: taskData["due_date"].stringValue,
                                subject: taskData["subject"].stringValue,
                                isPrivate: taskData["is_private"].boolValue,
                                assignedTo: taskData["assigned_to"]["name"].stringValue,
                                category: taskData["category"]["name"].stringValue,
                                estimatedHours: taskData["estimated_hours"].doubleValue,
                                customFields: listCustomFields,
                                priority: taskData["priority"]["name"].stringValue,
                                id: taskData["id"].intValue,
                                parent: taskData["parent"]["id"].intValue,
                                updatedOn: taskData["updated_on"].stringValue,
                                closedOn: taskData["closed_on"].boolValue,
                                status: taskData["status"]["name"].stringValue,
                                description: taskData["description"].stringValue,
                                project: taskData["project"]["name"].stringValue)
                
                self.listAllTasks.append(task)
            }
            self.filteredArrayTasks(0)
            self.rootTasksView.showContent()
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
        
        filteredArrayTasks(index)
    }
    
    // фильтрация массива с задачами
    func filteredArrayTasks(_ indexFilter: Int) {
        let tagFilter: String = self.listStatusTasks[indexFilter]["tagFilter"] as! String
        let listFilteredTasks = self.listAllTasks.filter{ $0.status == tagFilter}
        let message: [String: [Task]] = ["tasks": listFilteredTasks]
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
