//
//  DataCenter.swift
//  FSCalendarSwiftExample
//
//  Created by dajinHan on 16/05/2019.
//  Copyright © 2019 wenchao. All rights reserved.
//

import Foundation

class CSHTime{
    var hour:Int
    var minute:Int
    
    init(h:Int, m:Int){
        self.hour=h
        self.minute=m
    }
}

class ClassTime{
    var startTime:CSHTime
    var endTime:CSHTime
    var weekday:Int
    init(st:CSHTime, et:CSHTime, wd:Int){
        self.startTime=st
        self.endTime=et
        self.weekday=wd
    }
}

class CSHDate{
    var year:Int
    var month:Int
    var day:Int
    var weekday:Int
    init(y:Int, m:Int, d:Int, wd:Int){
        self.year=y
        self.month=m
        self.day=d
        self.weekday=wd
    }
}


class Todo{
    var todoTitle:String
    var todoDetail:String?
    var dueDate:CSHDate?
    var dueTime:CSHTime?
    var type:TodoType
    
    enum TodoType{
        case Normal
        case Assignment
        
        var typeTitle:String{
            get{
                var titleString:String
                switch self{
                case .Normal:
                    titleString="Normal"
                case .Assignment:
                    titleString="Assignment"
                }
                return titleString
            }
        }
    }
    
    init(title:String, detail:String, type:TodoType) {
        self.todoTitle=title
        self.todoDetail=detail
        self.type = type
    }
    
    convenience init(title:String, detail:String, dueDate:CSHDate, type:TodoType) {
        self.init(title:title, detail:detail, type:type)
        self.dueDate=dueDate
        self.dueTime=CSHTime(h: 23,m: 59)
    }
    
    convenience init(title:String, detail:String, dueDate:CSHDate, dueTime:CSHTime, type:TodoType) {
        self.init(title:title, detail:detail, type:type)
        self.dueDate=dueDate
        self.dueTime=dueTime
    }
}

class OneDayPlanner{
    var date:CSHDate
    var todoList:[Todo] = []
    
    init(date:CSHDate){
        self.date = date
    }
    func NumOfNormal() -> Int{
        let tmpList = todoList.filter{$0.type.typeTitle == "Normal"}
        return tmpList.count
    }
    func NumOfAssignment() -> Int{
        let tmpList = todoList.filter{$0.type.typeTitle == "Assignment"}
        return tmpList.count
    }
}

class PlannerManager{
    static let sharedInstance : PlannerManager = {
        let instance = PlannerManager()
        return instance
    }()
    
    var todayDate:CSHDate = CSHDate(y: 1997, m: 4, d: 7, wd: 1)
    var planner:[[[OneDayPlanner?]]] = Array(repeating:Array(repeating:Array(repeating:nil, count:32),count:13),count:3000)
    
    private init(){
    }
    
    // manage the disk data
    func LoadPlanner(){
        
    }
    func SavePlanner(){
        
    }
    func UpdateDate(){
        
    }
    
    // functions for app
    func AddTodo(newDate:CSHDate, newTodo:Todo){
        if (planner[newDate.year][newDate.month][newDate.day] == nil){
            planner[newDate.year][newDate.month][newDate.day] = OneDayPlanner(date: newDate)
        }
        self.planner[newDate.year][newDate.month][newDate.day]!.todoList.append(newTodo)
        if (newTodo.type.typeTitle != "Normal"){
            let myAlarm = AlarmManager.sharedInstance
            myAlarm.AddAlarm(newAlarm: newTodo)
        }
    }
    func DeleteTodo(){
        
    }
    func LoadTodo(){
        
    }
}

class AlarmManager{
    static let sharedInstance: AlarmManager = {
        let instance = AlarmManager()
        return instance
    }()
    
    var today:CSHDate = CSHDate(y: 1997, m: 4, d: 7, wd: 1)
    var alarms:[Todo] = []
    
    private init(){
    }
    
    // manage data
    func LoadData(){
        
    }
    func SaveData(){
        
    }
    func RenewAlarm(){
        
    }
    func UpdateDate(){
        
    }
    
    func AddAlarm(newAlarm:Todo){
        self.alarms.append(newAlarm)
    }
}

/*
 //singleton pattern
 var today:Date = Date(y: 2019, m: 5, d: 5, wd: 0)
 var myManager:PlannerManager = PlannerManager.sharedInstance
 var myAlarm:AlarmManager = AlarmManager.sharedInstance
 myManager
 
 var newTodo:Todo = Todo(title: "study souce", detail: "chili souce", type: .Assignment)
 myManager.AddTodo(newDate: today, newTodo: newTodo)
 
 myManager.planner[today.year][today.month][today.day]!.todoList[0]
 myAlarm.alarms[0]
 */
