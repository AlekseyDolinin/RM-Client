import UIKit

class TasksViewController: UIViewController {

    var tasksView: TasksView! {
        guard isViewLoaded else {return nil}
        return (view as! TasksView)
    }
    
    var listTasks = [Task]()
    var listFilteredTasks = [Task]()
    
    var totalTasks = Int()
    var offset = 0
    
    var titlesStatusArray = ["Новая", "В работе", "Обратная связь", "Решеные", "Закрытые"]
    var colorsStatusArray = ["_pinkStatus", "_violetStatus", "_orangeStatus", "_greenStatus", "_yellowStatus"]
    
    var currentStatus = "Новая"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksView.configure()
        
        tasksView.tableTasks.delegate = self
        tasksView.tableTasks.dataSource = self
        
        tasksView.collectionStatusButton.delegate = self
        tasksView.collectionStatusButton.dataSource = self
        
        currentStatus = titlesStatusArray[0]
        
        registerNib()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if listTasks.isEmpty {
            print("запрос задач")
            getTasks(offset: offset)
        }
    }
    
    func registerNib() {
        let nib = UINib(nibName: StatusCell.nibName, bundle: nil)
        tasksView.collectionStatusButton?.register(nib, forCellWithReuseIdentifier: StatusCell.reuseIdentifier)
        if let flowLayout = tasksView.collectionStatusButton?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func getTasks(offset: Int) {
        API.shared.getJSONPagination(endPoint: "/issues.json?assigned_to_id=\(StartViewController.userData.id)", offset: offset, limit: 1000, completion: { (json) in
            
            self.totalTasks = json["total_count"].intValue
            self.tasksView.countAllTasks.text = json["total_count"].stringValue
            
            for i in json["issues"] {
                let taskData = i.1
                var listCustomFields = [CustomField]()

//                print(taskData)
                
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

                self.listTasks.append(task)
                self.listFilteredTasks = self.listTasks.filter{ $0.status == self.currentStatus}
                
                let alpha = self.listFilteredTasks.isEmpty ? 1 : 0
                self.tasksView.stateEmtyView(CGFloat(alpha))
                
            }
            
            self.tasksView.reloadContent()
            self.tasksView.showContent()
        })
    }
}
