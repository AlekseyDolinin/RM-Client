class Task {
    
    var doneRatio: Int
    var startDate: String
    var createdOn: String
    var tracker: String
    var author: String
    var dueDate: String
    var subject: String
    var isPrivate: Bool
    var assignedTo: String
    var category: String
    var estimatedHours: Double?
    var customFields: [CustomField]
    var priority: String
    var id: Int
    var parent: Int
    var updatedOn: String
    var closedOn: Bool?
    var status: String
    var description: String
    var project: String
    
    init(doneRatio: Int,
         startDate: String,
         createdOn: String,
         tracker: String,
         author: String,
         dueDate: String,
         subject: String,
         isPrivate: Bool,
         assignedTo: String,
         category: String,
         estimatedHours: Double?,
         customFields: [CustomField],
         priority: String,
         id: Int,
         parent: Int,
         updatedOn: String,
         closedOn: Bool?,
         status: String,
         description: String,
         project: String){
        
        self.doneRatio = doneRatio
        self.startDate = startDate
        self.createdOn = createdOn
        self.tracker = tracker
        self.author = author
        self.dueDate = dueDate
        self.subject = subject
        self.isPrivate = isPrivate
        self.assignedTo = assignedTo
        self.category = category
        self.estimatedHours = estimatedHours
        self.customFields = customFields
        self.priority = priority
        self.id = id
        self.parent = parent
        self.updatedOn = updatedOn
        self.closedOn = closedOn
        self.status = status
        self.description = description
        self.project = project
    }
}
