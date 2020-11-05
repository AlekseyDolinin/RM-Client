import UIKit

class Status {
    
    var id: Int
    var name: String
    var color: UIColor
    var arrayTasks: [Task]
    
    init(id: Int,
         name: String,
         color: UIColor,
         arrayTasks: [Task]){
        
        self.id = id
        self.name = name
        self.color = color
        self.arrayTasks = arrayTasks
    }
}
