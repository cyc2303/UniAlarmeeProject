//
//  AddTodoViewController.swift
//  UniAlarmee
//
//  Created by dajinHan on 23/05/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBOutlet weak var pic: UIPickerView!
    private let values: [String] = ["Normal", "Assignment"]
    var isAssignment: Bool = false

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            isAssignment = false
        }
        else {
            isAssignment = true
        }
    }
    
    //@IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var tle: UITextField!
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        if indexPath.row==0 {
            return cell1
        }
        else{
            return tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        }
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1    }
    
    */
    @IBAction func Picdate(_ sender: UIDatePicker) {
        
        sender.addTarget(self, action: #selector(change(sender:)), for: .valueChanged)
    }
    func parseDate(date:String) -> [Int]{
        var chars:[Character] = Array(date)
        var days:[Int]=[0,0,0]
        var idx:Int = 0
        print("day is : ", date)
        for i in 0..<chars.count{
            if chars[i] == "-" || chars[i] == " " {
                idx = idx+1
                if idx == 3 {
                    break
                }
            }
            else{
                days[idx] = days[idx]*10 + Int(String(chars[i]))!
            }
            if chars[i] == " "{
                continue
            }
        }
        return days
    }
    
    var dyear : Int = 0
    var dmonth : Int = 0
    var dday : Int = 0
    
    
    @objc func change(sender: UIDatePicker){
        let dateformatter : DateFormatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .medium
        //let a = dateformatter.string(from: sender.date)
        let result:[Int]=parseDate(date:sender.date.description)
        print(result)
        dyear=result[0]
        dmonth=result[1]
        dday=result[2]

       // print(result[0])
        //print(dm)
        //print(dday)
    }
    
    
// @IBOutlet weak var Todo_title: UITextField!
    
// @IBOutlet weak var Todo_detail: UITextField!
    
    @IBOutlet weak var Todo_type: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myManager:PlannerManager = PlannerManager.sharedInstance
        print("viewDidLoad:", myManager.selectedDate)
        
        let calendar = Calendar(identifier: .gregorian)
        //let comps = DateComponents(year:myManager.selectedDate.year, month:myManager.selectedDate.month, day:myManager.selectedDate.day)

        let targetDate: Date? = {
            let comps = DateComponents(calendar:calendar, year:myManager.selectedDate.year, month:myManager.selectedDate.month, day:myManager.selectedDate.day)
            return comps.date
        }()
        print(datePicker.date)
        datePicker.setDate(targetDate!, animated: true)
        print(datePicker.date)
 
    
        //AllDaySwitch.isOn = true
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
            let myManager:PlannerManager = PlannerManager.sharedInstance

            var dateYear = dyear
            var dateMonth = dmonth
            var dateDay = dday
            
            if dateYear==0 {
                dateYear = myManager.selectedDate.year
            }
            if dateMonth==0 {
                dateMonth = myManager.selectedDate.month
            }
            if dateDay==0 {
                dateDay = myManager.selectedDate.day
            }
            guard let todoTitle = tle.text else{
                //call error pop-up
                return
            }
            guard let todoDetail = place.text else{
                //call error pop-up
                return
            }
       
            var cshDate:CSHDate = CSHDate(y: dateYear, m: dateMonth, d:dateDay, wd: 0)
            var newTodo:Todo = Todo(title: todoTitle, detail: todoDetail, type: .Normal)
            if isAssignment {
                newTodo = Todo(title: todoTitle, detail: todoDetail, type: .Assignment)
            }
            myManager.AddTodo(newDate: cshDate, newTodo: newTodo)
            //myManager.SavePlanner()
            
        }
    }
}
