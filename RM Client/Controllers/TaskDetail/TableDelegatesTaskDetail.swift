import UIKit

extension TaskDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellDescription = tableView.dequeueReusableCell(withIdentifier: "CellDescription", for: indexPath) as! CellDescription
        let cellAuthor = tableView.dequeueReusableCell(withIdentifier: "CellAuthor", for: indexPath) as! CellAuthor
        let cellAssignedTo = tableView.dequeueReusableCell(withIdentifier: "CellAssignedTo", for: indexPath) as! CellAssignedTo
        
        
        if !(selectTask?.description.isEmpty)! && indexPath.row == 0 {
            cellDescription.textDescriptionLabel.text = selectTask?.description
            return cellDescription
        }
        
        if indexPath.row == 1 {
            cellAuthor.nameAuthorLabel.text = selectTask?.author
            
            let createdOnDate: Date = Date().convertStringToDate(dataString: selectTask!.createdOn)
            cellAuthor.timingLabel.text = Date().convertDateToString(date: createdOnDate)
            
            return cellAuthor
        }
        
        if indexPath.row == 2 {
            cellAssignedTo.nameLabel.text = selectTask?.assignedTo
            return cellAssignedTo
        }
        
        return UITableViewCell()
    }
}


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
