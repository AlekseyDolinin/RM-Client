import UIKit
import ReSwift

class StartViewController: UIViewController, StoreSubscriber {
    
    var startView: StartView! {
        guard isViewLoaded else {return nil}
        return (view as! StartView)
    }
    
    typealias StoreSubscriberStateType = AppState
    
    static let shared = StartViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainStore.subscribe(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mainStore.unsubscribe(self)
    }
    
    var listColorsStatus: [UIColor] = [._pinkStatus, ._violetStatus, ._orangeStatus, ._greenStatus, ._yellowStatus, ._pinkStatus, ._violetStatus, ._orangeStatus, ._greenStatus, ._yellowStatus, ._pinkStatus, ._violetStatus, ._orangeStatus, ._greenStatus, ._yellowStatus]
    
    func checkAuth() {
        self.startView.stateLabel.text = "Проверка авторизации"
        API.shared.authentication { (resultAuth) in
            // если пользователь авторизован скачиваем данные по пользователю
            if resultAuth == true {
                
                // данные по аккаунту
                self.startView.stateLabel.text = "Получение данных по аккаунту"
                API.shared.getJSON(endPoint: "/my/account", completion: { (json) in
                    let data = json["user"]
                    
                    let userData = User(admin: data["admin"].boolValue,
                                        api_key: data["api_key"].stringValue,
                                        login: data["login"].stringValue,
                                        last_login_on: data["last_login_on"].stringValue,
                                        mail: data["mail"].stringValue,
                                        lastname: data["lastname"].stringValue,
                                        firstname: data["firstname"].stringValue,
                                        id: data["id"].intValue,
                                        created_on: data["created_on"].stringValue)
                    
                    mainStore.dispatch(UserData(userData: userData))
                    
                    // получение статусов задач по компании
                    self.getStatusesTaskInCompany()
                    
                    // получение задач пользователя
//                    self.startView.stateLabel.text = "Запрос задач по аккаунту"
                    self.getTasks(offset: 0)
                })
            }
        }
    }
    
    // получение задач пользователя
    func getTasks(offset: Int) {
        self.startView.stateLabel.text = "Запрос задач пользователя"
        API.shared.getJSONPagination(
            endPoint: "/issues.json?assigned_to_id=\((mainStore.state.userData?.id)!)",
            offset: offset,
            limit: 100,
            completion: { (json) in
                
                let totalTasks = json["issues"].count
                
                var listAllTasks = [Task]()
                
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
                        
                        listAllTasks.append(task)
                        
                        mainStore.dispatch(LoadedUserTasks(userTasks: listAllTasks))
                        
                        // если скачались все задачи и статусы компании -> сортировка задач по статусам
                        if totalTasks == mainStore.state.userTasks.count {
                            mainStore.dispatch(LoadedUserTasks(userTasks: listAllTasks))
                            self.separateTasks()
                        }
                    })
                }
        })
    }
    
    func getStatusesTaskInCompany() {
        // список статусов задач
//        self.startView.stateLabel.text = "Запрос списка статусов"
        API.shared.getJSON(endPoint: "/issue_statuses") { (json) in
            
            var listTasksStatuses = [Status]()
            
            for i in 0 ..< json["issue_statuses"].count {
                let dataStatus = json["issue_statuses"][i]
                let status = Status(id: dataStatus["id"].intValue,
                                    name: dataStatus["name"].stringValue,
                                    color: self.listColorsStatus[i],
                                    arrayTasks: [])
                
                listTasksStatuses.append(status)
                mainStore.dispatch(LoadedStatusTasks(statusTasks: listTasksStatuses))
            }
        }
    }
    
    func separateTasks() {
        let listStatusTasks = mainStore.state.statusTasks
        let listAllTasks = mainStore.state.userTasks
        var transition = false
        
        for i in 0 ..< listStatusTasks.count {
            let nameFilter = listStatusTasks[i].name
            let listStatusTasksFiltered = listAllTasks.filter{ $0.status == nameFilter}
            listStatusTasks[i].arrayTasks = listStatusTasksFiltered
            
            if i == listStatusTasks.count - 1 && transition == false {
                transition = true
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                self.navigationController?.pushViewController(vc!, animated: true);
            }
        }
    }
    
    func newState(state: AppState) {
        

    }
}
