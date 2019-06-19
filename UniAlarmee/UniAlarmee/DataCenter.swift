//
//  DataCenter.swift
//  how_to_use_webview
//
//  Created by dajinHan on 13/06/2019.
//  Copyright © 2019 Choi Yechan. All rights reserved.
//

import Foundation
import Alamofire


class CSHTime : Codable {
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

class CSHDate : Codable {
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
    var todoDetail:String
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
        load_json()
        print(todos_for_load.count)
        for i in 0..<todos_for_load.count{
            print(todos_for_load[i])
            if todos_for_load[i].type == "Normal"{
                var tmpTodo:Todo = Todo(title: todos_for_load[i].todoTitle, detail: todos_for_load[i].todoDetail, type:.Normal)
                if todos_for_load[i].dueDate != nil{
                    tmpTodo.dueDate = todos_for_load[i].dueDate!
                }
                if todos_for_load[i].dueTime != nil{
                    tmpTodo.dueTime = todos_for_load[i].dueTime!
                }
                AddTodo(newDate:todos_for_load[i].createDate, newTodo:tmpTodo)
            }
            else{
                var tmpTodo:Todo = Todo(title: todos_for_load[i].todoTitle, detail: todos_for_load[i].todoDetail, type:.Assignment)
                if todos_for_load[i].dueDate != nil{
                    tmpTodo.dueDate = todos_for_load[i].dueDate!
                }
                if todos_for_load[i].dueTime != nil{
                    tmpTodo.dueTime = todos_for_load[i].dueTime!
                }
                AddTodo(newDate:todos_for_load[i].createDate, newTodo:tmpTodo)
            }
            
        }
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
        if newTodo.type.typeTitle != "Normal"{
            let myAlarm = AlarmManager.sharedInstance
            myAlarm.AddAssignment(newAssignment: newTodo)
        }
        
        //add to Codable
        var jsonTodo:JSON_Todo=JSON_Todo(title: newTodo.todoTitle, detail: newTodo.todoDetail, type: newTodo.type.typeTitle, date: newDate)
        
        if newTodo.dueDate != nil{
            jsonTodo.dueDate = newTodo.dueDate!
        }
        if newTodo.dueTime != nil{
            jsonTodo.dueTime = newTodo.dueTime!
        }
        todos_for_save.append(jsonTodo)
        save_json()
        //end codable
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
    var assignments:[Todo] = []
    var announcements:[Post] = []
    
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
    
    func AddAssignment(newAssignment:Todo){
        self.assignments.append(newAssignment)
    }
    func AddAnnouncement(newAnnouncement:Post){
        self.announcements.append(newAnnouncement)
    }
}

class Post{
    var id:String
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
    
    init(id:String, title:String, detail:String, type:PostType) {
        self.id=id
        self.title=title
        self.detail=detail
        self.type = type
    }
    
    convenience init(id:String, title:String, detail:String, dueDate:CSHDate, dueTime:CSHTime, type:PostType) {
        self.init(id:id, title:title, detail:detail, type:type)
        self.dueDate=dueDate
        self.dueTime=dueTime
    }
    
}

class Board{
    var course_id:String = ""
    var id:String=""
    var title:String=""
    var hasChildren:Bool=false
    var posts:[Post] = []
    init(cid:String, bid:String, title:String, hasChild:Bool){
        self.course_id=cid
        self.id=bid
        self.title=title
        self.hasChildren=hasChild
    }
    func RenewPosts(){    Alamofire.request("https://learn.hanyang.ac.kr/learn/api/public/v1/courses/\(self.course_id)/contents/\(self.id)/children").responseJSON { response in
        if let result = response.result.value {
            let JSON = result as! NSDictionary
            let posts = JSON.object(forKey: "results") as! [NSDictionary]
            for post_idx in 0..<posts.count {
                var pid:String = posts[post_idx].object(forKey: "id") as! String
                var ptitle:String = posts[post_idx].object(forKey: "title") as! String
                var pdetail:String = String(" ")
                self.posts.append(Post(id: pid, title: ptitle, detail: pdetail, type: .Normal))
                print("boardId: \(self.id), board title: \(self.title), postId: \(pid), postTitle: \(ptitle)")
                
                //add to JSON and Alarm
                if self.title == "과제" {
                    var myAlarm:AlarmManager = AlarmManager.sharedInstance
                    myAlarm.announcements.append(Post(id: pid, title: ptitle, detail: pdetail, type: .Announcement))
                    posts_for_save.append(JSON_Post(title: ptitle, detail: pdetail, type: "Announcement"))
                }
                else{
                    posts_for_save.append(JSON_Post(title: ptitle, detail: pdetail, type: "Normal"))
                }
                
            }
        }
        }
    }
}

class Course{
    var id:String = ""
    var announcementBoard:Board = Board(cid: "0", bid: "0", title: "0", hasChild: false)
    var assignmentBoard:Board = Board(cid: "0", bid: "0", title: "0", hasChild: false)
    //var otherBoards:[Board]
    
