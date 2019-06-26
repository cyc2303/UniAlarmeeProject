//
//  SettingViewController.swift
//  UniAlarmee
//
//  Created by Choi Yechan on 14/06/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var loginID:String = "로그인 되지 않음"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func Login(){
        if let uvc = storyboard?.instantiateViewController(withIdentifier: "Login"){
            self.navigationController?.pushViewController(uvc, animated: false)
            //self.present(uvc,animated: false)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let loginCell = tableView.dequeueReusableCell(withIdentifier: "Login", for: indexPath)
        loginCell.textLabel?.text = "로그인"
        loginCell.detailTextLabel?.text = loginID
        loginCell.detailTextLabel?.textColor = .gray
        if indexPath.row==0 {
            return loginCell
        }
        else{
            return tableView.dequeueReusableCell(withIdentifier: "nothing", for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==0 {
            performSegue(withIdentifier: "LoginSelect", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
 
    //unwind segue
    @IBAction func log(segue:UIStoryboardSegue){
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
