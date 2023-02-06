//
//  tasks.swift
//  Bucket List (Server-Side)
//
//  Created by Aamer Essa on 12/12/2022.
//

import Foundation

class StarWarsModel:ViewController {
    
    static func getAllPeople(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        let url = URL(string: "http://localhost:3000/tasks")
       
        let session = URLSession.shared
       
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
       
        task.resume()
    }
    
    static func addNewTask(name:String,taskDate:String,created_at:String,completionHandler:@escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
           
           let url = URL(string: "http://localhost:4000/users/login")
           var request = URLRequest(url: url!)
           request.httpMethod = "POST"
           request.setValue("application/json ", forHTTPHeaderField: "Content-Type")
           let body = [
               "taskName": name,
               "taskDate": taskDate,
               "created_at": created_at,
           ]
     
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
           let session = URLSession.shared
           let task = session.dataTask(with: request, completionHandler: completionHandler)
        
           task.resume()
       }
    
    static func editTask(name:String,taskDate:String,id:String,completionHandler:@escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
           
        let url = URL(string: "http://localhost:3000/editTask/\(id)")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.setValue("application/json ", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "taskName": name,
            "taskDate": taskDate,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
        
        
        let session = URLSession.shared
           let task = session.dataTask(with: request, completionHandler: completionHandler)
           task.resume()
       }
    
    
    static func deleteTask(id:String){
        let url = URL(string: "http://localhost:3000/deleteTask/\(id)")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.setValue("application/json ", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, _, error in
            
            do{
                let response = try JSONSerialization.jsonObject(with: data!,options: .allowFragments)
                print("Succs")
                print(response)
            } catch {
                print("\(error)")
            }
        }
        task.resume()
        
    }
}









