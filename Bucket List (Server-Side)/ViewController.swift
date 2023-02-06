//
//  ViewController.swift
//  Bucket List (Server-Side)
//
//  Created by Aamer Essa on 12/12/2022.
//

import UIKit

protocol tasksOperation {
    func addNewTask(taskName:String,taskDate:Date,createdDate:Date)
    func updateTask (taskName:String,taskDate:Date,id:String)
}

class ViewController: UIViewController ,tasksOperation{
   
    
   
    
    @IBOutlet weak var taskTableView: UITableView!
    var tasks = [NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.delegate = self
        taskTableView.dataSource = self
    
         getTasks()
    }
  

    @IBAction func onClickAddNewTaskBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addNewTaskView = storyboard.instantiateViewController(withIdentifier: "AddNewTaskView") as! AddNewTaskView
        addNewTaskView.taskOp = self
        addNewTaskView.modalPresentationStyle = .formSheet
        present(addNewTaskView, animated: true)
    }
    

    
    
    func getTasks() {
        tasks.removeAll()
        print(tasks)
        StarWarsModel.getAllPeople(completionHandler: {
            data, response, error in
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                         
                        let results = jsonResult["task"] as? [NSDictionary]
                        self.tasks = results!
                       print(results)
                        print(self.tasks)
                    }
                    
                    DispatchQueue.main.async {
                    self.taskTableView.reloadData()
                   
                    }
                } catch {
                    print("Something went wrong")
                }
        })
        
        
    } //getTasks()
    
    func addNewTask(taskName:String,taskDate:Date,createdDate:Date){
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let taskDate = dateFormatter.string(from: taskDate)
        let createdDate = dateFormatter.string(from: createdDate)

        let body = [
                     "taskName": taskName,
                      "taskDate": taskDate,
                      "created_at": createdDate,
                  ]
      
        StarWarsModel.addNewTask(name:taskName,taskDate: taskDate,created_at: createdDate){ data, response, error in
                    do{
                    
                        let response = try JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
                       
                        
                        DispatchQueue.main.async {
                            self.tasks.removeAll()
                            self.getTasks()
                            self.dismiss(animated: true)
                            self.taskTableView.reloadData()
                        }
        
                    } catch {
                        print("\(error)")
                    }
                }
    }
    
    func updateTask(taskName: String, taskDate: Date, id: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let taskDate = dateFormatter.string(from: taskDate)
       
         let body = [
            "taskName": taskName,
             "taskDate": taskDate,
         ]

        StarWarsModel.editTask(name:taskName,taskDate: taskDate,id: id){ data, response, error in
           do{
               
               let response = try JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
               print(response)
               print(data!)
               
               DispatchQueue.main.async {
                   self.tasks.removeAll()
                   self.getTasks()
                   self.dismiss(animated: true)
               }

           } catch {
               print("\(error)")
           }
       }
        
    } // updateTask()
    

}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TasksTableViewCell
        cell.taskName.text = "\(tasks[indexPath.row]["name"] as! String)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            // convert datring to date
        let createdDate = dateFormatter.date(from: tasks[indexPath.row]["created_at"] as! String)
        let taskDate = dateFormatter.date(from: tasks[indexPath.row]["taskDate"] as! String)
        
        // convert cretaed date to this format
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
        cell.createdDate.text = "Created at \(dateFormatter.string(from: createdDate!))"
        
        // convert task date to this format
      dateFormatter.dateFormat = "d MMM, h:mm a"
      cell.taskDate.text = dateFormatter.string(from: taskDate!)
       
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            StarWarsModel.deleteTask(id: self.tasks[indexPath.row]["id"] as! String)
            self.tasks.removeAll()
            self.getTasks()
             
            completionHandler(true)
        } // delete button
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let updateView = storyBoard.instantiateViewController(withIdentifier: "UpdateTaskView") as! updateTaskView
        updateView.modalPresentationStyle = .formSheet
        let task = tasks[indexPath.row]
        updateView.taskName = task["name"] as! String
        updateView.taskDate = task["taskDate"] as! String
        updateView.id = task["id"] as! String
        updateView.tasksOp = self 
        present(updateView, animated: true)
    }
    
}

