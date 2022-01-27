import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameProjectLabel: UILabel!
    @IBOutlet weak var idProjectLabel: UILabel!
    @IBOutlet weak var createdProjectLabel: UILabel!
    @IBOutlet weak var countChildProject: UILabel!
        
    var project: Project!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 8
    }
    
    func setCell(){
        nameProjectLabel.text = project.name
        idProjectLabel.text = "#\(project.idProject)"
        
        let date = Date().convertStringToDate(type: .dateAndTimeOne, dataString: project.created_on)
        createdProjectLabel.text = Date().convertDateToString(type: .date, date: date)
        
        if let childCountProjects = project.childProjects?.count {
            countChildProject.text = String(childCountProjects)
        } else {
            countChildProject.isHidden = true
        }
    }

}
