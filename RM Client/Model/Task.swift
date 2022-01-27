import UIKit

class Task {
    
    var doneRatio: Int
    var startDate: String
    var createdOn: String
    var tracker: String
    var author: String
    var avatarAuthor: UIImage
    var dueDate: String
    var subject: String
    var isPrivate: Bool
    var assignedTo: String
    var category: String
    var estimatedHours: Double?
    var customFields: [CustomField]
    var priority: String
    var idTask: Int
    var parent: Int
    var updatedOn: String
    var closedOn: Bool?
    var status: Status
    var description: String
    var project: String
    var projectID: Int
    var attachments: [Attachment]
    
    init(doneRatio: Int,
         startDate: String,
         createdOn: String,
         tracker: String,
         author: String,
         avatarAuthor: UIImage,
         dueDate: String,
         subject: String,
         isPrivate: Bool,
         assignedTo: String,
         category: String,
         estimatedHours: Double?,
         customFields: [CustomField],
         priority: String,
         idTask: Int,
         parent: Int,
         updatedOn: String,
         closedOn: Bool?,
         status: Status,
         description: String,
         project: String,
         projectID: Int,
         attachments: [Attachment]
         ){
        
        self.doneRatio = doneRatio
        self.startDate = startDate
        self.createdOn = createdOn
        self.tracker = tracker
        self.author = author
        self.avatarAuthor = avatarAuthor
        self.dueDate = dueDate
        self.subject = subject
        self.isPrivate = isPrivate
        self.assignedTo = assignedTo
        self.category = category
        self.estimatedHours = estimatedHours
        self.customFields = customFields
        self.priority = priority
        self.idTask = idTask
        self.parent = parent
        self.updatedOn = updatedOn
        self.closedOn = closedOn
        self.status = status
        self.description = description
        self.project = project
        self.projectID = projectID
        self.attachments = attachments
    }
}
