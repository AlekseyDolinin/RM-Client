import UIKit
import ReSwift

class ProjectsViewController: UIViewController, StoreSubscriber {
    
    typealias StoreSubscriberStateType = AppState
    
    var projectsView: ProjectsView! {
        guard isViewLoaded else {return nil}
        return (view as! ProjectsView)
    }
    
    var listProjects = mainStore.state.projects
    
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        projectsView.configure()
        
        projectsView.tableProjects.delegate = self
        projectsView.tableProjects.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        if !state.projects.isEmpty {
            listProjects = mainStore.state.projects
            projectsView.allCountProjectLabel.text = String(state.projects.count)
            projectsView.tableProjects.reloadData()
        }
    }
}
