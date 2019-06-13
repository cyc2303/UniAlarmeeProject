//
//  DataCenter.swift
//  how_to_use_webview
//
//  Created by dajinHan on 13/06/2019.
//  Copyright © 2019 Choi Yechan. All rights reserved.
//

import Foundation
import Alamofire


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
    var selectedDate:CSHDate = CSHDate(y: 1997, m: 4, d: 7, wd: 1)
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
    
    func RenewSelectedDate(selected_date:CSHDate){
        self.selectedDate=selected_date
    }
    
    // functions for app
    // newDate = 추가한 날, newTodo안에있는 기한 = 기한
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

class Post{
    var title:String
    var detail:String?
    var dueDate:CSHDate?
    var dueTime:CSHTime?
    var type:PostType
    
    enum PostType{
        case Normal
        case Announcement
        
        var typeTitle:String{
            get{
                var titleString:String
                switch self{
                case .Normal:
                    titleString="Normal"
                case .Announcement:
                    titleString="Announcement"
                }
                return titleString
            }
        }
    }
    
    init(title:String, detail:String, type:PostType) {
        self.title=title
        self.detail=detail
        self.type = type
    }
    
    convenience init(title:String, detail:String, dueDate:CSHDate, dueTime:CSHTime, type:PostType) {
        self.init(title:title, detail:detail, type:type)
        self.dueDate=dueDate
        self.dueTime=dueTime
    }
    
}

class Course{
    var id:String = ""
    var announcementPostId:String = ""
    init(id:String) {
        self.id=id
    }
    func RenewPostInformation(){
    Alamofire.request("https://learn.hanyang.ac.kr/learn/api/public/v1/courses/\(id)/contents/").responseJSON { response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                let postsD = JSON.object(forKey: "results") as! [NSDictionary]
                for pidx in 0...0 {
                    var wid:String = postsD[pidx].object(forKey: "id") as! String
                    print(wid)
                    self.announcementPostId = wid
                    
                }
            }
        }
    }
    func RenewAssignmentsInformation(){
    Alamofire.request("https://learn.hanyang.ac.kr/learn/api/public/v1/courses/\(self.id)/contents/\(self.announcementPostId)/children").responseJSON { response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                let childrens = JSON.object(forKey: "results") as! [NSDictionary]
                for cidx in 0..<childrens.count {
                    var wid:String = childrens[cidx].object(forKey: "title") as! String
                    print(wid)
                }
            }
        }
    }
}

class BlackboardManager{
    static let sharedInstance: BlackboardManager = {
        let instance = BlackboardManager()
        return instance
    }()
    
    var userId:String = ""
    var courses:[Course] = []
    init(){
        Alamofire.request( "https://learn.hanyang.ac.kr/ultra/institution-page/effective").responseString { response in
            //debugPrint(response)
            var html_String:String = response.result.value!
            self.userId = self.KMP(S: Array("/" + html_String), P: Array(String("/,\"id\":\"")))
        }
    }
    
    func RenewCourseInformation(){
        Alamofire.request( "https://learn.hanyang.ac.kr/learn/api/public/v1/users/\(self.userId)/courses").responseJSON { response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                let courseD = JSON.object(forKey: "results") as! [NSDictionary]
                for cidx in 0..<courseD.count{
                    var cid:String = courseD[cidx].object(forKey: "courseId") as! String
                    print(cid)
                    self.courses.append(Course(id: cid))
                    self.courses[cidx].RenewPostInformation()
                }
            }
        }
    }
    
    func KMP(S:[Character], P:[Character]) -> String{
        //set failureFunction
        var F:[Int] = Array(repeating: 0,count: 10)
        let pl:Int = P.count - 1
        let sl:Int = S.count - 1
        var j:Int = 0
        for now in 2...pl {
            while j != 0 && P[now] != P[j+1] {
                j = F[j]
            }
            if P[now] == P[j+1]{
                j = j+1
            }
            F[now] = j
        }
        //do kmp
        var i:Int = 0
        var cnt:Int = 0
        var answers:[Int] = []
        
        var answerID:[Character]=[]
        
        for now in 1...sl {
            while i != 0 && S[now] != P[i+1]{
                i = F[i]
            }
            if S[now] == P[i+1]{
                i = i+1
            }
            if i == pl {
                answers.append(now - pl + 1)
                cnt = cnt+1
                i = F[i]
            }
        }
        
        for idx in answers[0]+pl..<answers[0]+pl+10 {
            if S[idx]=="\"" {
                break
            }
            answerID.append(S[idx])
            print(S[idx], terminator: "")
        }
        return String(answerID)
    }
    // manage data
    func LoadData(){
        
    }
    func SaveData(){
        
    }
    func RenewAll(){
        
    }
}


/*
 //singleton pattern
 var today:Date = Date(y: 2019, m: 5, d: 5, wd: 0)
 var myManager:PlannerManager = PlannerManager.sharedInstance
 var myAlarm:AlarmManager = AlarmManager.sharedInstance
func getUserId(completion: @escaping (String) -> Void) {
    Alamofire.request( "https://learn.hanyang.ac.kr/ultra/institution-page/effective").responseString { response in
        //debugPrint(response)
        var html_String:String = response.result.value!
        print(html_String)
        
        userID = self.KMP(S: Array("/" + html_String), P: Array(String("/,\"id\":\"")), answerLength:8)
    }
}
*/
