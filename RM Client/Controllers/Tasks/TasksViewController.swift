import UIKit

class TasksViewController: UIViewController {

    private var tasksView: TasksView! {
        guard isViewLoaded else {return nil}
        return (view as! TasksView)
    }
    
    var listTasks = [Task]()
    var totalTasks = Int()
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksView.tableTasks.delegate = self
        tasksView.tableTasks.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(12)
        if listTasks.isEmpty {
            print("запрос задач")
            getTasks(offset: offset)
        }
    }
    
    func getTasks(offset: Int) {
        API.shared.getJSONPagination(endPoint: "/issues.json?assigned_to_id=\(StartViewController.userData.id)", offset: offset, limit: 1000, completion: { (json) in
            self.totalTasks = json["total_count"].intValue
            print("всего задач: \(self.totalTasks)")

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

                self.listTasks.append(task)
//                self.listIssues = self.listIssues.sorted(by: {$0.name < $1.name})
            }
            self.tasksView.tableTasks.reloadData()
        })
    }
}
