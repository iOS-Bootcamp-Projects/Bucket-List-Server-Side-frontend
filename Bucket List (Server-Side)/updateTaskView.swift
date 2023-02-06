//
//  updateTaskView.swift
//  Bucket List (Server-Side)
//
//  Created by Aamer Essa on 13/12/2022.
//

import UIKit

class updateTaskView: UIViewController {
    var tasksOp:tasksOperation?
    var taskName = String()
    var taskDate = String()
    var id = String()
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var task: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        task.text = taskName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
       let taskDateformat = dateFormatter.date(from: taskDate)
       date.date = taskDateformat!
    }
    

    @IBAction func updateTask(_ sender: Any) {
        tasksOp?.updateTask(taskName: task.text!, taskDate: date.date, id: id)
    }
    
}
