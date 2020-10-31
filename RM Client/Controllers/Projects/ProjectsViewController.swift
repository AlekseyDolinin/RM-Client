import UIKit
import SwiftyJSON

class ProjectsViewController: UIViewController {
    
    private var projectsView: ProjectsView! {
        guard isViewLoaded else {return nil}
        return (view as! ProjectsView)
    }
    
    var listProjects = [Project]()
    var totalProjects = Int()
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectsView.tableProjects.delegate = self
        projectsView.tableProjects.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if listProjects.isEmpty {
            print("запрос проектов")
            getProjects(offset: offset)
        }
    }
    
    func getProjects(offset: Int) {
        
        API.shared.getJSON(endPoint: "projects", offset: offset, limit: 1000, completion: { (json) in
            
            self.totalProjects = json["total_count"].intValue

            print("всего проектов: \(self.totalProjects)")
            
            for i in json["projects"] {
                
                let projectData = i.1
                
                var listCustomFields = [CustomField]()
                
                for i in projectData["custom_fields"] {
                    let customFieldData = i.1
                    let customField = CustomField(id: customFieldData["id"].intValue, name: customFieldData["name"].stringValue, value: customFieldData["value"].stringValue)
                    listCustomFields.append(customField)
                }
                
                let project = Project(
                    id: projectData["id"].intValue,
                    name: projectData["name"].stringValue,
                    description: projectData["description"].stringValue,
                    updated_on: projectData["updated_on"].stringValue,
                    inherit_members: projectData["inherit_members"].boolValue,
                    identifier: projectData["identifier"].stringValue,
                    custom_fields: listCustomFields,
                    created_on: projectData["created_on"].stringValue,
                    is_public: projectData["is_public"].boolValue,
                    status: projectData["status"].intValue)
                
                self.listProjects.append(project)
                self.listProjects = self.listProjects.sorted(by: {$0.name < $1.name})
            }
            self.projectsView.tableProjects.reloadData()
        })
    }
}

