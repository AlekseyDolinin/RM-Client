import UIKit

extension TaskDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellDescription = tableView.dequeueReusableCell(withIdentifier: "CellDescription", for: indexPath) as! CellDescription
        let cellAuthor = tableView.dequeueReusableCell(withIdentifier: "CellAuthor", for: indexPath) as! CellAuthor
        let cellAssignedTo = tableView.dequeueReusableCell(withIdentifier: "CellAssignedTo", for: indexPath) as! CellAssignedTo
        
        let cellFiles = tableView.dequeueReusableCell(withIdentifier: "CellFiles", for: indexPath) as! CellFiles
        let cellTiming = tableView.dequeueReusableCell(withIdentifier: "CellTiming", for: indexPath) as! CellTiming
        let cellHistory = tableView.dequeueReusableCell(withIdentifier: "CellHistory", for: indexPath) as! CellHistory
        let cellOther = tableView.dequeueReusableCell(withIdentifier: "CellOther", for: indexPath) as! CellOther
        
        if indexPath.row == 0 {
            if task?.description == "" {
                cellDescription.textDescriptionLabel.text = "----------"
            } else {
                cellDescription.textDescriptionLabel.text = task?.description
            }
            return cellDescription
        }
        
        if indexPath.row == 1 {
            cellAuthor.nameAuthorLabel.text = task?.author
            let createdOnDate: Date = Date().convertStringToDate(type: .dateAndTimeOne, dataString: task!.createdOn)
            cellAuthor.timingLabel.text = Date().convertDateToString(type: .dateAndTimeTwo, date: createdOnDate)
            return cellAuthor
        }
        
        if indexPath.row == 2 {
            cellAssignedTo.nameLabel.text = task?.assignedTo
            return cellAssignedTo
        }
        
        if indexPath.row == 3 {
            // нет прикрепленных файлов
            if (task?.attachments.isEmpty)! {
                cellFiles.titleCellLabel.text = "Файлы".uppercased()
                cellFiles.descriptionLabel.text = "Отсутствуют"
                cellFiles.arrowImageView.isHidden = true
            } else {
                cellFiles.titleCellLabel.text = "Файлы (\(task!.attachments.count))".uppercased()
                cellFiles.descriptionLabel.isHidden = true
            }
            return cellFiles
        }
        
        if indexPath.row == 4 {
//            cellTiming.nameLabel.text = selectTask?.assignedTo
            return cellTiming
        }
        
        if indexPath.row == 5 {
//            cellHistory.nameLabel.text = selectTask?.assignedTo
            return cellHistory
        }
        
        if indexPath.row == 6 {
//            cellOther.nameLabel.text = selectTask?.assignedTo
            return cellOther
        }
        
        return UITableViewCell()
    }
    
    ///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Tasks", bundle: nil).instantiateViewController(withIdentifier: "AttachmentsViewController") as! AttachmentsViewController
        vc.task = task
        self.navigationController?.pushViewController(vc, animated: true)
        return
        
        switch indexPath.row {
        case 2:
            let vc = UIStoryboard(name: "Tasks", bundle: nil).instantiateViewController(withIdentifier: "AttachmentsViewController") as! AttachmentsViewController
            vc.task = task
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            if task?.attachments.isEmpty == false {
                DispatchQueue.main.async { [weak self] in
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "AttachmentsVC") as! AttachmentsViewController
                    vc.task = self?.task
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        case 4:
            let vc = storyboard?.instantiateViewController(withIdentifier: "AttachmentsVC") as! AttachmentsViewController
            vc.task = task
//            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = storyboard?.instantiateViewController(withIdentifier: "AttachmentsVC") as! AttachmentsViewController
            vc.task = task
//            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = storyboard?.instantiateViewController(withIdentifier: "AttachmentsVC") as! AttachmentsViewController
            vc.task = task
//            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("not row")
        }
        
        
    }
    
}
