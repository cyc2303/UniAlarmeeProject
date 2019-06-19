//
//  AddTodoViewController.swift
//  UniAlarmee
//
//  Created by dajinHan on 23/05/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit

class AddTodoViewController: ViewController {
 
    @IBAction func Picdate(_ sender: UIDatePicker) {
        
        sender.addTarget(self, action: #selector(change(sender:)), for: .valueChanged)
    }
    @objc func change(sender: UIDatePicker){
        let dateformatter : DateFormatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .medium
        let a = dateformatter.string(from: sender.date)
        print(a)
    }
    @IBOutlet weak var Date_year: UITextField!
    
    @IBOutlet weak var Date_month: UITextField!
    
    @IBOutlet weak var Date_day: UITextField!
    
    @IBOutlet weak var Todo_title: UITextField!
    
    @IBOutlet weak var Todo_detail: UITextField!
    
    @IBOutlet weak var Todo_type: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myManager:PlannerManager = PlannerManager.sharedInstance
        Date_year.text=String(myManager.selectedDate.year)
        Date_month.text=String(myManager.selectedDate.month)
        Date_day.text=String(myManager.selectedDate.day)

        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //let button = sender as! UIButton
        let button = sender as! UIBarButtonItem
        //tag=100 : Add new todo
        
        if (button.tag == 100){
            guard let dateYear = Int(Date_year.text!) else{
                //call error pop-up
                return
            }
            guard let dateMonth = Int(Date_month.text!) else{
                //call error pop-up
                return
            }
            guard let dateDay = Int(Date_day.text!) else{
                //call error pop-up
                return
            }
  
            guard let todoTitle = Todo_title.text else{
                //call error pop-up
                return
            }
            guard let todoDetail = Todo_detail.text else{
                //call error pop-up
                return
            }
       
            var cshDate:CSHDate = CSHDate(y: dateYear, m: dateMonth, d:dateDay, wd: 0)
            
            var newTodo:Todo = Todo(title: todoTitle, detail: todoDetail, type: .Assignment)
            
            let myManager:PlannerManager = PlannerManager.sharedInstance
            myManager.AddTodo(newDate: cshDate, newTodo: newTodo)
            //myManager.SavePlanner()
        }
    }
}
