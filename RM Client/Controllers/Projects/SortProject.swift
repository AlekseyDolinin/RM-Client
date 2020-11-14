
extension ProjectsViewController {
    
    func sortProjects() {
        
        for project in mainStore.state.projects {

            if (project.parentName)! != "" {
                print((project.parentName)!)
            }


            for i in project.custom_fields {
                print(i.name)
            }
        }

    }
  
}
