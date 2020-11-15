import UIKit
import Alamofire
import SwiftyJSON

class StartViewController: UIViewController {
    
    var startView: StartView! {
        guard isViewLoaded else {return nil}
        return (view as! StartView)
    }
    
    static let shared = StartViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // получение статусов задач по компании
        getStatusesTaskInCompany()

        // получение задач пользователя
        getTasks(offset: 0)
        
        getProjects(offset: 0)
    }
    
    var listColorsStatus: [UIColor] = [._pinkStatus, ._violetStatus, ._orangeStatus, ._greenStatus, ._yellowStatus, ._pinkStatus, ._violetStatus, ._orangeStatus, ._greenStatus, ._yellowStatus, ._pinkStatus, ._violetStatus, ._orangeStatus, ._greenStatus, ._yellowStatus]

    
    // получение списка пользователей
    // работает только для админов
    func getUsersCompany() {
        print("ПОЛУЧЕНИЕ СПИСКА ПОЛЬЗОВАТЕЛЕЙ")
        API.shared.getJSON(endPoint: "/users") { (json) in
            print(json)
        }
    }
    
    // получение задач пользователя
    func getTasks(offset: Int) {
        API.shared.getJSONPagination(
            endPoint: "/issues.json?assigned_to_id=\((mainStore.state.userData?.id)!)&include=attachments&",
            offset: offset,
            limit: 10,
            completion: { (json) in
                
                let totalTasks = json["issues"].count
                var listAllTasks = [Task]()

                for i in json["issues"] {
                    
                    var listCustomFields = [CustomField]()
                    var listAttachments = [Attachment]()
                    
                    let dataTask = i.1
                    
                    for i in dataTask["custom_fields"] {
                        let customFieldData = i.1
                        let customField = CustomField(id: customFieldData["id"].intValue,
                                                      name: customFieldData["name"].stringValue,
                                                      value: customFieldData["value"].stringValue)
                        listCustomFields.append(customField)
                    }
                    
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
                                    avatarAuthor: UIImage(),
                                    dueDate: dataTask["due_date"].stringValue,
                                    subject: dataTask["subject"].stringValue,
                                    isPrivate: dataTask["is_private"].boolValue,
                                    assignedTo: dataTask["assigned_to"]["name"].stringValue,
                                    category: dataTask["category"]["name"].stringValue,
                                    estimatedHours: dataTask["estimated_hours"].doubleValue,
                                    customFields: listCustomFields,
                                    priority: dataTask["priority"]["name"].stringValue,
                                    idTask: dataTask["id"].intValue,
                                    parent: dataTask["parent"]["id"].intValue,
                                    updatedOn: dataTask["updated_on"].stringValue,
                                    closedOn: dataTask["closed_on"].boolValue,
                                    status: dataTask["status"]["name"].stringValue,
                                    description: dataTask["description"].stringValue,
                                    project: dataTask["project"]["name"].stringValue,
                                    projectID: dataTask["project"]["id"].intValue,
                                    attachments: listAttachments)
                    
                    listAllTasks.append(task)
                    mainStore.dispatch(LoadedUserTasks(userTasks: listAllTasks))
                    
                    // если скачались все задачи и статусы компании -> сортировка задач по статусам
                    if totalTasks == mainStore.state.userTasks.count {
                        mainStore.dispatch(LoadedUserTasks(userTasks: listAllTasks))
                        self.separateTasks()
                    }
                }
        })
    }
    
    func getStatusesTaskInCompany() {
        // список статусов задач
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
    
    func getProjects(offset: Int) {
        
//        var dictionaryParentsProject = [Int: Project]()
//        var arrayChildsProject = [Project]()
        var listProjects = [Project]()
        
        API.shared.getJSONPagination(endPoint: "/projects.json?", offset: offset, limit: 100, completion: { (json) in
            
            for i in json["projects"] {
                let projectData = i.1
                var listCustomFields = [CustomField]()
                for i in projectData["custom_fields"] {
                    let customFieldData = i.1
                    let customField = CustomField(id: customFieldData["id"].intValue,
                                                  name: customFieldData["name"].stringValue,
                                                  value: customFieldData["value"].stringValue)
                    listCustomFields.append(customField)
                }
                let project = Project(
                    idProject: projectData["id"].intValue,
                    name: projectData["name"].stringValue,
                    description: projectData["description"].stringValue,
                    updated_on: projectData["updated_on"].stringValue,
                    inherit_members: projectData["inherit_members"].boolValue,
                    identifier: projectData["identifier"].stringValue,
                    custom_fields: listCustomFields,
                    created_on: projectData["created_on"].stringValue,
                    is_public: projectData["is_public"].boolValue,
                    status: projectData["status"].intValue,
                    parentID: projectData["parent"]["id"].int,
                    parentName: projectData["parent"]["name"].stringValue)
                
                // отбор родительских проектов
                if project.parentID == nil {
                    listProjects.append(project)
                    listProjects = listProjects.sorted(by: {$0.name < $1.name})
                    mainStore.dispatch(LoadedProject(projects: listProjects))
                }
            }

//            for i in 0 ..< arrayChildsProject.count {
//
//                let child = arrayChildsProject[i]
//                let parentID: Int = child.parentID!
//
//                dictionaryParentsProject[parentID]?.childProjects?.append(child)
//
//                print(dictionaryParentsProject[parentID]?.name)
//                print(dictionaryParentsProject[parentID]?.childProjects?.count)
//            }
            
        })
    }
    
    
    
    
}
