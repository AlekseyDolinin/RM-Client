import UIKit

class RootTasksViewController: UIViewController, UIScrollViewDelegate {
    
    var rootTasksView: RootTasksView! {
        guard isViewLoaded else {return nil}
        return (view as! RootTasksView)
    }
    
    var titlesStatusArray = ["Новая", "В работе", "Обратная связь", "Решеные", "Закрытые"]
    var colorsStatusArray = ["_pinkStatus", "_violetStatus", "_orangeStatus", "_greenStatus", "_yellowStatus"]
    
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
        
        let scrollView = rootTasksView.scrollView!
        
        scrollView.delegate = self
        
        //
        let vcOneTab = self.storyboard?.instantiateViewController(withIdentifier: "TasksVC") as UIViewController?
        addChild(vcOneTab!)
        scrollView.addSubview((vcOneTab?.view)!)
        vcOneTab?.didMove(toParent: self)
        vcOneTab?.view.frame = scrollView.bounds
        
        //
        let vcTwoTab = self.storyboard?.instantiateViewController(withIdentifier: "TasksVC") as UIViewController?
        addChild(vcTwoTab!)
        scrollView.addSubview((vcTwoTab?.view)!)
        vcTwoTab?.didMove(toParent: self)
        vcTwoTab?.view.frame = scrollView.bounds
        
        var vcTwoFrame: CGRect = vcTwoTab!.view.frame
        vcTwoFrame.origin.x = self.view.frame.width
        vcTwoTab?.view.frame = vcTwoFrame
        
        //
        let vcThreeTab = self.storyboard?.instantiateViewController(withIdentifier: "TasksVC") as UIViewController?
        addChild(vcThreeTab!)
        scrollView.addSubview((vcThreeTab?.view)!)
        vcThreeTab?.didMove(toParent: self)
        vcThreeTab?.view.frame = scrollView.bounds
        
        var vcThreeFrame: CGRect = vcThreeTab!.view.frame
        vcThreeFrame.origin.x = self.view.frame.width * 2
        vcThreeTab?.view.frame = vcThreeFrame
        
        //
        let vcFourTab = self.storyboard?.instantiateViewController(withIdentifier: "TasksVC") as UIViewController?
        addChild(vcFourTab!)
        scrollView.addSubview((vcFourTab?.view)!)
        vcFourTab?.didMove(toParent: self)
        vcFourTab?.view.frame = scrollView.bounds
        
        var vcFourFrame: CGRect = vcFourTab!.view.frame
        vcFourFrame.origin.x = self.view.frame.width * 3
        vcFourTab?.view.frame = vcFourFrame
        
        //
        let vcFiveTab = self.storyboard?.instantiateViewController(withIdentifier: "TasksVC") as UIViewController?
        addChild(vcFiveTab!)
        scrollView.addSubview((vcFiveTab?.view)!)
        vcFiveTab?.didMove(toParent: self)
        vcFiveTab?.view.frame = scrollView.bounds
        
        var vcFiveFrame: CGRect = vcFiveTab!.view.frame
        vcFiveFrame.origin.x = self.view.frame.width * 4
        vcFiveTab?.view.frame = vcFiveFrame
        
        scrollView.contentSize = CGSize(width: self.view.frame.width * 5, height: scrollView.frame.height)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if listAllTasks.isEmpty {
            print("запрос задач")
            getTasks(offset: offset)
        }
    }
    
    func registerNib() {
        let nib = UINib(nibName: StatusCell.nibName, bundle: nil)
        rootTasksView.collectionStatusButton?.register(nib, forCellWithReuseIdentifier: StatusCell.reuseIdentifier)
        if let flowLayout = rootTasksView.collectionStatusButton?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }

    func getTasks(offset: Int) {
        API.shared.getJSONPagination(endPoint: "/issues.json?assigned_to_id=\(StartViewController.userData.id)", offset: offset, limit: 1000, completion: { (json) in
            
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
            self.rootTasksView.collectionStatusButton.reloadData()
        })
    }
    
    func selectFilterTasks(_ index: Int) {
        print("выбрана фильтрация: \(titlesStatusArray[index])")
        
        // переключение таблиц с тасками (скрол)
        let width = view.frame.width
        rootTasksView.scrollView.setContentOffset(CGPoint(x: width * CGFloat(index), y: 0), animated: true)
        
        // нажатие таба при скроле
        currentIndexFilter = index
        rootTasksView.collectionStatusButton.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        rootTasksView.collectionStatusButton.reloadData()
        
        filteredArrayTasks(index)
    }
    
    func filteredArrayTasks(_ indexFilter: Int) {
        let listFilteredTasks = self.listAllTasks.filter{ $0.status == self.titlesStatusArray[indexFilter]}
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
