import ReSwift
import Foundation

struct AppState: StateType {
    
    var userData: User?
    var userTasks: [Task] = []
    var statusTasks: [Status] = []
    var projects: [Project] = []
    
}
