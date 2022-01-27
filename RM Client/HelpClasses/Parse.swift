import UIKit
import SwiftyJSON

class Parse: NSObject {
    
    static var user: User!
    static var listTasksStatuses = [String]()
    static var listColorsStatus: [UIColor] = [._pinkStatus, ._violetStatus, ._orangeStatus, ._greenStatus, ._yellowStatus, ._pinkStatus, ._violetStatus, ._orangeStatus, ._greenStatus, ._yellowStatus, ._pinkStatus, ._violetStatus, ._orangeStatus, ._greenStatus, ._yellowStatus]
    
    class func parseProject(json: JSON, completion: @escaping (Project) -> ()) {
        completion(Project(
            idProject: json["id"].intValue,
            name: json["name"].stringValue,
            description: json["description"].stringValue,
            updated_on: json["updated_on"].stringValue,
            identifier: json["identifier"].stringValue,
            created_on: json["created_on"].stringValue,
            parentID: json["parent"]["id"].intValue,
            parentName: json["parent"]["name"].stringValue,
            childProjects: nil))
    }
    
    ///
    class func parseUserData(json: JSON, completion: @escaping () -> ()) {
        let data = json["user"]
        // хэш почты для получения аватара по почте
        let md5HexMail = GetHashEmail.MD5(string: data["mail"].stringValue)
        let avatarLink = "https://www.gravatar.com/avatar/\(md5HexMail)?s=300"
        user = User(admin: data["admin"].boolValue,
                            api_key: data["api_key"].stringValue,
                            login: data["login"].stringValue,
                            last_login_on: data["last_login_on"].stringValue,
                            mail: data["mail"].stringValue,
                            lastname: data["lastname"].stringValue,
                            firstname: data["firstname"].stringValue,
                            id: data["id"].intValue,
                            created_on: data["created_on"].stringValue,
                            avatar:avatarLink)
        completion()
    }
    
    ///
    class func parseTasksStatuses(json: JSON, completion: @escaping () -> ()) {
        listTasksStatuses = []
        for i in json.arrayValue {
            listTasksStatuses.append(i["name"].stringValue)
        }
        
        if listTasksStatuses.count == json.count {
            completion()
        }
    }
    
    ///
    class func parseTask(json: JSON, completion: @escaping (Task) -> ()) {
        
        var listCustomFields = [CustomField]()
        var listAttachments = [Attachment]()
        
        for i in json["custom_fields"].arrayValue {
            let customField = CustomField(id: i["id"].intValue,
                                          name: i["name"].stringValue,
                                          value: i["value"].stringValue)
            listCustomFields.append(customField)
        }
        
        for i in json["attachments"].arrayValue {
            let attachment = Attachment(id: i["id"].intValue,
                                        fileName: i["filename"].stringValue,
                                        createdOn: i["created_on"].stringValue,
                                        thumbnail_url: i["thumbnail_url"].stringValue,
                                        author: i["author"]["name"].stringValue,
                                        filesize: i["filesize"].intValue,
                                        description: i["description"].stringValue,
                                        content_type: i["content_type"].stringValue,
                                        content_url: i["content_url"].stringValue)
            listAttachments.append(attachment)
        }
        
        completion(Task(doneRatio: json["done_ratio"].intValue,
                        startDate: json["start_date"].stringValue,
                        createdOn: json["created_on"].stringValue,
                        tracker: json["tracker"]["name"].stringValue,
                        author: json["author"]["name"].stringValue,
                        avatarAuthor: UIImage(),
                        dueDate: json["due_date"].stringValue,
                        subject: json["subject"].stringValue,
                        isPrivate: json["is_private"].boolValue,
                        assignedTo: json["assigned_to"]["name"].stringValue,
                        category: json["category"]["name"].stringValue,
                        estimatedHours: json["estimated_hours"].doubleValue,
                        customFields: listCustomFields,
                        priority: json["priority"]["name"].stringValue,
                        idTask: json["id"].intValue,
                        parent: json["parent"]["id"].intValue,
                        updatedOn: json["updated_on"].stringValue,
                        closedOn: json["closed_on"].boolValue,
                        status: Parse().parseTaskStatus(statusString: json["status"]["name"].stringValue),
                        description: json["description"].stringValue,
                        project: json["project"]["name"].stringValue,
                        projectID: json["project"]["id"].intValue,
                        attachments: listAttachments))
    }
    
    
    
    func parseTaskStatus(statusString: String) -> Status {
        switch statusString {
        case "Новая":
            return .new
            
        case "В работе":
            return .new

        case "Обратная связь":
            return .fb
            
        default:
            print("не обрабатывается: \(statusString)")
            return .none
        }
    }
    
}
