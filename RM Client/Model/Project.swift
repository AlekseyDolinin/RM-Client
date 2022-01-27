class Project {
    
    var idProject: Int
    var name: String
    var description: String
    var identifier: String
    var created_on: String
    var updated_on: String
    /// id родительского проекта
    var parentID: Int?
    /// name родительского проекта
    var parentName: String?
    var childProjects: [Project]?
    
    init(idProject: Int,
         name: String,
         description: String,
         updated_on: String,
         identifier: String,
         created_on: String,
         parentID: Int? = nil,
         parentName: String? = nil,
         childProjects: [Project]? = nil
    ){
        
        self.idProject = idProject
        self.name = name
        self.description = description
        self.updated_on = updated_on
        self.identifier = identifier
        self.created_on = created_on
        self.parentID = parentID
        self.parentName = parentName
        self.childProjects = childProjects
    }
}
