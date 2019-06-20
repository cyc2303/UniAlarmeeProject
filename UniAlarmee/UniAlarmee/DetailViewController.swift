//
//  DetailViewController.swift
//  UniAlarmee
//
//  Created by yuni on 20/06/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var backState:String = ""
    var selectedType:String = "" //Todo or Post
    var selectedTodo:Todo = Todo(title: "1", detail: "1", type: .Normal)
    var selectedPost:Post = Post(id: "1", title: "1", detail: "1", type: .Normal)

    @IBAction func unwind(_ sender: Any) {
        if backState == "FSCalendar" {
            self.performSegue(withIdentifier: "toBase", sender: nil)
        }
        else if backState == "List" {
            self.performSegue(withIdentifier: "toList", sender: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [2, 3][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail")!
        cell.textLabel!.text = selectedTodo.todoTitle
        if selectedType == "Todo" {
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.textLabel!.text = selectedTodo.todoTitle
                }
                else if indexPath.row == 1 {
                    cell.textLabel!.text = selectedTodo.todoDetail
                }
            }
            else{
                if indexPath.row == 0 {
                    if selectedTodo.dueDate != nil {
                        cell.textLabel!.text = "\(selectedTodo.dueDate!.year)/\(selectedTodo.dueDate!.month)/\(selectedTodo.dueDate!.day)"
                    }
                    else{
                        cell.textLabel!.text = "no due date"
                    }
                }
                else if indexPath.row == 1 {
                    if selectedTodo.dueTime != nil {
                        cell.textLabel!.text = "\(selectedTodo.dueTime!.hour)h \(selectedTodo.dueTime!.minute)m"
                    }
                    else{
                        cell.textLabel!.text = "no due time"
                    }
                }
                else if indexPath.row == 2 {
                    cell.textLabel!.text = "write memo"
                }
            }
        }
        else if selectedType == "Post" {
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.textLabel!.text = selectedPost.title
                }
                else if indexPath.row == 1 {
                    cell.textLabel!.text = selectedPost.detail
                }
            }
            else{
                if indexPath.row == 0 {
                    if selectedPost.dueDate != nil {
                        cell.textLabel!.text = "\(selectedPost.dueDate!.year)/\(selectedPost.dueDate!.month)/\(selectedPost.dueDate!.day)"
                    }
                    else{
                        cell.textLabel!.text = "no due date"
                    }
                }
                else if indexPath.row == 1 {
                    if selectedPost.dueTime != nil {
                        cell.textLabel!.text = "\(selectedPost.dueTime!.hour)h \(selectedPost.dueTime!.minute)m"
                    }
                    else{
                        cell.textLabel!.text = "no due time"
                    }                }
                else if indexPath.row == 2 {
                    cell.textLabel!.text = "write memo"
                }
            }
        }
        //cell.detailTextLabel!.text = "\(myAlarm.alarms[indexPath.row].dueDate!.year)/\(myAlarm.alarms[indexPath.row].dueDate!.month)/\(myAlarm.alarms[indexPath.row].dueDate!.day)"
        
        return cell
        //}
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   
        if selectedType == "Todo"{
            if section == 0 {
                return self.selectedTodo.type.typeTitle
            }
            else{
                return "Times"
            }
        }
        else{
            if section == 0 {
                return self.selectedPost.type.typeTitle
            }
            else{
                return "Times"
            }
        }
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

