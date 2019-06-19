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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let myAlarm:AlarmManager = AlarmManager.sharedInstance
        let NOA:Int = myAlarm.alarms.count
        return [NOA][section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myAlarm:AlarmManager = AlarmManager.sharedInstance
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        //if indexPath.section == 0 {
        cell.textLabel!.text = myAlarm.alarms[indexPath.row].todoTitle
        return cell
        //}
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //if section == 0 {
            return "Assignment"
        //}
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toList(segue:UIStoryboardSegue){
        //tableView.reloadData()
        print("asdfasdfasdfasdf")
    }

}
