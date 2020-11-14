import UIKit
import SwiftyJSON

class ProjectsViewController: UIViewController {
    
    var projectsView: ProjectsView! {
        guard isViewLoaded else {return nil}
        return (view as! ProjectsView)
    }

    
    var listProjects = [Project]()
    static var totalProjects = Int()
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        projectsView.configure()
        
        projectsView.tableProjects.delegate = self
        projectsView.tableProjects.dataSource = self
        
        getProjects(offset: offset)
    }
    
    func getProjects(offset: Int) {
        
        API.shared.getJSONPagination(endPoint: "/projects.json?", offset: offset, limit: 100, completion: { (json) in
            
            print("всего проектов: \(json["total_count"].intValue)")
            ProjectsViewController.totalProjects = json["total_count"].intValue
            
            for i in json["projects"] {
                
                let projectData = i.1
                
//                let idProject = projectData["id"].intValue
//                API.shared.getJSON(endPoint: "/projects/\(idProject)/memberships", completion: { (json) in
//                    print(json)
//                })
                print(projectData)
                var listCustomFields = [CustomField]()
                
                for i in projectData["custom_fields"] {
                    let customFieldData = i.1
                    let customField = CustomField(id: customFieldData["id"].intValue,
                                                  name: customFieldData["name"].stringValue,
                                                  value: customFieldData["value"].stringValue)
                    listCustomFields.append(customField)
                }
                
                let project = Project(
                    idProject: projectData["id"].intValue,
                    name: projectData["name"].stringValue,
                    description: projectData["description"].stringValue,
                    updated_on: projectData["updated_on"].stringValue,
                    inherit_members: projectData["inherit_members"].boolValue,
                    identifier: projectData["identifier"].stringValue,
                    custom_fields: listCustomFields,
                    created_on: projectData["created_on"].stringValue,
                    is_public: projectData["is_public"].boolValue,
                    status: projectData["status"].intValue,
                    parentID: projectData["parent"]["id"].int,
                    parentName: projectData["parent"]["name"].stringValue)
                
//                if project.parentID == nil {
//                    self.listProjects.append(project)
//                }
                self.listProjects.append(project)
                self.listProjects = self.listProjects.sorted(by: {$0.name < $1.name})
                mainStore.dispatch(LoadedProject(projects: self.listProjects))
                self.sortProjects()
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showContent"), object: nil)
            self.projectsView.tableProjects.reloadData()
        })
    }
}
