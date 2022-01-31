import UIKit
import SwiftyJSON

class Parse: NSObject {
    
    static var user: User!
    static var listTasksStatuses = [String]()
    static var listTasksSort = [String: [Task]]()
    
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
            completion()
        }
    }
    
    ///
    class func parseTask(json: JSON, completion: @escaping (Task) -> ()) {
        
        var listCustomFields = [CustomField]()
        var listAttachments = [Attachment]()
        
        for i in json["custom_fields"].arrayValue {
            listCustomFields.append(parseCustomFields(customField: i))
        }
        
        for i in json["attachments"].arrayValue {
            listAttachments.append(parseAttachment(json: i))
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
                        status: json["status"]["name"].stringValue,
                        description: json["description"].stringValue,
                        project: json["project"]["name"].stringValue,
                        projectID: json["project"]["id"].intValue,
                        attachments: listAttachments))
    }
    
    ///
    class func parseAttachment(json: JSON) -> Attachment {
//        print(json)
        return Attachment(id: json["id"].intValue,
                          fileName: json["filename"].stringValue,
                          createdOn: json["created_on"].stringValue,
                          thumbnailURL: json["thumbnail_url"].stringValue,
                          author: json["author"]["name"].stringValue,
                          filesize: json["filesize"].intValue,
                          description: json["description"].stringValue,
                          contentType: json["content_type"].stringValue,
                          contentURL: json["content_url"].stringValue)
    }
    
    ///
    class func parseCustomFields(customField: JSON) -> CustomField {
        return CustomField(id: customField["id"].intValue,
                           name: customField["name"].stringValue,
                           value: customField["value"].stringValue)
    }
    
    ///
    class func parseTasksForStatus(tasks: [Task], completion: @escaping () -> ()) {
        listTasksSort = [:]
        for i in listTasksStatuses {
            let tasksSorted = tasks.filter({$0.status == i})
            listTasksSort.updateValue(tasksSorted, forKey: i)
        }
        completion()
    }
    
}
