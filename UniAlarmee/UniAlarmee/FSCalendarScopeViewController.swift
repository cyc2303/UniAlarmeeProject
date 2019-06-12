//
//  FSCalendarScopeViewController.swift
//  FSCalendarSwiftExample
//
//  Created by dingwenchao on 30/12/2016.
//  Copyright © 2016 wenchao. All rights reserved.
//

import UIKit
import OpenAPI_SDK_FW

class FSCalendarScopeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var animationSwitch: UISwitch!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    
    //load the data from db and set. work just once
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        
        self.calendar.select(Date())
        
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .week
        
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
        //get the data from db. example
        //singleton pattern
        var cshtoday:CSHDate = CSHDate(y: 2019, m: 5, d: 5, wd: 0)
        var myManager:PlannerManager = PlannerManager.sharedInstance
        var myAlarm:AlarmManager = AlarmManager.sharedInstance
        var newTodo:Todo = Todo(title: "study souce", detail: "chili souce", type: .Assignment)
        var newTodo2:Todo = Todo(title: "watch end game", detail: "no spo", type: .Normal)
        
        myManager.AddTodo(newDate: cshtoday, newTodo: newTodo)
        myManager.AddTodo(newDate: cshtoday, newTodo: newTodo2)
        
        var newTodo3:Todo = Todo(title: "성주놀리기", detail:"우냐?", type: .Normal)
        myManager.AddTodo(newDate: cshtoday, newTodo: newTodo3)
        
        //set the clicked dates.
        let selectedDates = self.calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        let date_String =  selectedDates[0].components(separatedBy: "/")
        let date_Int = date_String.map({Int($0)!})
        myManager.RenewSelectedDate( selected_date: CSHDate(y: date_Int[0], m: date_Int[1], d: date_Int[2], wd: 0))
        
        

    }
    
    deinit {
        print("\(#function)")
    }
    
    // MARK:- UIGestureRecognizerDelegate
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    //if selected date is changed, renew the infromation of myManager
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
        let date_String =  selectedDates[0].components(separatedBy: "/")
        let date_Int = date_String.map({Int($0)!})
        let myManager:PlannerManager = PlannerManager.sharedInstance
        myManager.RenewSelectedDate( selected_date: CSHDate(y: date_Int[0], m: date_Int[1], d: date_Int[2], wd: 0))
        tableView.reloadData()
        
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    // MARK:- UITableViewDataSource
    
    //show 2 sections. 2 is the number of Todo species. Assignment and normal.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //set the frame of List(Todo List)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(calendar.currentPage)
    
        let myManager:PlannerManager = PlannerManager.sharedInstance
        let selectedDate=myManager.selectedDate
        
        guard let oneDayPlanner = myManager.planner[selectedDate.year][selectedDate.month][selectedDate.day] else{
            return [0,0][section]
        }
        
        let NOA:Int = oneDayPlanner.NumOfAssignment()
        let NOT:Int = oneDayPlanner.NumOfNormal()
        return [NOA, NOT][section]
    }
    
    //show the data in each section. in this project, just show one data.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var myManager:PlannerManager = PlannerManager.sharedInstance
        let selectedDate=myManager.selectedDate
        let oneDayPlanner = myManager.planner[selectedDate.year][selectedDate.month][selectedDate.day]!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if indexPath.section == 0 {
            let tmpList = oneDayPlanner.todoList.filter{$0.type.typeTitle == "Assignment"}
            cell.textLabel!.text = tmpList[indexPath.row].todoTitle
            return cell
        } else {
            let tmpList = oneDayPlanner.todoList.filter{$0.type.typeTitle == "Normal"}
            cell.textLabel!.text = tmpList[indexPath.row].todoTitle
            return cell
        }
        /*
        if indexPath.section == 0 {
            let identifier = ["cell_month", "cell_week"][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            return cell
        }
        */
    }
    
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let scope: FSCalendarScope = (indexPath.row == 0) ? .month : .week
            self.calendar.setScope(scope, animated: self.animationSwitch.isOn)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // MARK:- Target actions
    
    @IBAction func toggleClicked(sender: AnyObject) {
        if self.calendar.scope == .month {
            self.calendar.setScope(.week, animated: self.animationSwitch.isOn)
        } else {
            self.calendar.setScope(.month, animated: self.animationSwitch.isOn)
        }
    }

    @IBAction func toBase(segue:UIStoryboardSegue){
        tableView.reloadData()
        print("asdfasdfasdfasdf")
    }
    
    //link to the addTodoView
    @IBAction func addWork(sender: AnyObject) {
        /*
        var cshtoday:CSHDate = CSHDate(y: 2019, m: 5, d: 5, wd: 0)
        var myManager:PlannerManager = PlannerManager.sharedInstance
        var myAlarm:AlarmManager = AlarmManager.sharedInstance
        var newTodo:Todo = Todo(title: "Soybean souce", detail: "hot souce", type: .Assignment)
        */
        //myManager.AddTodo(newDate: cshtoday, newTodo: newTodo)
        //print("add")
        //tableView.reloadData()
        print("GOTO AddWork")
    }
    @IBAction func testAPI(_ sender: Any) {
        print("GOTO APIView")
    }
}
