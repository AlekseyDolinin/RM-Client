class Project {
    
    /// ID Project
    var id: Int
    /// Название Проекта
    var name: String
    var description: String
    var updated_on: String
    var inherit_members: Bool
    var identifier: String
    var custom_fields: [CustomField]
    var created_on: String
    var is_public: Bool
    var status: Int
    
    init(id: Int,
         name: String,
         description: String,
         updated_on: String,
         inherit_members: Bool,
         identifier: String,
         custom_fields: [CustomField],
         created_on: String,
         is_public: Bool,
         status: Int){
        
        self.id = id
        self.name = name
        self.description = description
        self.updated_on = updated_on
        self.inherit_members = inherit_members
        self.identifier = identifier
        self.custom_fields = custom_fields
        self.created_on = created_on
        self.is_public = is_public
        self.status = status
    }
}
