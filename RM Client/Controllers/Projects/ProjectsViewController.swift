import UIKit

class ProjectsViewController: UIViewController {
        
    var viewSelf: ProjectsView! {
        guard isViewLoaded else {return nil}
        return (view as! ProjectsView)
    }
    
    let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = ._blue
        refresh.addTarget(self, action: #selector(refrechAction), for: .valueChanged)
        return refresh
    }()
    
    var listProjects = [Project]()
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        viewSelf.tableProjects.delegate = self
        viewSelf.tableProjects.dataSource = self
        viewSelf.tableProjects.refreshControl = refreshControl
        getProjects()
    }
    
    ///
    @objc func refrechAction(sender: UIRefreshControl?) {
        DispatchQueue.main.async {
            self.getProjects()
        }
    }
    
    func getProjects() {
                
        API.shared.getJSONPagination(endPoint: "/projects.json?", offset: offset, limit: 100, completion: { (json) in
            self.refreshControl.endRefreshing()
            self.listProjects = []
            
            for i in json["projects"].arrayValue {
                self.viewSelf.allCountProjectLabel.text = String(json["total_count"].intValue)
                
                Parse.parseProject(json: i) { project in
                    self.listProjects.append(project)
                    self.viewSelf.tableProjects.reloadData()
                }
                
//                // отбор родительских проектов
//                // дочерние позже будут сортироваться по родительским
//                if project.parentID == nil {
//                    listProjects.append(project)
//                    listProjects = listProjects.sorted(by: {$0.name < $1.name})
//                    mainStore.dispatch(LoadedProject(projects: listProjects))
//                } else {
//                    arrayChildProjects.append(project)
//                }
            }

//            for i in 0 ..< arrayChildProjects.count {
//
//                let child = arrayChildProjects[i]
//                let childName: String = child.name
//                let parentName:String = child.parentName!
//                let parentID: Int = child.parentID!
//                
////                print(childName)
////                print("---")
////                print(parentName)
////                print(parentID)
////                print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
//                
//                for j in 0 ..< listProjects.count {
//                    
//                    let parent = listProjects[j]
//                    let idParent = parent.idProject
//                    
//                    if idParent == parentID {
////                        print("совпадение")
////                        print(child.name)
////                        parent.childProjects?.append(child)
//                        
//                        
////                        mainStore.dispatch(LoadedProject(projects: listProjects))
////                        print(mainStore.state.projects[j].childProjects?.count)
//                    }
//                }
//            }
        })
    }
}
