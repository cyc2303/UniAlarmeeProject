//
//  table.swift
//  how_to_use_textfield
//
//  Created by Choi Yechan on 17/05/2019.
//  Copyright © 2019 Choi Yechan. All rights reserved.
//

import UIKit

class table: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    //
    
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YunniArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "asdf", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        cell.detailTextLabel?.text = YunniArray[indexPath.row].id
        //cell.imageView 텍스트라벨, 디테일텍스트라벨, 이미지뷰는 기본적으로 있지만 나타나지 않는 경우가 존재하기 때문에 이렇게 옵셔널로 지정이 되어 있음
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 데이터 삭제
        YunniArray.remove(at:indexPath.row) 
        // 셀 삭제
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
