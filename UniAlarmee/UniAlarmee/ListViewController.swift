//
//  ListViewController.swift
//  UniAlarmee
//
//  Created by Choi Yechan on 14/06/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedTodo:Todo = Todo(title: "1", detail: "1", type: .Normal)
    var selectedPost:Post = Post(id: "1", title: "1", detail: "1", type: .Normal)

    var selectedType:String = ""
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let myAlarm:AlarmManager = AlarmManager.sharedInstance
        let NOA:Int = myAlarm.assignments.count
        let NOP:Int = myAlarm.announcements.count
        return [NOA, NOP][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myAlarm:AlarmManager = AlarmManager.sharedInstance
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if indexPath.section == 0 {
            cell.textLabel!.text = myAlarm.assignments[indexPath.row].todoTitle
        }
        else{
            cell.textLabel!.text = myAlarm.announcements[indexPath.row].title
        }
        //cell.detailTextLabel!.text = "\(myAlarm.alarms[indexPath.row].dueDate!.year)/\(myAlarm.alarms[indexPath.row].dueDate!.month)/\(myAlarm.alarms[indexPath.row].dueDate!.day)"
        
        return cell
        //}
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var myAlarm = AlarmManager.sharedInstance
            
        if indexPath.section == 0 {
            self.selectedTodo = myAlarm.assignments[indexPath.row]
            
            self.selectedType = "Todo"
        } else {
            self.selectedPost = myAlarm.announcements[indexPath.row]
            self.selectedType = "Post"
        }
        performSegue(withIdentifier: "L2D", sender: nil)

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Assignment"
        }
        else{
            return "Announcement"
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toList(segue:UIStoryboardSegue){
        tableView.reloadData()
        print("asdfasdfasdfasdf")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //when click the todo cell
        if segue.identifier == "L2D" {
            let dest = segue.destination as! DetailViewController
            
            dest.selectedType=self.selectedType
            dest.backState="List"

            if self.selectedType == "Todo" {
                dest.selectedTodo = self.selectedTodo
            }
            else {
                dest.selectedPost = self.selectedPost
            }
        }
    }
}
