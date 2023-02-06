//
//  TasksTableViewCell.swift
//  Bucket List (Server-Side)
//
//  Created by Aamer Essa on 12/12/2022.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    @IBOutlet weak var taskName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
