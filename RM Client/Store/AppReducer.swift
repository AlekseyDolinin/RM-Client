import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    switch action {
        
    case let userData as UserData:
        state.userData = userData.userData
        
    case let userTasks as LoadedUserTasks:
        state.userTasks = userTasks.userTasks
        
    case let statusTasks as LoadedStatusTasks:
        state.statusTasks = statusTasks.statusTasks

    case let project as LoadedProject:
        state.project = project.project

        
    default:
        break
    }
    
    return state
}