    init(id_:String) {
        self.id=id_
    }
    
    func RenewAssignmentBoard(){
        Alamofire.request("https://learn.hanyang.ac.kr/learn/api/public/v1/courses/\(id)/contents/").responseJSON { response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                let boardDictionary = JSON.object(forKey: "results") as! [NSDictionary]
                if boardDictionary.count==0{
                    return
                }
                for board_idx in 0...0 {
                    if boardDictionary[board_idx].object(forKey: "hasChildren") == nil {
                        return
                    }
                    var board_id:String = boardDictionary[board_idx].object(forKey: "id") as! String
                    var board_title:String = boardDictionary[board_idx].object(forKey: "title") as! String
                    var board_hasChildren:Bool = boardDictionary[board_idx].object(forKey: "hasChildren") as! Bool
                    print("courseId: \(self.id), assignment board : \(board_id), title: \(board_title)")
                    self.assignmentBoard = Board(cid: self.id, bid: board_id, title: board_title, hasChild: board_hasChildren)
                }
                self.assignmentBoard.RenewPosts()
            }
        }
    }
    
    func RenewAnnouncementBoard(){
        Alamofire.request("https://learn.hanyang.ac.kr/learn/api/public/v1/courses/\(id)/contents/").responseJSON { response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                let boardDictionary = JSON.object(forKey: "results") as! [NSDictionary]
                if boardDictionary.count <= 1{
                    return
                }
                for board_idx in 1...1 {
                    if boardDictionary[board_idx].object(forKey: "hasChildren") == nil {
                        return
                    }
                    var board_id:String = boardDictionary[board_idx].object(forKey: "id") as! String
                    var board_title:String = boardDictionary[board_idx].object(forKey: "title") as! String
                    var board_hasChildren:Bool = boardDictionary[board_idx].object(forKey: "hasChildren") as! Bool
                    print("courseId: \(self.id), announcement board : \(board_id), title: \(board_title)")
                    self.announcementBoard = Board(cid: self.id, bid: board_id, title: board_title, hasChild: board_hasChildren)
                }
                self.announcementBoard.RenewPosts()
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
        RenewUserId()
    }
    
    func RenewUserId(){
        Alamofire.request( "https://learn.hanyang.ac.kr/ultra/institution-page/effective").responseString { response in
            var html_String:String = response.result.value!
            self.userId = self.KMP(S: Array("/" + html_String), P: Array(String("/,\"id\":\"")))
            self.RenewCourseInformation()
        }
        
    }
    func RenewCourseInformation(){
        Alamofire.request( "https://learn.hanyang.ac.kr/learn/api/public/v1/users/\(self.userId)/courses").responseJSON { response in
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                let courseDictionary = JSON.object(forKey: "results") as! [NSDictionary]
                for course_idx in 0..<courseDictionary.count{
                    var cid:String = courseDictionary[course_idx].object(forKey: "courseId") as! String
                    print(cid)
                    
                    //append방식이여서, 계속하면 쌓일것이다. 나중에 생각해서 고쳐라.
                    self.courses.append(Course(id_: cid))
                    self.courses[course_idx].RenewAssignmentBoard()
                    self.courses[course_idx].RenewAnnouncementBoard()
                    
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

struct JSON_Todo : Codable{
    var todoTitle:String
    var todoDetail:String
    var createDate:CSHDate
    var dueDate:CSHDate? = nil
    var dueTime:CSHTime? = nil
    var type:String
    init(title:String, detail:String, type:String, date:CSHDate){
        self.todoTitle=title
        self.todoDetail=detail
        self.type=type
        self.createDate=date
    }
}

struct JSON_Post : Codable {
    var postTitle:String
    var postDetail:String
    var postDate:CSHDate? = nil
    var postTime:CSHTime? = nil
    var type:String
    init(title:String, detail:String, type:String){
        self.postTitle=title
        self.postDetail=detail
        self.type=type
    }
}

var todos_for_load:[JSON_Todo] = []
var posts_for_load:[JSON_Post] = []
var todos_for_save:[JSON_Todo] = []
var posts_for_save:[JSON_Post] = []
var todos_for_reset:[JSON_Todo] = []
var posts_for_reset:[JSON_Post] = []

func save_json(){
    UserDefaults.standard.set(try? PropertyListEncoder().encode(todos_for_save), forKey: "todos")
    UserDefaults.standard.set(try? PropertyListEncoder().encode(posts_for_save), forKey: "posts")
}

func load_json(){
    if let data = UserDefaults.standard.object(forKey: "todos") as? Data{
        todos_for_load = try! PropertyListDecoder().decode([JSON_Todo].self, from: data)
    }
    if let data = UserDefaults.standard.object(forKey: "posts") as? Data{
        posts_for_load = try! PropertyListDecoder().decode([JSON_Post].self, from: data)
    }
}

