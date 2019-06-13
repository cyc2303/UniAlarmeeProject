//
//  vc.swift
//  UniAlarmee
//
//  Created by Choi Yechan on 13/06/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit

class vc: UIViewController {
    var didLogin:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if didLogin == false {
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let uvc = storyboard.instantiateViewController(withIdentifier: "Webview")
            self.present(uvc,animated: false, completion: nil)
            print("ㅁㄴㅇㄹ")
            didLogin = true
        }
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
