//
//  AddNewTaskView.swift
//  Bucket List (Server-Side)
//
//  Created by Aamer Essa on 13/12/2022.
//

import UIKit

class AddNewTaskView: UIViewController {

    @IBOutlet weak var taskDate: UIDatePicker!
    @IBOutlet weak var task: UITextField!
    var taskOp:tasksOperation?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

   
    @IBAction func addNewTask(_ sender: Any) {
       
        taskOp?.addNewTask(taskName: task.text!, taskDate: taskDate.date, createdDate: Date())
    }
    
}
